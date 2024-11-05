
CREATE TABLE t_area (
    id_area            NUMBER(7) NOT NULL,
    md_area            NUMBER(10, 2) NOT NULL,
    t_estado_sg_estado VARCHAR2(2) NOT NULL
);

ALTER TABLE t_area ADD CONSTRAINT t_area_pk PRIMARY KEY ( id_area );

CREATE TABLE t_cultura (
    id_cultura NUMBER(7) NOT NULL,
    nm_cultura VARCHAR2(30) NOT NULL
);

ALTER TABLE t_cultura ADD CONSTRAINT t_cultura_pk PRIMARY KEY ( id_cultura );

CREATE TABLE t_estado (
    sg_estado          VARCHAR2(2) NOT NULL,
    nm_estado          VARCHAR2(30) NOT NULL,
    t_regiao_id_regiao NUMBER(7) NOT NULL
);

ALTER TABLE t_estado ADD CONSTRAINT t_estado_pk PRIMARY KEY ( sg_estado );

CREATE TABLE t_producao (
    id_producao          NUMBER(7) NOT NULL,
    t_cultura_id_cultura NUMBER(7) NOT NULL,
    t_safra_id_safra     NUMBER(7) NOT NULL,
    t_area_id_area       NUMBER(7) NOT NULL,
    qt_producao          NUMBER(10, 2) NOT NULL
);

ALTER TABLE t_producao ADD CONSTRAINT t_producao_pk PRIMARY KEY ( id_producao );

CREATE TABLE t_regiao (
    id_regiao NUMBER(7) NOT NULL,
    nm_regiao VARCHAR2(30) NOT NULL
);

ALTER TABLE t_regiao ADD CONSTRAINT t_regiao_pk PRIMARY KEY ( id_regiao );

CREATE TABLE t_safra (
    id_safra        NUMBER(7) NOT NULL,
    nm_safra        VARCHAR2(30) NOT NULL,
    dt_inicio_safra DATE NOT NULL,
    dt_fim_safra    DATE NOT NULL
);

ALTER TABLE t_safra ADD CONSTRAINT t_safra_pk PRIMARY KEY ( id_safra );

ALTER TABLE t_area
    ADD CONSTRAINT t_area_t_estado_fk FOREIGN KEY ( t_estado_sg_estado )
        REFERENCES t_estado ( sg_estado );

ALTER TABLE t_estado
    ADD CONSTRAINT t_estado_t_regiao_fk FOREIGN KEY ( t_regiao_id_regiao )
        REFERENCES t_regiao ( id_regiao );

ALTER TABLE t_producao
    ADD CONSTRAINT t_producao_t_area_fk FOREIGN KEY ( t_area_id_area )
        REFERENCES t_area ( id_area );

ALTER TABLE t_producao
    ADD CONSTRAINT t_producao_t_cultura_fk FOREIGN KEY ( t_cultura_id_cultura )
        REFERENCES t_cultura ( id_cultura );

ALTER TABLE t_producao
    ADD CONSTRAINT t_producao_t_safra_fk FOREIGN KEY ( t_safra_id_safra )
        REFERENCES t_safra ( id_safra );
