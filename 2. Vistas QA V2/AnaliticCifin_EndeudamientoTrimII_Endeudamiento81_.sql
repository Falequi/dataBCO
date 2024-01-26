CREATE OR ALTER VIEW AnaliticCifinEndeudamientoTrimI_Endeudamiento81
as 
SELECT
docs.NumeroIdentificacion,
docs.TipoIdentificacion,
docs.id,
docs.Fecha,
docs.Hora,
CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.Calificacion,
CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.TipoModena,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[NumeroOperacionesComercial], '.', '') as NumeroOperacionesComercialSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[NumeroOperacionesConsumo], '.', '') as NumeroOperacionesConsumoSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[NumeroOperacionesVivienda], '.', '') as NumeroOperacionesViviendaSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[NumeroOperacionesMicrocredito], '.', '') as NumeroOperacionesMicrocreditoSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[ValorDeudaComercial], '.', '') as ValorDeudaComercialSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[ValorDeudaConsumo], '.', '') as ValorDeudaConsumoSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[ValorDeudaVivienda], '.', '') as ValorDeudaViviendaSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[ValorDeudaMicrocredito], '.', '') as ValorDeudaMicrocreditoSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[Total], '.', '') as TotalSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[ParticipacionTotalDeudas], '.', '') as ParticipacionTotalDeudasSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[CubrimientoGarantiaComercial], '.', '') as CubrimientoGarantiaComercialSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[CubrimientoGarantiaConsumo], '.', '') as CubrimientoGarantiaConsumoSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[CubrimientoGarantiaVivienda], '.', '') as CubrimientoGarantiaViviendaSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81.[CubrimientoGarantiaMicrocredito], '.', '') as CubrimientoGarantiaMicrocreditoSinPunto
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( Endeudamiento_EndeudamientoTrimII_Endeudamiento81 VARCHAR(MAX) '$.Endeudamiento.EndeudamientoTrimII.Endeudamiento81',
       NumeroIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    id VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Hora                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
) as docs
 OUTER APPLY OPENJSON ( Endeudamiento_EndeudamientoTrimII_Endeudamiento81 )
		 WITH (
			Calificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoModena VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroOperacionesComercial VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroOperacionesConsumo VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroOperacionesVivienda VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroOperacionesMicrocredito VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorDeudaComercial VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorDeudaConsumo VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorDeudaVivienda VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorDeudaMicrocredito VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Total VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ParticipacionTotalDeudas VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CubrimientoGarantiaComercial VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CubrimientoGarantiaConsumo VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CubrimientoGarantiaVivienda VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CubrimientoGarantiaMicrocredito VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8		
		) AS CifinTest_Endeudamiento_EndeudamientoTrimII_Endeudamiento81

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
    