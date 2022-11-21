/*Em suma, uma subquery é um comando SELECT
dentro de outro comando SELECT que retorna uma ou
mais linhas a fim de satisfazer a uma cláusula WHERE.*/

/*Uma subpesquisa – subquery – é uma declaração SELECT que é aninhada com
outra declaração SELECT, a qual retorna resultados intermediários.*/

/*EX 1: Quais funcionários possuem salário maior que o de Abel?*/
SELECT last_name, salary
FROM employees
WHERE salary > 
              (SELECT salary
               FROM employees
               WHERE last_name = 'Abel');
               
               
/*EX 2: Mostre o sobrenome – last_name – e o cargo – job_id – dos funcionários que
possuem o mesmo cargo do funcionário de número 141.*/
SELECT last_name, job_id
FROM employees
WHERE job_id = 
              (SELECT job_id
               FROM employees
               WHERE employee_id=141);
                
                
/*EX 3:Para encontrar todos os empregados que têm o mesmo cargo de David Lee,
devemos proceder da seguinte maneira:*/
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = 
              (SELECT job_id
               FROM employees
               WHERE first_name = 'David' and last_name = 'Lee')
ORDER BY first_name;


/*EX 4: Para encontrar todos os empregados do mesmo departamento de David Lee,
devemos proceder da seguinte maneira:*/
SELECT first_name, last_name, job_id, department_id
FROM employees
WHERE department_id = 
                     (SELECT department_id
                      FROM employees
                      WHERE first_name = 'David' and last_name = 'Lee')
ORDER BY first_name;


/*EX 5: Para encontrar os empregados que ganham acima da média salarial, devemos
proceder da seguinte maneira:*/
SELECT first_name, last_name, job_id, department_id, salary
FROM employees
WHERE salary >
              (SELECT AVG(salary)
               FROM employees)
ORDER BY first_name


/*EX 6: Para encontrarmos os empregados que trabalham nos departamentos de
Marketing e Administração, devemos proceder da seguinte maneira:*/
SELECT first_name, last_name, job_id, department_id, salary
FROM employees
WHERE department_id IN 
                      (SELECT department_id
                       FROM departments
                       WHERE department_name IN ('Marketing', 'Administration'))
ORDER BY first_name;


/*-Subpesquisas Aninhadas-
Muitas vezes é necessário envolver vários níveis de subquery’s, como
veremos adiante.*/

/*EX 7: Mostrar o primeiro e último nome, cargo, código do departamento e salário para
os empregados cujo salário é maior que o maior salário no Departamento Sales:*/
SELECT FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT MAX(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                       FROM DEPARTMENTS
                                       WHERE DEPARTMENT_NAME = 'Sales'))
ORDER BY FIRST_NAME;


/*OPERADORES DE COMPARAÇÃO PARA MÚLTIPLAS LINHAS*/

/*
  IN -> Igual a qualquer membro da lista
  ANY -> Compara o valor com cada valor retornado pela subquery
  ALL -> Compara o valor com todos os valores retornados pela subquery
  EXISTS -> Verifica se um valor existe
*/

/*OPERADOR IN*/

/*A seguinte pesquisa se propõe a encontrar os empregados que trabalham nos
departamentos de Marketing e Administração.

Perceba que a subquery retorna uma lista de valores, portanto, neste caso
devemos utilizar o operador IN:*/
SELECT FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Marketing','Administration'))
ORDER BY FIRST_NAME


/*OPERADOR ANY*/

/*Compara o valor com cada valor retornado pela subquery, onde:
• < ANY corresponde ao menor que o maior valor;
• > ANY corresponde ao maior que o menor valor.*/
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE JOB_ID = 'IT_PROG')
AND JOB_ID <> 'IT_PROG';


/*OPERADOR ALL*/

/*Compara o valor com todos os valores retornados pela subquery.*/
SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE JOB_ID = 'IT_PROG')
AND JOB_ID <> 'IT_PROG';


/*OPERADOR EXISTS*/

/*O operador EXISTS é frequentemente utilizado com subpesquisas correlatas.
Testa quando um valor existe; já NOT EXISTS garante que não existe. Se o
valor existir, será retornado verdadeiro; se não existir, será retornado falso.*/

