var config:any = {}

config.endpoint = process.env["PARAMETER_COSMOSDB_ENDPOINT"];
config.key = process.env["PARAMETER_COSMOSDB_KEY"];

config.database = {
  id: process.env["PARAMETER_COSMOSDB_DB_ID_NAME"]
}

config.container = {
  id: process.env["PARAMETER_COSMOSDB_CONTAINER_NAME"]
}

export default config;
