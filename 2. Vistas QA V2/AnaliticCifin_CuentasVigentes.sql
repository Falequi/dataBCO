CREATE OR ALTER VIEW AnaliticCifinCuentasVigentes
as 
SELECT 
   docs.CuentasVigentes_Obligacion,docs.NumeroIdentificacion,docs.TipoIdentificacion,docs.id,docs.Fecha,docs.Hora,
   CifinTest_CuentasVigentes_Obligacion.PaqueteInformacion,CifinTest_CuentasVigentes_Obligacion.IdentificadorLinea,
   CifinTest_CuentasVigentes_Obligacion.TipoContrato,CifinTest_CuentasVigentes_Obligacion.TipoEntidad,
   CifinTest_CuentasVigentes_Obligacion.NombreEntidad,CifinTest_CuentasVigentes_Obligacion.Ciudad,
   CifinTest_CuentasVigentes_Obligacion.Sucursal,CifinTest_CuentasVigentes_Obligacion.NumeroObligacion,
   CifinTest_CuentasVigentes_Obligacion.EstadoObligacion,CifinTest_CuentasVigentes_Obligacion.FechaApertura,
   CifinTest_CuentasVigentes_Obligacion.FechaTerminacion,CifinTest_CuentasVigentes_Obligacion.ValorInicial,
   CifinTest_CuentasVigentes_Obligacion.Comportamientos,CifinTest_CuentasVigentes_Obligacion.FechaCorte,
   CifinTest_CuentasVigentes_Obligacion.FechaPermanencia,CifinTest_CuentasVigentes_Obligacion.ChequesDevueltos,
   CifinTest_CuentasVigentes_Obligacion.DiasCartera
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( CuentasVigentes_Obligacion   VARCHAR(MAX) '$.CuentasVigentes.Obligacion',
       NumeroIdentificacion         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       id                           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       Fecha                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	 Hora                         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
       ) as docs
OUTER APPLY OPENJSON (CuentasVigentes_Obligacion )
WITH (
      PaqueteInformacion   VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      IdentificadorLinea   VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      TipoContrato         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      TipoEntidad          VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      NombreEntidad        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      Ciudad               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      Sucursal             VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      NumeroObligacion     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      EstadoObligacion     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      FechaApertura        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      FechaTerminacion     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      ValorInicial         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      Comportamientos      VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      FechaCorte           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      FechaPermanencia     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      ChequesDevueltos     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      DiasCartera          VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
) AS CifinTest_CuentasVigentes_Obligacion
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