/*Por exemplo, para encontrar os empregados que figuram em um mínimo para uma
pessoa subordinada aos quais, faça o seguinte:*/
SELECT EMPLOYEE_ID, MANAGER_ID, FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT_ID, SALARY
FROM EMPLOYEES E
WHERE EXISTS (SELECT EMPLOYEE_ID
              FROM EMPLOYEES
              WHERE E.MANAGER_ID = EMPLOYEES. EMPLOYEE_ID)
ORDER BY EMPLOYEE_ID;


/*Agora, para encontrar os empregados que não têm departamento relacionado
na tabela DEPARTAMENTS, faça o seguinte:*/
SELECT EMPLOYEE_ID, MANAGER_ID, FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT_ID, SALARY
FROM EMPLOYEES
WHERE NOT EXISTS (SELECT DEPARTMENT_ID
                  FROM DEPARTMENTS
                  WHERE DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID);



/*FUNÇÕES DE DECISÃO*/

/*DECODE*/

/*Temos duas formas de trabalhar com a condição dentro de consultas em Oracle
SQL: CASE e DECODE. Ambas têm a mesma função, que é permitir, de forma
dinâmica e prática, como obter um retorno de uma coluna com base em uma
condição, ou seja, ter a possibilidade de usar condições semelhantes ao IF-THEN ELSE em consultas. 
Vejamos a sintaxe:
DECODE(col/expressão,procurado1,resultado1,...,padrão)
Col/expressão é comparado com cada um dos valores procurados e separados
por vírgula, retornando o resultado se col/expressão for igual ao valor procurado.
Se não for encontrado nenhum dos valores procurados, a função DECODE
retorna o valor padrão; se o valor padrão for omitido, retornará um valor nulo.
Ademais, DECODE deve ter, no mínimo, três parâmetros ou argumentos,
vejamos alguns:
• COL/EXPRESSÃO – nome da coluna ou expressão a ser avaliada;
• PROCURADO1 – o primeiro valor para ser testado;
• RESULTADO1 – o valor para ser retornado se PROCURADO1 for encontrado;
• PROCURADO1 e RESULTADO1 – podem ser repetidos quantas vezes se
fizer necessário, por exemplo:
• (PROCURADO2, RESULTADO2, PROCURADO3, RESULTADO3,...)
• PADRÃO – o valor a ser retornado se nenhum procurado for encontrado.*/

/*Col/expressão pode corresponder
a vários tipos de dados, de modo
que PROCURADO deve ser um
dado do tipo coluna ou expressão.*/

/*O seguinte exemplo decodifica unicamente os cargos dos tipos IT_PROG e
CLERK; enquanto que outros cargos serão padrões alterados para INDEFINIDO:*/
SELECT FIRST_NAME, JOB_ID, 
       DECODE(JOB_ID, 'IT_PROG', 'PROGRAMADOR', 
                      'FI_ACCOUNT', 'CONTADOR', 
                      'INDEFINIDO') DECODE_CARGO
FROM EMPLOYEES;



/*Já no próximo exemplo, deve-se retornar o salário incrementado de acordo com
o tipo de cargo:*/
SELECT FIRST_NAME, JOB_ID, SALARY,
       DECODE(JOB_ID, 'IT_PROG', SALARY*1.1,
              'FI_ACCOUNT', SALARY*1.2,
              'AD_VP', SALARY*0.95, SALARY) DECODE_CARGO
FROM EMPLOYEES;


/*CASE*/

/*A função CASE permite o processamento condicional que exija o tratamento
de várias hipóteses, portanto, possibilita maior flexibilidade na elaboração de
condições; permite também a utilização das condições AND e OR.

Assim, o seguinte exemplo avalia duas expressões lógicas e ainda oferece uma
terceira possibilidade – quando as duas anteriores resultarem falsas:*/
SELECT FIRST_NAME, JOB_ID, SALARY,
       CASE 
           WHEN SALARY < 5000 THEN 'AUMENTO'
           WHEN SALARY > 10000 THEN 'VERIFICAR'
           ELSE 'NÃO AUMENTAR'
        END CLASSIFICAÇÃO
FROM EMPLOYEES;
