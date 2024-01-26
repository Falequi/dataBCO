CREATE OR ALTER VIEW AnaliticCifinSectorFinancieroEnMora
as 
SELECT 
docs.NumeroIdentificacion,docs.TipoIdentificacion,docs.id,docs.Fecha,docs.Hora,
CifinTest_SectorFinancieroEnMora_Obligacion.IdentificadorLinea,CifinTest_SectorFinancieroEnMora_Obligacion.TipoContrato,CifinTest_SectorFinancieroEnMora_Obligacion.EstadoContrato,
CifinTest_SectorFinancieroEnMora_Obligacion.TipoEntidad,CifinTest_SectorFinancieroEnMora_Obligacion.NombreEntidad,CifinTest_SectorFinancieroEnMora_Obligacion.Ciudad,
CifinTest_SectorFinancieroEnMora_Obligacion.Sucursal,CifinTest_SectorFinancieroEnMora_Obligacion.NumeroObligacion,CifinTest_SectorFinancieroEnMora_Obligacion.Calidad,
CifinTest_SectorFinancieroEnMora_Obligacion.EstadoObligacion,CifinTest_SectorFinancieroEnMora_Obligacion.ModalidadCredito,CifinTest_SectorFinancieroEnMora_Obligacion.LineaCredito,
CifinTest_SectorFinancieroEnMora_Obligacion.Periodicidad,CifinTest_SectorFinancieroEnMora_Obligacion.FechaApertura,CifinTest_SectorFinancieroEnMora_Obligacion.FechaTerminacion,
CifinTest_SectorFinancieroEnMora_Obligacion.Calificacion,CifinTest_SectorFinancieroEnMora_Obligacion.ValorInicial,CifinTest_SectorFinancieroEnMora_Obligacion.SaldoObligacion,
CifinTest_SectorFinancieroEnMora_Obligacion.ValorMora,CifinTest_SectorFinancieroEnMora_Obligacion.ValorCuota,CifinTest_SectorFinancieroEnMora_Obligacion.TipoMoneda,
CifinTest_SectorFinancieroEnMora_Obligacion.CuotasCanceladas,CifinTest_SectorFinancieroEnMora_Obligacion.TipoGarantia,
REPLACE(CifinTest_SectorFinancieroEnMora_Obligacion.[CubrimientoGarantia], '.', '') as CubrimientoGarantiaSinPunto,
CifinTest_SectorFinancieroEnMora_Obligacion.MoraMaxima,CifinTest_SectorFinancieroEnMora_Obligacion.Comportamientos,
REPLACE(CifinTest_SectorFinancieroEnMora_Obligacion.[ParticipacionDeuda], '.', '') as ParticipacionDeudaSinPunto,
CifinTest_SectorFinancieroEnMora_Obligacion.ProbabilidadNoPago,CifinTest_SectorFinancieroEnMora_Obligacion.FechaCorte,CifinTest_SectorFinancieroEnMora_Obligacion.ModoExtincion,
CifinTest_SectorFinancieroEnMora_Obligacion.FechaPago,CifinTest_SectorFinancieroEnMora_Obligacion.FechaPermanencia,CifinTest_SectorFinancieroEnMora_Obligacion.NumeroReestructuraciones,
CifinTest_SectorFinancieroEnMora_Obligacion.NaturalezaReestructuracion,CifinTest_SectorFinancieroEnMora_Obligacion.TipoEntidadOriginadoraCartera,
CifinTest_SectorFinancieroEnMora_Obligacion.EntidadOriginadoraCartera,CifinTest_SectorFinancieroEnMora_Obligacion.TipoPago,CifinTest_SectorFinancieroEnMora_Obligacion.EstadoTitular,
CifinTest_SectorFinancieroEnMora_Obligacion.NumeroCuotasPactadas,CifinTest_SectorFinancieroEnMora_Obligacion.NumeroCuotasMora,CifinTest_SectorFinancieroEnMora_Obligacion.Reestructurado
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( SectorFinancieroEnMora_Obligacion  VARCHAR(MAX) '$.SectorFinancieroEnMora.Obligacion',
       NumeroIdentificacion               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    id                                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Fecha                              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
		 Hora                               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
) as docs
 OUTER APPLY OPENJSON ( SectorFinancieroEnMora_Obligacion )
		 WITH (
			PaqueteInformacion               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			IdentificadorLinea               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoContrato                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EstadoContrato                   VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoEntidad                      VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NombreEntidad                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Ciudad                           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Sucursal                         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroObligacion                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Calidad                          VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EstadoObligacion                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ModalidadCredito                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			LineaCredito                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Periodicidad                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaApertura                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaTerminacion                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Calificacion                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorInicial                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			SaldoObligacion                  VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorMora                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorCuota                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoMoneda                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CuotasCanceladas                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoGarantia                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CubrimientoGarantia              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			MoraMaxima                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Comportamientos                  VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ParticipacionDeuda               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ProbabilidadNoPago               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaCorte                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ModoExtincion                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaPago                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaPermanencia                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroReestructuraciones         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NaturalezaReestructuracion       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoEntidadOriginadoraCartera    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EntidadOriginadoraCartera        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoPago                         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EstadoTitular                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroCuotasPactadas             VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroCuotasMora                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
         Reestructurado                   VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8		
		) AS CifinTest_SectorFinancieroEnMora_Obligacion
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

