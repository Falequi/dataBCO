CREATE OR ALTER VIEW AnaliticCifinSectorRealEnMora
as 
SELECT 
   docs.SectorRealEnMora_Obligacion, docs.NumeroIdentificacion, docs.TipoIdentificacion, docs.id, docs.Fecha, docs.Hora,
   CifinTest_SectorRealEnMora_Obligacion.PaqueteInformacion, CifinTest_SectorRealEnMora_Obligacion.IdentificadorLinea,
   CifinTest_SectorRealEnMora_Obligacion.TipoContrato, CifinTest_SectorRealEnMora_Obligacion.EstadoContrato, CifinTest_SectorRealEnMora_Obligacion.TipoEntidad,
   CifinTest_SectorRealEnMora_Obligacion.NombreEntidad, CifinTest_SectorRealEnMora_Obligacion.Ciudad, CifinTest_SectorRealEnMora_Obligacion.Sucursal,
   CifinTest_SectorRealEnMora_Obligacion.NumeroObligacion, CifinTest_SectorRealEnMora_Obligacion.Calidad, CifinTest_SectorRealEnMora_Obligacion.EstadoObligacion,
   CifinTest_SectorRealEnMora_Obligacion.LineaCredito, CifinTest_SectorRealEnMora_Obligacion.Periodicidad, CifinTest_SectorRealEnMora_Obligacion.FechaApertura,
   CifinTest_SectorRealEnMora_Obligacion.FechaTerminacion, CifinTest_SectorRealEnMora_Obligacion.ValorInicial, CifinTest_SectorRealEnMora_Obligacion.SaldoObligacion,
   CifinTest_SectorRealEnMora_Obligacion.ValorMora, CifinTest_SectorRealEnMora_Obligacion.ValorCuota, CifinTest_SectorRealEnMora_Obligacion.CuotasCanceladas,
   CifinTest_SectorRealEnMora_Obligacion.MoraMaxima, CifinTest_SectorRealEnMora_Obligacion.Comportamientos, CifinTest_SectorRealEnMora_Obligacion.ParticipacionDeuda,
   CifinTest_SectorRealEnMora_Obligacion.FechaCorte, CifinTest_SectorRealEnMora_Obligacion.ModoExtincion, CifinTest_SectorRealEnMora_Obligacion.FechaPago,
   CifinTest_SectorRealEnMora_Obligacion.FechaPermanencia, CifinTest_SectorRealEnMora_Obligacion.ChequesDevueltos, CifinTest_SectorRealEnMora_Obligacion.Plazo,
   CifinTest_SectorRealEnMora_Obligacion.DiasCartera, CifinTest_SectorRealEnMora_Obligacion.TipoPago, CifinTest_SectorRealEnMora_Obligacion.EstadoTitular,
   CifinTest_SectorRealEnMora_Obligacion.NumeroCuotasPactadas, CifinTest_SectorRealEnMora_Obligacion.NumeroCuotasMora, CifinTest_SectorRealEnMora_Obligacion.ValorCargoFijo,
   CifinTest_SectorRealEnMora_Obligacion.ClausulaPermanencia, CifinTest_SectorRealEnMora_Obligacion.Reestructurado, CifinTest_SectorRealEnMora_Obligacion.Vigencia,
   CifinTest_SectorRealEnMora_Obligacion.NumeroMesesContrato, CifinTest_SectorRealEnMora_Obligacion.NumeroMesesClausula
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( 
       SectorRealEnMora_Obligacion  VARCHAR(MAX) '$.SectorRealEnMora.Obligacion',
       NumeroIdentificacion         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    id                           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Fecha                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Hora                         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
) as docs
 OUTER APPLY OPENJSON ( SectorRealEnMora_Obligacion )
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
			FechaTerminacion VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
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
			Plazo VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			DiasCartera VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
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
		) AS CifinTest_SectorRealEnMora_Obligacion
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