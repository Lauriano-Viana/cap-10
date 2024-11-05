# Projeto de Banco de Dados para Análise de Produção Agrícola

Este projeto consiste em um banco de dados para armazenar e analisar dados agrícolas, com foco em culturas, áreas plantadas, produções e safras. A modelagem e as consultas SQL foram desenvolvidas para possibilitar a análise de dados de produção, área e produtividade, com exemplos específicos para a cultura do milho.

## Conjunto de Dados utilizado

O conjunto de dados utilizado como "base" foi o arquivo "MilhoTotalSerieHist.xls" que se trata da serie porudção história do milho, extraido do site da CONAB.

Milho Total (1ª, 2ª e 3ª Safras) link: https://www.conab.gov.br/info-agro/safras/serie-historica-das-safras/itemlist/category/910-Milho


## Estrutura do Banco de Dados

O banco de dados foi estruturado em várias tabelas inter-relacionadas para registrar informações sobre culturas, estados, regiões, safras, áreas plantadas e produções agrícolas:

- **t_area**: armazena dados sobre as áreas de plantio, incluindo um identificador e a área total em metros quadrados por localidade.
- **t_cultura**: armazena informações sobre diferentes culturas (ex: milho, feijão).
- **t_estado**: contém informações sobre os estados brasileiros, incluindo a sigla e o nome do estado.( ex: São Paulo, SP)
- **t_producao**: registra a produção agrícola, associando cultura, safra, área e quantidade produzida.
- **t_regiao**: armazena dados sobre as regiões geográficas, como Norte, Nordeste, Sul, etc.
- **t_safra**: armazena informações sobre as safras, incluindo ano de início e fim.

## Relacionamentos

Os relacionamentos principais entre as tabelas estão definidos para permitir a associação entre áreas de plantio, estados, culturas e safras. Estes relacionamentos possibilitam a análise da produção por diferentes dimensões, como estado e ano-safra.

## Consultas de Análise de Dados

Abaixo estão exemplos de consultas SQL criadas para realizar análises específicas de produção, evolução de área plantada e produtividade, usando a cultura de milho como exemplo:

### 1. Produção Total de Milho por Estado na Safra 2023/2024

Essa consulta calcula a produção total de milho em cada estado para a safra de 2023/2024. Os dados são agrupados por estado e ordenados pela quantidade produzida.

```sql
SELECT 
    e.nm_estado AS Estado,
    SUM(p.qt_producao) AS Producao_Total
FROM 
    t_producao p
JOIN 
    t_cultura c ON p.t_cultura_id_cultura = c.id_cultura
JOIN 
    t_area a ON p.t_area_id_area = a.id_area
JOIN 
    t_estado e ON a.t_estado_sg_estado = e.sg_estado
JOIN 
    t_safra s ON p.t_safra_id_safra = s.id_safra
WHERE 
    c.nm_cultura = 'Milho' 
    AND s.nm_safra = '2023/2024'
GROUP BY 
    e.nm_estado
ORDER BY 
    Producao_Total DESC;
```

### 2. Evolução da Área Plantada de Milho do Ano 2000 até 2024

Esta consulta exibe a evolução da área plantada de milho ao longo dos anos, mostrando a área total plantada por ano desde 2000 até 2024.

```sql
SELECT 
    EXTRACT(YEAR FROM s.dt_inicio_safra) AS Ano,
    SUM(a.md_area) AS Area_Total
FROM 
    t_producao p
JOIN 
    t_cultura c ON p.t_cultura_id_cultura = c.id_cultura
JOIN 
    t_area a ON p.t_area_id_area = a.id_area
JOIN 
    t_safra s ON p.t_safra_id_safra = s.id_safra
WHERE 
    c.nm_cultura = 'Milho'
    AND EXTRACT(YEAR FROM s.dt_inicio_safra) BETWEEN 2000 AND 2024
GROUP BY 
    EXTRACT(YEAR FROM s.dt_inicio_safra)
ORDER BY 
    Ano;
```

### 3. Ranking dos Estados com Maior Produtividade de Milho em 2024

Produtividade é calculada como a relação entre produção e área plantada. Esta consulta exibe um ranking dos estados com maior produtividade de milho no ano de 2024.

```sql
SELECT 
    e.nm_estado AS Estado,
    SUM(p.qt_producao) / SUM(a.md_area) AS Produtividade
FROM 
    t_producao p
JOIN 
    t_cultura c ON p.t_cultura_id_cultura = c.id_cultura
JOIN 
    t_area a ON p.t_area_id_area = a.id_area
JOIN 
    t_estado e ON a.t_estado_sg_estado = e.sg_estado
JOIN 
    t_safra s ON p.t_safra_id_safra = s.id_safra
WHERE 
    c.nm_cultura = 'Milho'
    AND EXTRACT(YEAR FROM s.dt_inicio_safra) = 2024
GROUP BY 
    e.nm_estado
ORDER BY 
    Produtividade DESC;
```

## Observações e Requisitos

Para executar essas consultas, o banco de dados precisa estar populado com dados reais de safras, culturas, produções e áreas plantadas. Esse modelo permite fácil adaptação para outros tipos de análises e culturas, bastando ajustar os parâmetros nas consultas SQL.

## Objetivo

O objetivo deste projeto é fornecer uma ferramenta robusta para análises agrícolas, ajudando na tomada de decisões estratégicas sobre produtividade, área plantada e desempenho por estado e safra.
