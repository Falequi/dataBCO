CREATE OR ALTER VIEW AnaliticCifinEndeudamientoTrimI_Endeudamiento71
as 
SELECT 
   docs.NumeroIdentificacion,
   docs.TipoIdentificacion,
   docs.id,
   CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.Calificacion,
   CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.TipoModena,
   docs.Fecha,
   docs.Hora,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[CubrimientoGarantiaVivienda], '.', '') as CubrimientoGarantiaViviendaSinPunto,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[CubrimientoGarantiaMicrocredito], '.', '') as CubrimientoGarantiaMicrocreditoSinPunto,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[ValorDeudaVivienda], '.', '') as ValorDeudaViviendaSinPunto,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[ValorDeudaMicrocredito], '.', '') as ValorDeudaMicrocreditoSinPunto,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[Total], '.', '') as TotalSinPunto,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[ParticipacionTotalDeudas], '.', '') as ParticipacionTotalDeudasSinPunto,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[CubrimientoGarantiaComercial], '.', '') as CubrimientoGarantiaComercialSinPunto,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[CubrimientoGarantiaConsumo], '.', '') as CubrimientoGarantiaConsumoSinPunto,
   CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.NumeroOperacionesComercial,
   CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.NumeroOperacionesConsumo,
   CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.NumeroOperacionesVivienda,
   CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.NumeroOperacionesMicrocredito,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[ValorDeudaComercial], '.', '') as ValorDeudaComercialSinPunto,
   REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71.[ValorDeudaConsumo], '.', '') as ValorDeudaConsumoSinPunto
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( Endeudamiento_EndeudamientoTrimI_Endeudamiento71 VARCHAR(MAX) '$.Endeudamiento.EndeudamientoTrimI.Endeudamiento71',
       NumeroIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    id VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Hora                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
) as docs
 OUTER APPLY OPENJSON ( Endeudamiento_EndeudamientoTrimI_Endeudamiento71 )
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
		) AS CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento71
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
