CREATE OR ALTER VIEW AnaliticCifinSectorFinancieroAlDia
as 
SELECT  
docs.SectorFinancieroAlDia_Obligacion,docs.NumeroIdentificacion,docs.TipoIdentificacion,docs.id,docs.Fecha,docs.Hora,
CifinTest_SectorFinancieroAlDia_Obligacion.PaqueteInformacion,CifinTest_SectorFinancieroAlDia_Obligacion.IdentificadorLinea,
CifinTest_SectorFinancieroAlDia_Obligacion.TipoContrato,CifinTest_SectorFinancieroAlDia_Obligacion.EstadoContrato,
CifinTest_SectorFinancieroAlDia_Obligacion.TipoEntidad,CifinTest_SectorFinancieroAlDia_Obligacion.NombreEntidad,
CifinTest_SectorFinancieroAlDia_Obligacion.Ciudad,CifinTest_SectorFinancieroAlDia_Obligacion.Sucursal,
CifinTest_SectorFinancieroAlDia_Obligacion.NumeroObligacion,CifinTest_SectorFinancieroAlDia_Obligacion.Calidad,
CifinTest_SectorFinancieroAlDia_Obligacion.EstadoObligacion,CifinTest_SectorFinancieroAlDia_Obligacion.ModalidadCredito,
CifinTest_SectorFinancieroAlDia_Obligacion.LineaCredito,CifinTest_SectorFinancieroAlDia_Obligacion.Periodicidad,
CifinTest_SectorFinancieroAlDia_Obligacion.FechaApertura,CifinTest_SectorFinancieroAlDia_Obligacion.FechaTerminacion,
CifinTest_SectorFinancieroAlDia_Obligacion.Calificacion,CifinTest_SectorFinancieroAlDia_Obligacion.ValorInicial,
CifinTest_SectorFinancieroAlDia_Obligacion.SaldoObligacion,CifinTest_SectorFinancieroAlDia_Obligacion.ValorMora,
CifinTest_SectorFinancieroAlDia_Obligacion.ValorCuota,CifinTest_SectorFinancieroAlDia_Obligacion.TipoMoneda,
CifinTest_SectorFinancieroAlDia_Obligacion.CuotasCanceladas,CifinTest_SectorFinancieroAlDia_Obligacion.TipoGarantia,
REPLACE(CifinTest_SectorFinancieroAlDia_Obligacion.[CubrimientoGarantia], '.', '') as CubrimientoGarantiaSinPunto,
CifinTest_SectorFinancieroAlDia_Obligacion.CubrimientoGarantia,CifinTest_SectorFinancieroAlDia_Obligacion.MoraMaxima,
CifinTest_SectorFinancieroAlDia_Obligacion.Comportamientos,
REPLACE(CifinTest_SectorFinancieroAlDia_Obligacion.[ParticipacionDeuda], '.', '') as ParticipacionDeudaSinPunto,
CifinTest_SectorFinancieroAlDia_Obligacion.ProbabilidadNoPago,CifinTest_SectorFinancieroAlDia_Obligacion.FechaCorte,
CifinTest_SectorFinancieroAlDia_Obligacion.ModoExtincion,CifinTest_SectorFinancieroAlDia_Obligacion.FechaPago,
CifinTest_SectorFinancieroAlDia_Obligacion.FechaPermanencia,CifinTest_SectorFinancieroAlDia_Obligacion.NumeroReestructuraciones,
CifinTest_SectorFinancieroAlDia_Obligacion.NaturalezaReestructuracion,CifinTest_SectorFinancieroAlDia_Obligacion.TipoEntidadOriginadoraCartera,
CifinTest_SectorFinancieroAlDia_Obligacion.EntidadOriginadoraCartera,CifinTest_SectorFinancieroAlDia_Obligacion.TipoPago,
CifinTest_SectorFinancieroAlDia_Obligacion.EstadoTitular,CifinTest_SectorFinancieroAlDia_Obligacion.NumeroCuotasPactadas,
CifinTest_SectorFinancieroAlDia_Obligacion.NumeroCuotasMora,CifinTest_SectorFinancieroAlDia_Obligacion.Reestructurado,
CifinTest_SectorFinancieroAlDia_Obligacion.Mensajes_Mensaje_IdentificadorLinea,CifinTest_SectorFinancieroAlDia_Obligacion.Mensajes_Mensaje_PaqueteRegistro,
CifinTest_SectorFinancieroAlDia_Obligacion.Mensajes_Mensaje_Descripcion
FROM OPENROWSET( 
       'CosmosDB',
       'Account=consulta-cifin-cosmos-dev1;Database=DB_CIFIN_TEST;Key=tesc4nGhJYqySFew0Q25f1BiZVUVUdXfwvvfqKXYvHhZHaz52WwY0uzBkAbr7HhC0Z5c14CCjdrkJMHit7DdCw==',
       CONSULTA_CIFIN)
with ( 
       SectorFinancieroAlDia_Obligacion   VARCHAR(MAX) '$.SectorFinancieroAlDia.Obligacion',
       NumeroIdentificacion               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       TipoIdentificacion                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    id                                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
       Fecha                              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
	    Hora                               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8
) as docs
 OUTER APPLY OPENJSON ( SectorFinancieroAlDia_Obligacion )
		 WITH (
			PaqueteInformacion                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			IdentificadorLinea                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoContrato                           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EstadoContrato                         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoEntidad                            VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NombreEntidad                          VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Ciudad                                 VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
         	Sucursal                               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroObligacion                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Calidad                                VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EstadoObligacion                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ModalidadCredito                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			LineaCredito                           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Periodicidad                           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaApertura                          VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaTerminacion                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Calificacion                           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorInicial                           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			SaldoObligacion                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorMora                              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ValorCuota                             VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoMoneda                             VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CuotasCanceladas                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoGarantia                           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			CubrimientoGarantia                    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			MoraMaxima                             VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Comportamientos                        VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ParticipacionDeuda                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ProbabilidadNoPago                     VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaCorte                             VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			ModoExtincion                          VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaPago                              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			FechaPermanencia                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroReestructuraciones               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NaturalezaReestructuracion             VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoEntidadOriginadoraCartera          VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EntidadOriginadoraCartera              VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			TipoPago                               VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			EstadoTitular                          VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroCuotasPactadas                   VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			NumeroCuotasMora                       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Reestructurado                         VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8,
			Mensajes_Mensaje_IdentificadorLinea    VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Mensajes.Mensaje.IdentificadorLinea',
			Mensajes_Mensaje_PaqueteRegistro       VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Mensajes.Mensaje.PaqueteRegistro',
			Mensajes_Mensaje_Descripcion           VARCHAR(256) COLLATE Latin1_General_100_BIN2_UTF8 '$.Mensajes.Mensaje.Descripcion'		
		) AS CifinTest_SectorFinancieroAlDia_Obligacion
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