import config from '../config/db.config';
import * as CosmosDB from '@azure/cosmos';
import * as moment from 'moment';
import * as momentz from 'moment-timezone';
import {xml2Json} from '../util/xml2json';
import { Output } from '../util/output';
import { HttpRequest, Context } from '@azure/functions';


const CosmosClient = CosmosDB.CosmosClient


const endpoint = config.endpoint
const key = config.key

const databaseId = config.database.id
const containerId = config.container.id
const partitionKey = { kind: 'Hash', paths: ['/Country'] }

const client = new CosmosClient({ endpoint, key })

//var func = this;


/**
 * Read the database definition
 */
/*
func.readDatabase = async function () {
    const { resource: databaseDefinition } = await client
        .database(databaseId)
        .read()
    console.log(`Reading database:\n${databaseDefinition.id}\n`)
}*/


/**
 * Scale a container
 * You can scale the throughput (RU/s) of your container up and down to meet the needs of the workload. Learn more: https://aka.ms/cosmos-request-units
 */
/*
func.scaleContainer = async function () {
    const { resource: containerDefinition } = await client
        .database(databaseId)
        .container(containerId)
        .read()
    const { resources: offers } = await client.offers.readAll().fetchAll();

    const newRups = 500;
    for (var offer of offers) {
        if (containerDefinition._rid !== offer.offerResourceId) {
            continue;
        }
        offer.content.offerThroughput = newRups;
        const offerToReplace = client.offer(offer.id);
        await offerToReplace.replace(offer);
        console.log(`Updated offer to ${newRups} RU/s\n`);
        break;
    }
}*/


/**
 *Save financial information user
 *
 * @param {HttpRequest} req
 * @returns {Promise<Object>}
 */

export const save = async function (req: HttpRequest, context: Context): Promise<Object> {
    const consultaXmlReturn = (req.body && req.body.consultaXmlReturn);
    try {
        if (consultaXmlReturn) {
            context.log('Recibiendo información.');

            let res = await xml2Json(consultaXmlReturn);
            if (res.error) return Output.error('Error almacenando la información de CIFIN.');
            context.log('Transformando Xml2Json');

            res = await xml2Json(res.Envelope.Body.consultaXmlResponse.consultaXmlReturn._);
            context.log('Validando estructura de la información');
            if (res.error) return Output.error('Error almacenando la información de CIFIN.');
            context.log('Almacenando información CIFIN');
            if(parseInt(res.CIFIN.Tercero.IdentificadorLinea) === 0){
                res.CIFIN.Tercero.Fecha = momentz.tz('America/Bogota').format('DD/MM/YYYY');
            }
            const { item } = await client
                .database(databaseId)
                .container(containerId)
                .items.upsert(res.CIFIN.Tercero)
                return Output.ok('Información de CIFIN almacenanda satisfactoriamente.');
        } else {
            console.error('Información no suministrada.')
            return Output.badRequest('Información no suministrada.');
        }
    } catch (error) {
        context.log('Error', error);
        return Output.internalError('Lo sentimos, ocurrió un error durante el registro, por favor intente más tarde.')
    }

}



const validateExpirationData =  (dateCifin: string = '02/05/2020'): boolean => {
    let now = moment(moment(Date.now()).format('DD/MM/YYYY'), 'DD/MM/YYYY');
    let date = moment(dateCifin, 'DD/MM/YYYY');
    let res = now.diff(date, 'days');
    return res <= parseInt(process.env["PARAMETER_CIFIN_EXPIRED_DAY"]);
}

/**
 * Query the container using SQL
 */

const queryContainerOne = async function (TipoIdentificacion: string, NumeroIdentificacion: string) {
    const auxTipoIdentificacion = (parseInt(TipoIdentificacion) == 1)? 'C.C.' : 'NIT';
    const querySpec = {
        query: 'SELECT * FROM root r WHERE (r.CodigoTipoIndentificacion = @TipoIdentificacion or r.TipoIdentificacion = @auxTipoIdentificacion) and r.NumeroIdentificacion = @NumeroIdentificacion order by r._ts desc offset 0 limit 1',
        parameters: [
            {
                name: '@TipoIdentificacion',
                value: `${TipoIdentificacion}`
            },
            {
                name: '@auxTipoIdentificacion',
                value: `${auxTipoIdentificacion}`
            },
            {
                name: '@NumeroIdentificacion',
                value: `${NumeroIdentificacion}`
            }
        ]
    }

    const { resources: results } = await client
        .database(databaseId)
        .container(containerId)
        .items.query(querySpec)
        .fetchAll()

    return (results.length) ? results[0] : null;
}



export const getValidateFinancialInformationUser = async function (req: HttpRequest, context: Context): Promise<Object> {
    try {
        const tipoIdentificacion: string = (req.body && req.body.tipoIdentificacion);
        const numeroIdentificacion: string = (req.body && req.body.numeroIdentificacion);
        context.log('Recibiendo información.');
        if (tipoIdentificacion && numeroIdentificacion) {
            context.log('Consultando información.');
            let data = await queryContainerOne(tipoIdentificacion, numeroIdentificacion);

            if (!data) return Output.okFindInformation('En proceso, por favor intente nuevamente más tarde.', true)

            if (!validateExpirationData(data.Fecha)) return Output.okFindInformation(`No existe información registrada dentro de los últimos ${process.env["PARAMETER_CIFIN_EXPIRED_DAY"]} días.`);
            if (parseInt(data.IdentificadorLinea) === 0) return Output.okNoExistInformation(`No existe información registrada en CIFIN.`,false, data);
            context.log('Consulta exitosa.');
            return Output.ok('Consulta exitosa.', data);
        } else {
            context.log('Información suministrada de manera incorrecta.');
            return Output.badRequest('Información suministrada de manera incorrecta.');
        }
    } catch (error) {
        context.log('Error', error);
        return Output.internalError('Lo sentimos, ocurrió un error durante la consulta, por favor intente más tarde.')
    }

}
