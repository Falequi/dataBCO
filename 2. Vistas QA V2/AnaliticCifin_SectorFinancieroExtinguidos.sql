CREATE OR ALTER VIEW AnaliticCifinSectorFinancieroExtinguidas
as 
SELECT 
   docs.SectorFinancieroExtinguidas_Obligacion, docs.NumeroIdentificacion, docs.TipoIdentificacion, docs.id, docs.Fecha, docs.Hora,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.PaqueteInformacion, CifinTest_SectorFinancieroExtinguidas_Obligacion.IdentificadorLinea,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.TipoContrato, CifinTest_SectorFinancieroExtinguidas_Obligacion.EstadoContrato,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.TipoEntidad, CifinTest_SectorFinancieroExtinguidas_Obligacion.NombreEntidad,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.Ciudad, CifinTest_SectorFinancieroExtinguidas_Obligacion.Sucursal,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.NumeroObligacion, CifinTest_SectorFinancieroExtinguidas_Obligacion.Calidad,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.EstadoObligacion, CifinTest_SectorFinancieroExtinguidas_Obligacion.ModalidadCredito,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.LineaCredito, CifinTest_SectorFinancieroExtinguidas_Obligacion.Periodicidad,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.FechaApertura, CifinTest_SectorFinancieroExtinguidas_Obligacion.FechaTerminacion,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.Calificacion, CifinTest_SectorFinancieroExtinguidas_Obligacion.ValorInicial,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.SaldoObligacion, CifinTest_SectorFinancieroExtinguidas_Obligacion.ValorMora,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.ValorCuota, CifinTest_SectorFinancieroExtinguidas_Obligacion.TipoMoneda,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.CuotasCanceladas, CifinTest_SectorFinancieroExtinguidas_Obligacion.TipoGarantia,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.CubrimientoGarantia,   CifinTest_SectorFinancieroExtinguidas_Obligacion.MoraMaxima,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.Comportamientos,   CifinTest_SectorFinancieroExtinguidas_Obligacion.ParticipacionDeuda,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.ProbabilidadNoPago,   CifinTest_SectorFinancieroExtinguidas_Obligacion.FechaCorte,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.ModoExtincion,   CifinTest_SectorFinancieroExtinguidas_Obligacion.FechaPago,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.FechaPermanencia,   CifinTest_SectorFinancieroExtinguidas_Obligacion.NumeroReestructuraciones,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.NaturalezaReestructuracion,   CifinTest_SectorFinancieroExtinguidas_Obligacion.TipoEntidadOriginadoraCartera,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.EntidadOriginadoraCartera,   CifinTest_SectorFinancieroExtinguidas_Obligacion.TipoPago,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.EstadoTitular, CifinTest_SectorFinancieroExtinguidas_Obligacion.NumeroCuotasPactadas,
   CifinTest_SectorFinancieroExtinguidas_Obligacion.NumeroCuotasMora,   CifinTest_SectorFinancieroExtinguidas_Obligacion.Reestructurado
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( 
       SectorFinancieroExtinguidas_Obligacion   VARCHAR(MAX) '$.SectorFinancieroExtinguidas.Obligacion',
       NumeroIdentificacion                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    id                                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Fecha                                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Hora                                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8  ) as docs
 OUTER APPLY OPENJSON ( SectorFinancieroExtinguidas_Obligacion )
		 WITH (
			PaqueteInformacion            VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			IdentificadorLinea            VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoContrato                  VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EstadoContrato                VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoEntidad                   VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NombreEntidad                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Ciudad                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Sucursal                      VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroObligacion              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Calidad                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EstadoObligacion              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ModalidadCredito              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			LineaCredito                  VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Periodicidad                  VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaApertura                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaTerminacion              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Calificacion                  VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorInicial                  VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			SaldoObligacion               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorMora                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorCuota                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoMoneda                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CuotasCanceladas              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoGarantia                  VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CubrimientoGarantia           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			MoraMaxima                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Comportamientos               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ParticipacionDeuda            VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ProbabilidadNoPago            VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaCorte                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ModoExtincion                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaPago                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaPermanencia              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroReestructuraciones      VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NaturalezaReestructuracion    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoEntidadOriginadoraCartera VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EntidadOriginadoraCartera     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoPago                      VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EstadoTitular                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroCuotasPactadas          VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroCuotasMora              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Reestructurado                VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8		
		) AS CifinTest_SectorFinancieroExtinguidas_Obligacion
INNER JOIN 
(SELECT docs1.NumeroIdentificacion,MAX(CONVERT (varchar, docs1.fecha, 103)) as fecha 
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( 
		NumeroIdentificacion        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		Fecha                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
    ) as docs1 GROUP BY NumeroIdentificacion) 
    as maximo on docs.NumeroIdentificacion = maximo.NumeroIdentificacion and CONVERT(varchar, docs.fecha, 103) = maximo.fecha