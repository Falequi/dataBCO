CREATE OR ALTER VIEW AnaliticCifinResumenPrincipal
as
SELECT 
docs.NumeroIdentificacion,docs.TipoIdentificacion,docs.id,
CifinTest_Consolidado_ResumenPrincipal_Registro.PaqueteInformacion,CifinTest_Consolidado_ResumenPrincipal_Registro.NumeroObligaciones,
TotalSaldo,REPLACE(CifinTest_Consolidado_ResumenPrincipal_Registro.[ParticipacionDeuda], '.', '') as ParticipacionDeudaSinPunto,
CifinTest_Consolidado_ResumenPrincipal_Registro.NumeroObligacionesDia,CifinTest_Consolidado_ResumenPrincipal_Registro.SaldoObligacionesDia,
CifinTest_Consolidado_ResumenPrincipal_Registro.CuotaObligacionesDia,CifinTest_Consolidado_ResumenPrincipal_Registro.CantidadObligacionesMora,
CifinTest_Consolidado_ResumenPrincipal_Registro.SaldoObligacionesMora,CifinTest_Consolidado_ResumenPrincipal_Registro.CuotaObligacionesMora,
CifinTest_Consolidado_ResumenPrincipal_Registro.ValorMora,docs.Fecha,docs.Hora
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( Consolidado_ResumenPrincipal_Registro 	VARCHAR(MAX) '$.Consolidado.ResumenPrincipal.Registro',
       NumeroIdentificacion 					      VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion 						      VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    id 										         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       Fecha                                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    Hora                                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8) as docs
 OUTER APPLY OPENJSON ( Consolidado_ResumenPrincipal_Registro )
		 WITH (
			PaqueteInformacion 			VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroObligaciones 			VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TotalSaldo 					   VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ParticipacionDeuda 			VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroObligacionesDia 		VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			SaldoObligacionesDia 		VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CuotaObligacionesDia 		VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CantidadObligacionesMora 	VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			SaldoObligacionesMora 		VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CuotaObligacionesMora 		VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorMora 					   VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8	
		) AS CifinTest_Consolidado_ResumenPrincipal_Registro
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