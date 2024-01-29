import { AzureFunction, Context, HttpRequest } from "@azure/functions"
import {getValidateFinancialInformationUser} from '../src/model/CifinModel';

const httpTrigger: AzureFunction = async function (context: Context, request: HttpRequest): Promise<void> {

    if (request.body.ping) {
        context.res = {
            status: 200,
            body: 'ping'
        };
    }else{
        context.res = await getValidateFinancialInformationUser(request, context);
    }

};

export default httpTrigger;
