INSERT INTO pais
(cd_pais, nm_pais) VALUES (1, 'Brasil');

INSERT INTO pais 
(cd_pais, nm_pais, ds_nacionalidade, dt_inclusao)
VALUES (2,'Alemanha', null, to_date('19/11/2022', 'dd/mm/YYYY'));

INSERT INTO pais 
VALUES (4, 'Chile', 'Chilena', sysdate);

INSERT INTO pais 
(nm_pais, dt_inclusao, ds_nacionalidade, cd_pais)
VALUES ('EUA', to_date('24/02/2017', 'dd/mm/YYYY'), 'Americana', 3);

UPDATE Pais 
set Nm_pais = 'Portugal',
    Ds_nacionalidade = 'Portuguesa'
WHERE Cd_pais = 3; 

UPDATE Pais 
set Ds_nacionalidade = 'Brasileira',
    Dt_inclusao = sysdate
WHERE Cd_pais = 1;

UPDATE Pais 
set Ds_nacionalidade = 'Alemao'
WHERE Cd_pais = 2;
