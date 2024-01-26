CREATE OR ALTER VIEW AnaliticCifinEndeudamientoTrimI_Endeudamiento73
as 
SELECT 
docs.NumeroIdentificacion,
docs.TipoIdentificacion,
docs.id,
docs.Fecha,
docs.Hora,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.TipoEntidad,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.NombreEntidad,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.TipoEntidadOriginadoraCartera,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.EntidadOriginadoraCartera,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.TipoFideicomiso,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.NumeroFideicomiso,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.ModalidadCredito,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.Calificacion,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.TipoMoneda,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.NumeroOperadores,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.[ValorDeuda], '.', '') as ValorDeudaSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.[ParticipacionTotalDeudas], '.', '') as ParticipacionTotalDeudasSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.[CubrimientoGarantia], '.', '') as CubrimientoGarantiaSinPunto,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.TipoGarantia,
CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.FechaUltimoAvaluo,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.[CuotaEsperada], '.', '') as CuotaEsperadaSinPunto,
REPLACE(CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73.[CumplimientoCuota], '.', '') as CumplimientoCuotaSinPunto
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( Endeudamiento_EndeudamientoTrimI_Endeudamiento73 VARCHAR(MAX) '$.Endeudamiento.EndeudamientoTrimI.Endeudamiento73',
       NumeroIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    id VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Hora                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
) as docs
 OUTER APPLY OPENJSON ( Endeudamiento_EndeudamientoTrimI_Endeudamiento73 )
		 WITH (
			TipoEntidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NombreEntidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoEntidadOriginadoraCartera VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EntidadOriginadoraCartera VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoFideicomiso VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroFideicomiso VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ModalidadCredito VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Calificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoMoneda VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroOperadores VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorDeuda VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ParticipacionTotalDeudas VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CubrimientoGarantia VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoGarantia VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaUltimoAvaluo VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CuotaEsperada VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CumplimientoCuota VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8		
		) AS CifinTest_Endeudamiento_EndeudamientoTrimI_Endeudamiento73
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
    