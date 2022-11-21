/*CONCEITO*/
/*A aplicação das funções de grupo corresponde a resumir informações, permitindo ser obtida por meio de grupos de linhas com o uso de grupos ou agrupamentos
de funções.*/

/*FUNÇÃO DE GRUPO SIMPLES

    SUM   -> Retorna a soma de N
    AVG   -> Retorna a média aritmetica de N
    COUNT -> Retorna o numero de linhas da consulta
    MAX   -> Retorna o valor maximo de N
    MIN   -> Retorna o valor minimo de N
*/

/*Todas estas funções operam sobre um número de linhas – por exemplo, uma
tabela inteira – e são, portanto, funções de GRUPO.

DISTINCT faz uma função de grupo considerar valores não duplicados.

ALL considera todos os valores como sua declaração, não sendo necessária.

Os tipos de dados dos argumentos devem ser alfanuméricos, numéricos ou data,
onde a expressão é listada.

Todas as funções de grupo, exceto COUNT(*), ignoram os valores nulos.*/


/*FUNÇÃO AVG*/
/*Retorna a média aritmética de um grupo de registros. Por exemplo, para calcular
a média salarial dos empregados, faça:*/
SELECT AVG(SALARY)
FROM EMPLOYEES;

/*Uma função de grupo pode ser usada para subconjunto de linhas de uma tabela
por meio da cláusula WHERE. Assim, para encontrar o menor, maior e a soma dos
salários dos funcionários do Departamento 30, faça:*/
SELECT MIN(SALARY), MAX(SALARY), SUM(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;

/*FUNÇÃO COUNT*/
