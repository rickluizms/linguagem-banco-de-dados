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

/*Retorna a quantidade de registros de um grupo de registros. Por exemplo, para
encontrar o número de empregados do Departamento 30, faça:*/
SELECT COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;



/*FUNÇÃO DE GRUPO COMPOSTO*/

/*Com o uso do GROUP BY é possível agruparmos diversos registros com base
em uma ou mais colunas de uma tabela.

Todos os campos no select que não possuírem função de grupo devem aparecer na
cláusula GROUP BY.*/
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

/*Porém, os campos existentes na cláusula GROUP BY não precisam necessariamente aparecer no select.*/
SELECT AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;


/*EX 1: Para calcular a média salarial de cada grupo de cargo, faça:*/
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID; 

/*EX 2: Agrupando Mais de uma Coluna*/
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID;

/*Limitações:
• Não use a cláusula WHERE para restringir grupos;
• Para restringir grupos, use a cláusula HAVING;
• Você não pode usar funções de grupo na cláusula WHERE.*/



/*EX 3: Excluindo Linhas Quando Estiver Usando o GROUP BY*/

/*Linhas devem ser excluídas com a cláusula WHERE antes da divisão por
grupos. Por exemplo, para mostrar a média salarial para cada cargo, excluindo os
departamentos 10, 20 e 30, faça:*/
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN (10, 20, 30)
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID


/*EX 4: Para mostrar a média salarial e a soma dos salários por cada departamento e
cargo, faça: */
SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;



/*Cláusula HAVING – Restringindo o Resultado por Grupo*/

/*Use a cláusula HAVING se quiser especificar o grupo a ser mostrado.*/
SELECT DEPARTMENT_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY)>10000;

/*EX 5: Para mostrar a média salarial de todos os departamentos que tiverem a média
maior que 6.000, faça:*/
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 6000
ORDER BY DEPARTMENT_ID

/*A cláusula:
• WHERE é condição para o SELECT;
• HAVING é condição para um GROUP BY.
*/

/*EX 6: Para mostrar a quantidade de empregados com salário acima de 10.000 por
departamento, faça:*/
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MAX (SALARY) > 10000
ORDER BY DEPARTMENT_ID

/*A cláusula HAVING deve ser colocada depois da cláusula GROUP BY, sendo
utilizada para estabelecer condições dentro das funções de grupo.

Ademais, a cláusula WHERE não pode ser utilizada para restringir itens de
grupo, de modo que a seguinte declaração da cláusula WHERE é incorreta*/
SELECT Department_ID, Count(*)
FROM Employees
Where MAX(Salary) > 10000
Group by Department_ID
Order by Department_ID;



/*Pode-se usar a cláusula WHERE para restringir linhas individuais. Assim, para
restringir colunas de grupos, utilize a cláusula HAVING.

Você pode limitar a sua seleção incluindo apenas os departamentos 10, 20,
30 e 40, usando a cláusula WHERE quando estiver agrupando por departamento, vejamos:*/
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10, 20, 30, 40)
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > 10000
ORDER BY DEPARTMENT_ID;

/*Por fim, a ordem das cláusulas na declaração SELECT é:
1. SELECT coluna(s).
2. FROM tabela(s).
3. WHERE condição linha.
4. GROUP BY coluna(s).
5. HAVING condição de grupo de linhas.
6. ORDER BY coluna(s).
*/
