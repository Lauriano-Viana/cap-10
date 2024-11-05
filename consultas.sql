---1) Produção Total de Milho por Estado na Safra 2023/2024

---Essa consulta calcula a produção total de milho em cada estado para a safra de 2023/2024. Os dados são agrupados por estado e ordenados pela quantidade produzida.


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


---2) Evolução da Área Plantada de Milho do Ano 2000 até 2024
---Esta consulta exibe a evolução da área plantada de milho ao longo dos anos, mostrando a área total plantada por ano desde 2000 até 2024.


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


---3) Ranking dos Estados com Maior Produtividade de Milho em 2024
---Produtividade é calculada como a relação entre produção e área plantada. Esta consulta exibe um ranking dos estados com maior produtividade de milho no ano de 2024.


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



