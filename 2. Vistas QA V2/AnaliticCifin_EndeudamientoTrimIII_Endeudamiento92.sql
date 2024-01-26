CREATE OR ALTER VIEW AnaliticCifinEndeudamientoTrimIII_Endeudamiento92
as 
SELECT 
docs.NumeroIdentificacion,
docs.TipoIdentificacion,
docs.id,
docs.Fecha,
docs.Hora,
CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento92.TipoMoneda,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento92.[NumeroContingencias], '.', '') as NumeroContingenciasSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento92.[ValorContingencias], '.', '') as ValorContingenciasSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento92.[CuotaEsperada], '.', '') as CuotaEsperadaSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento92.[CumplimientoCuota], '.', '') as CumplimientoCuotaSinPunto
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( Endeudamiento_EndeudamientoTrimIII_Endeudamiento92 VARCHAR(MAX) '$.Endeudamiento.EndeudamientoTrimIII.Endeudamiento92',
       NumeroIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	   id VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Hora                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
) as docs
 OUTER APPLY OPENJSON (Endeudamiento_EndeudamientoTrimIII_Endeudamiento92 )
		 WITH (
			TipoMoneda VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroContingencias VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorContingencias VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CuotaEsperada VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CumplimientoCuota VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8		
		) AS CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento92
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