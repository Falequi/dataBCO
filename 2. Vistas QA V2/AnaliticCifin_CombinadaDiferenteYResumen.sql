CREATE OR ALTER VIEW combinadaAnaliticCifinDiferenteYResumen AS
SELECT * FROM AnaliticCifinDiferentePrincipal
UNION ALL
SELECT * FROM AnaliticCifinResumenPrincipal;