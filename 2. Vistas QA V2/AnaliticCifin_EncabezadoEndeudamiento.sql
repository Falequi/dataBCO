CREATE OR ALTER VIEW AnaliticCifinEndeudamientoEncabezado
as 
SELECT 
docs.NumeroIdentificacion,
docs.TipoIdentificacion,
docs.id,
docs.Fecha,
docs.Hora,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroEntidadesTrimestreI,
docs.Endeudamiento_EncabezadoEndeudamiento_FechaTrimestreI,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroEntidadesTrimestreII,
docs.Endeudamiento_EncabezadoEndeudamiento_FechaTrimestreII,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroEntidadesTrimestreIII,
docs.Endeudamiento_EncabezadoEndeudamiento_FechaTrimestreIII,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroComprasTrimestreI,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroComprasTrimestreII,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroComprasTrimestreIII,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroReestructuracionesTrimestreI,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroReestructuracionesTrimestreII,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroReestructuracionesTrimestreIII,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroCastigosTrimestreI,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroCastigosTrimestreII,
docs.Endeudamiento_EncabezadoEndeudamiento_NumeroCastigosTrimestreIII
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)       
with (  
      NumeroIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      TipoIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		id VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Hora                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      Endeudamiento_EncabezadoEndeudamiento_NumeroEntidadesTrimestreI VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroEntidadesTrimestreI',
		Endeudamiento_EncabezadoEndeudamiento_FechaTrimestreI VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.FechaTrimestreI',
		Endeudamiento_EncabezadoEndeudamiento_NumeroEntidadesTrimestreII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroEntidadesTrimestreII',
		Endeudamiento_EncabezadoEndeudamiento_FechaTrimestreII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.FechaTrimestreII',
		Endeudamiento_EncabezadoEndeudamiento_NumeroEntidadesTrimestreIII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroEntidadesTrimestreIII',
		Endeudamiento_EncabezadoEndeudamiento_FechaTrimestreIII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.FechaTrimestreIII',
		Endeudamiento_EncabezadoEndeudamiento_NumeroComprasTrimestreI VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroComprasTrimestreI',
		Endeudamiento_EncabezadoEndeudamiento_NumeroComprasTrimestreII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroComprasTrimestreII',
		Endeudamiento_EncabezadoEndeudamiento_NumeroComprasTrimestreIII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroComprasTrimestreIII',
		Endeudamiento_EncabezadoEndeudamiento_NumeroReestructuracionesTrimestreI VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroReestructuracionesTrimestreI',
		Endeudamiento_EncabezadoEndeudamiento_NumeroReestructuracionesTrimestreII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroReestructuracionesTrimestreII',
		Endeudamiento_EncabezadoEndeudamiento_NumeroReestructuracionesTrimestreIII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroReestructuracionesTrimestreIII',
		Endeudamiento_EncabezadoEndeudamiento_NumeroCastigosTrimestreI VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroCastigosTrimestreI',
		Endeudamiento_EncabezadoEndeudamiento_NumeroCastigosTrimestreII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroCastigosTrimestreII',
		Endeudamiento_EncabezadoEndeudamiento_NumeroCastigosTrimestreIII VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Endeudamiento.EncabezadoEndeudamiento.NumeroCastigosTrimestreIII'
    ) as docs
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