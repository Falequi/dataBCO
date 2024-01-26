CREATE OR ALTER VIEW AnaliticCifinSectorRealExtinguidas
as 
SELECT 
   docs.SectorRealExtinguidas_Obligacion, docs.NumeroIdentificacion, docs.TipoIdentificacion, docs.id, docs.Fecha, docs.Hora,
   CifinTest_SectorRealExtinguidas_Obligacion.PaqueteInformacion,
   CifinTest_SectorRealExtinguidas_Obligacion.IdentificadorLinea,
   CifinTest_SectorRealExtinguidas_Obligacion.TipoContrato,
   CifinTest_SectorRealExtinguidas_Obligacion.EstadoContrato,
   CifinTest_SectorRealExtinguidas_Obligacion.TipoEntidad,
   CifinTest_SectorRealExtinguidas_Obligacion.NombreEntidad,
   CifinTest_SectorRealExtinguidas_Obligacion.Ciudad,
   CifinTest_SectorRealExtinguidas_Obligacion.Sucursal,
   CifinTest_SectorRealExtinguidas_Obligacion.NumeroObligacion,
   CifinTest_SectorRealExtinguidas_Obligacion.Calidad,
   CifinTest_SectorRealExtinguidas_Obligacion.EstadoObligacion,
   CifinTest_SectorRealExtinguidas_Obligacion.LineaCredito,
   CifinTest_SectorRealExtinguidas_Obligacion.Periodicidad,
   CifinTest_SectorRealExtinguidas_Obligacion.FechaApertura,
   CifinTest_SectorRealExtinguidas_Obligacion.ValorInicial,
   CifinTest_SectorRealExtinguidas_Obligacion.SaldoObligacion,
   CifinTest_SectorRealExtinguidas_Obligacion.ValorMora,
   CifinTest_SectorRealExtinguidas_Obligacion.ValorCuota,
   CifinTest_SectorRealExtinguidas_Obligacion.CuotasCanceladas,
   CifinTest_SectorRealExtinguidas_Obligacion.MoraMaxima,
   CifinTest_SectorRealExtinguidas_Obligacion.Comportamientos,
   CifinTest_SectorRealExtinguidas_Obligacion.ParticipacionDeuda,
   CifinTest_SectorRealExtinguidas_Obligacion.FechaCorte,
   CifinTest_SectorRealExtinguidas_Obligacion.ModoExtincion,
   CifinTest_SectorRealExtinguidas_Obligacion.FechaPago,
   CifinTest_SectorRealExtinguidas_Obligacion.FechaPermanencia,
   CifinTest_SectorRealExtinguidas_Obligacion.ChequesDevueltos,
   CifinTest_SectorRealExtinguidas_Obligacion.TipoPago,
   CifinTest_SectorRealExtinguidas_Obligacion.EstadoTitular,
   CifinTest_SectorRealExtinguidas_Obligacion.NumeroCuotasPactadas,
   CifinTest_SectorRealExtinguidas_Obligacion.NumeroCuotasMora,
   CifinTest_SectorRealExtinguidas_Obligacion.ValorCargoFijo,
   CifinTest_SectorRealExtinguidas_Obligacion.ClausulaPermanencia,
   CifinTest_SectorRealExtinguidas_Obligacion.Reestructurado,
   CifinTest_SectorRealExtinguidas_Obligacion.Vigencia,
   CifinTest_SectorRealExtinguidas_Obligacion.NumeroMesesContrato,
   CifinTest_SectorRealExtinguidas_Obligacion.NumeroMesesClausula
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with (  
      SectorRealExtinguidas_Obligacion VARCHAR(MAX) '$.SectorRealExtinguidas.Obligacion',
		NumeroIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
      TipoIdentificacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		id VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Hora                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
      ) as docs
OUTER APPLY OPENJSON ( SectorRealExtinguidas_Obligacion )
		 WITH (		
      PaqueteInformacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		IdentificadorLinea VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		TipoContrato VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		EstadoContrato VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		TipoEntidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NombreEntidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Ciudad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Sucursal VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NumeroObligacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Calidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		EstadoObligacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		LineaCredito VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Periodicidad VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		FechaApertura VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		ValorInicial VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		SaldoObligacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		ValorMora VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		ValorCuota VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		CuotasCanceladas VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		MoraMaxima VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Comportamientos VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		ParticipacionDeuda VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		FechaCorte VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		ModoExtincion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		FechaPago VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		FechaPermanencia VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		ChequesDevueltos VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		TipoPago VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		EstadoTitular VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NumeroCuotasPactadas VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NumeroCuotasMora VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		ValorCargoFijo VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		ClausulaPermanencia VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Reestructurado VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Vigencia VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NumeroMesesContrato VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		NumeroMesesClausula VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
    ) AS CifinTest_SectorRealExtinguidas_Obligacion
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