import * as xml2js from 'xml2js';
const stripNS = xml2js.processors.stripPrefix;


/**
 * Función útilizada para convertir de formato xml a json
 *
 * @param {*} xml
 * @returns {Promise<any>}
 */

export const xml2Json = async (xml): Promise<any> =>{
   
   let parser = new xml2js.Parser({ explicitArray: false, tagNameProcessors: [stripNS], });
   let result = await new Promise((resolve, reject) => parser.parseString(xml, function (error, res) {
      if (error) reject(error);
      else resolve(res);
   }))

   return result;
}
