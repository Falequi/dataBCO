CREATE OR ALTER VIEW AnaliticCifinEndeudamientoTrimIII_Endeudamiento91
as 
SELECT 
docs.NumeroIdentificacion,
docs.TipoIdentificacion,
docs.id,
docs.Fecha,
docs.Hora,
CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.Calificacion,
CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.TipoModena,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[CubrimientoGarantiaVivienda], '.', '') as CubrimientoGarantiaViviendaSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[CubrimientoGarantiaMicrocredito], '.', '') as CubrimientoGarantiaMicrocreditoSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[ValorDeudaVivienda], '.', '') as ValorDeudaViviendaSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[ValorDeudaMicrocredito], '.', '') as ValorDeudaMicrocreditoSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[Total], '.', '') as TotalSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[ParticipacionTotalDeudas], '.', '') as ParticipacionTotalDeudasSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[CubrimientoGarantiaComercial], '.', '') as CubrimientoGarantiaComercialSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[CubrimientoGarantiaConsumo], '.', '') as CubrimientoGarantiaConsumoSinPunto,
CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.NumeroOperacionesComercial,
CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.NumeroOperacionesConsumo,
CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.NumeroOperacionesVivienda,
CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.NumeroOperacionesMicrocredito,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[ValorDeudaComercial], '.', '') as ValorDeudaComercialSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91.[ValorDeudaConsumo], '.', '') as ValorDeudaConsumoSinPunto
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( Endeudamiento_EndeudamientoTrimIII_Endeudamiento91 VARCHAR(MAX) '$.Endeudamiento.EndeudamientoTrimIII.Endeudamiento91',
       NumeroIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	   id VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Hora                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
) as docs
 OUTER APPLY OPENJSON ( Endeudamiento_EndeudamientoTrimIII_Endeudamiento91 )
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
		) AS CifinTest_Endeudamiento_EndeudamientoTrimIII_Endeudamiento91
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