SELECT * FROM(
SELECT *, RANK() OVER (PARTITION BY NumeroIdentificacion ORDER BY Hora DESC) as rankh 
FROM 
(SELECT * FROM 
(SELECT *,RANK() OVER (PARTITION BY NumeroIdentificacion ORDER BY fecha DESC) as rank 
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
       with ( 
        IdentificadorLinea VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		TipoIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		id VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		CodigoTipoIndentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NumeroIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NombreTitular VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NombreCiiu VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		LugarExpedicion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		FechaExpedicion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Estado VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NumeroInforme VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		EstadoTitular VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		RangoEdad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		CodigoCiiu VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		CodigoDepartamento VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		CodigoMunicipio VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Fecha VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Hora VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Entidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		RespuestaConsulta VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
    )
        as docs) as docsk  WHERE rank = 1)as docsl) AS docs2 where rankh =1;