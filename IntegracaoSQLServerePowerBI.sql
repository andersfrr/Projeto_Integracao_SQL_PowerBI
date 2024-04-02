/*Os indicadores da ABA GERAL ser�o:
Receita Total;
Quantidade Vendida;
Total de Categorias de Produtos;
Quantidade de Clientes;
Receita Total e Lucro Total por M�s;
Margem de Lucro;
Quantidade Vendida por M�s;
Lucro por Pa�s.*/

/*Os indicadores da ABA CLIENTES ser�o:
Vendas por Pa�s;
Clientes por Pa�s;
Vendas por G�nero;
Vendas por Categoria.*/

/*precisaremos de informa��es das tabelas:
FactInternetSales,
DimProductCategory,
DimGeography e
DimCustomer,
al�m das tabelas 
DimProduct e DimProductSubcategory para estabelecer 
relacionamentos intermedi�rios entre a FactInternetSales e a DimProductCategory.*/

/*NOME DA COLUNA					     	 NOME DA TABELA
SalesOrderNumber					        FactInternetSales
OrderDate									FactInternetSales
EnglishProductCategoryName					DimProductCategory
CustomerKey									DimCustomer
FirstName + � � + LastName					DimCustomer
Gender										DimCustomer
EnglishCountryRegionName					DimGeography
OrderQuantity								FactInternetSales
SalesAmount									FactInternetSales
TotalProductCost							FactInternetSales
SalesAmount � TotalProductCost (Lucro)		FactInternetSales      */

CREATE OR ALTER VIEW RESULTADOS_ADW AS
SELECT
	fis.SalesOrderNumber AS 'N� PEDIDO',
	fis.OrderDate AS 'DATA PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	fis.CustomerKey AS 'ID CLIENTE',
	dc.FirstName + ' ' + dc.LastName AS 'NOME CLIENTE',
	REPLACE(REPLACE(dc.Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'SEXO',
	dg.EnglishCountryRegionName AS 'PA�S',
	fis.OrderQuantity AS 'QTD. VENDIDA',
	fis.SalesAmount AS 'RECEITA VENDA',
	fis.TotalProductCost AS 'CUSTO VENDA',
	fis.SalesAmount - fis.TotalProductCost AS 'LUCRO VENDA'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
	INNER JOIN DimGeography dg ON dc.GeographyKey = dg.GeographyKey