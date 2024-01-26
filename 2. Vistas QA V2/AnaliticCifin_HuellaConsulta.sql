CREATE OR ALTER VIEW AnaliticCifinHuellaConsulta
as 
SELECT 
convert(date,CifinTest_HuellaConsulta_Consulta.FechaConsulta,103) as FechaConsulta1,
CifinTest_HuellaConsulta_Consulta.NombreTipoEntidad,
CifinTest_HuellaConsulta_Consulta.NombreEntidad,
CifinTest_HuellaConsulta_Consulta.Sucursal,
CifinTest_HuellaConsulta_Consulta.Ciudad,
CifinTest_HuellaConsulta_Consulta.MotivoConsulta,
CifinTest_HuellaConsulta_Consulta.CodigoTipoEntidad,
CifinTest_HuellaConsulta_Consulta.CodigoEntidad,
docs.HuellaConsulta_Consulta,
docs.NumeroIdentificacion,
docs.TipoIdentificacion,
docs.id,
docs.Fecha,
docs.Hora
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( HuellaConsulta_Consulta VARCHAR(MAX) '$.HuellaConsulta.Consulta',
       NumeroIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	   id VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Hora                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
      ) as docs
 OUTER APPLY OPENJSON ( HuellaConsulta_Consulta )
		 WITH (
			FechaConsulta VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NombreTipoEntidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NombreEntidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Sucursal VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Ciudad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			MotivoConsulta VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CodigoTipoEntidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CodigoEntidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8		
		) AS CifinTest_HuellaConsulta_Consulta
INNER JOIN 
(SELECT docs1.NumeroIdentificacion,MAX(CONVERT (VARCHAR, docs1.fecha, 103)) as fecha 
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( 
		NumeroIdentificacion        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
    ) as docs1 GROUP BY NumeroIdentificacion) 
    as maximo on docs.NumeroIdentificacion = maximo.NumeroIdentificacion and CONVERT(VARCHAR, docs.fecha, 103) = maximo.fecha
