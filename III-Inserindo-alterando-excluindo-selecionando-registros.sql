/* INSERINDO REGISTROS, 
    A relação de colunas da tabela poderá ser omitida quando forem inclusos valores para todas as 
    colunas dessa tabela na ordem que foram criados os campos.*/
    
INSERT INTO pais
(cd_pais, nm_pais) VALUES (1, 'Brasil');

INSERT INTO pais 
(cd_pais, nm_pais, ds_nacionalidade, dt_inclusao)
VALUES (2,'Alemanha', null, to_date('19/11/2022', 'dd/mm/YYYY'));

INSERT INTO pais 
VALUES (4, 'Chile', 'Chilena', sysdate);

/*Pode-se Trocar a ordem dos campos desde que estejam especificados no insert.*/

INSERT INTO pais 
(nm_pais, dt_inclusao, ds_nacionalidade, cd_pais)
VALUES ('EUA', to_date('24/02/2017', 'dd/mm/YYYY'), 'Americana', 3);

/* ALTERANDO REGISTROS */

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

/* DELETANDO REGISTROS */ 

DELETE FROM Pais 
WHERE Cd_pais = 3;

/*SELECIONANDO REGISTROS,
    O comando SELECT permite Seleção e a manipulação, para visualização das informações armazenadas no banco de dados
        SELECT <<Colunas que quero pesquisar>>
        FROM <<Tabelas que quero pesquisar>>*/
        
/*Todas as colunas*/
SELECT *
FROM departments;

/*Colunas especificas*/
SELECT first_name, email, hire_date
FROM employees;

/*Expressões Aritméticas*/
SELECT first_name, email, salary, salary*12
FROM employees;

/*Colunas com Apelidos (alias)*/
SELECT first_name "Nome", email "E-mail", salary "Salario", salary*12 "Salario Anual"
FROM employees;

/*Colunas concatenadas*/
SELECT first_name, email,'Salario: '|| salary "Salario", salary*12 "Salario Anual"
FROM employees;

/*Quando mostramos o resultado de uma pesquisa normalmente é retornado o 
nome das colunas selecionadas como cabeçalho.
Em alguns exemplos ele pode ser sem sentido. 
Voce pode modificar o cabeçalho de uma coluna usando o sinonimos(alias).
Basta colocar o [alias] depois da coluna no comando SELECT.*/
SELECT first_name "Nome", email "E-mail", salary "Salario", salary*12 "Salario Anual"
FROM employees;

/*A exibição default de consultas são todas as linhas, incluindo as linhas
duplicadas*/
SELECT job_id 
FROM employees 
ORDER BY job_id;
/*Para eliminar valores duplicados no resultado, incluimos o DISTINCT 
qualificador no comando SELECT*/
SELECT DISTINCT job_id 
FROM employees 
ORDER BY job_id;

/*Operadores SQL,
Existem quatro operadores SQL, os quais figuram com todos os tipos de dados:
    BETWEEN...AND... -> Entre dois valores -- inclusive
    IN (lista) -> Comparar uma lista de valores
    LIKE -> Comparar um parametro alfanumerico
    IS NULL -> E um valor nulo
*/

/*O Operador BETWEEN
Compara uma faixa de valores inclusive o menor e maior valor.
Suponhamos que nós quisemos ver aqueles empregados os quais o salario esta entre 10000 e 20000*/
SELECT first_name, Last_name, Salary
FROM Employees
WHERE Salary BETWEEN 10000 AND 20000;

/*O Operador IN
Compara os valores especificados dentro de uma lista.
Para encontrar empregados que tenham um dos tres numeros de 
Manager, ultilize o seguinte comando*/
SELECT first_name, last_name, salary, Manager_id
FROM employees
WHERE Manager_id IN (101, 145, 149);

/*O Operador LIKE
Algumas vezes voce precisa procurar valores que voce nao conhece
exatamente. Usando o operador LIKE e possivel selecionar linhas
combinando parametros alfanumericos. O caracter % é ultilizado como
"coringa" nas pesquisas. Veja exemplo abaixo:

    LIKE '%cadeia' -> Localiza valores que terminem com a cadeia de caracteres
    LIKE 'cadeia%' -> Localiza valores que comecem com a cadeia de caracteres
    LIKE '%cadeia%' -> Localiza valores que tenham a cadeia de caracteres em qualquer parte do campo
*/

/*Nomes com inicial (S)*/
SELECT first_name, last_name, salary
FROM employees
WHERE first_name LIKE 'S%';

/*Nomes com final (n)*/
SELECT first_name, last_name, salary
FROM employees
WHERE first_name LIKE '%n';

/*Nomes (John)*/
SELECT first_name, last_name, salary
FROM employees
WHERE first_name LIKE '%John%';

/*O Operador IS NULL
Verifica quais campos que estão com valores nulos

Unicamente encontrar todos os empregados que nao tenham gerente,
voce testara um valor nulo:*/
SELECT first_name, last_name, salary, Manager_id
FROM employees
WHERE Manager_id IS NULL;


/*Expressões Negativas
Podemos tambem negar todos os operadores estudados:
    NOT BETWEEN -> Tudo que estiver fora da faixa
    NOT IN -> Tudo que não estiver na lista
    NOT LIKE -> Tudo que não conter a linha de caracteres
    IS NOT NULL -> Tudo que não for nulo
*/

/*NOT BETWEEN*/
SELECT first_name, Last_name, Salary
FROM Employees
WHERE Salary NOT BETWEEN 10000 AND 20000;

/*NOT IN*/
SELECT first_name, last_name, salary, Manager_id
FROM employees
WHERE Manager_id NOT IN (101, 145, 149);

/*NOT LIKE*/
SELECT first_name, last_name, salary
FROM employees
WHERE first_name NOT LIKE 'S%';

/*IS NOT NULL*/
SELECT first_name, last_name, salary, Manager_id
FROM employees
WHERE Manager_id IS NOT NULL;


/*Pesquisando Dados com Múltiplas Condições,
Os operadores AND e OR devem ser usados para fazer composições de
expressões lógicas;
• O predicado AND esperará que ambas as condições sejam verdadeiras;
• O predicado OR esperará que uma das condições seja verdadeira.*/

/*Nos dois seguintes exemplos as condições são as mesmas, mas cada resultado
é diferente entre si. 
Veja como o resultado é dramaticamente alterado:*/

/*Para encontrar todos os escriturários do departamento estoque que ganhem
entre 2.000 e 3.000:*/
SELECT first_name, last_name, Salary, Job_ID
FROM Employees
WHERE Salary BETWEEN 2000 AND 3000
            AND Job_id = 'ST_CLERK';
            
/*Para encontrar todos os escriturários do departamento estoque E OS
funcionários que ganhem entre 2.000 e 3.000.*/
SELECT first_name, last_name, Salary, Job_ID
FROM Employees
WHERE Salary BETWEEN 2000 AND 3000
            OR Job_id = 'ST_CLERK';
            
/*Você pode combinar AND e OR na mesma expressão lógica. Ou seja, quando
AND e OR aparecerem na mesma cláusula WHERE, todos os AND serão feitos
primeiro e, posteriormente, todos os OR o serão.*/
SELECT first_name, last_name, Salary, Job_ID
FROM Employees
WHERE Salary > 8000 and
                    Job_id = 'ST_CLERK' OR
                    Job_id = 'ST_MAN';
                    
/*Se você quiser selecionar todos os escriturários e gerentes que ganhem acima
de 8.000, deverá empregar parênteses para estabelecer tal prioridade:*/
SELECT first_name, last_name, Salary, Job_ID
FROM Employees
WHERE Salary > 8000 and
                    (Job_id = 'ST_CLERK' OR
                    Job_id = 'ST_MAN');
                    
                    
/*A Clausula ORDER BY
Normalmente, a ordem das linhas retornadas de uma pesquisa é indefinida.
Assim, a cláusula ORDER BY pode ser empregada para ordenar as linhas.
Se utilizada, ORDER BY deve ser sempre a última cláusula da declaração
SELECT.*/

/*Para ordenar essa consulta pelo campo Last_Name, faça:*/
SELECT first_name, last_name, Salary
FROM Employees
WHERE Salary BETWEEN 10000 and 20000
ORDER BY last_name;

/*Para inverter essa ordem, acrescente o comando DESC – decrescente –depois
do nome das colunas da cláusula ORDER BY*/
SELECT first_name, last_name, Salary
FROM Employees
WHERE Salary BETWEEN 10000 and 20000
ORDER BY last_name DESC;

/*Para ordenar por duas colunas e mostrar a ordem inversa do salário – e ordem
crescente do sobrenome –, faça:*/
SELECT first_name, last_name, Salary
FROM Employees
WHERE Salary BETWEEN 10000 AND 20000
ORDER BY Salary DESC, last_name;

/*Para ordenar por uma coluna, esta não precisa necessariamente estar declarada
no SELECT.

Ademais, a cláusula ORDER BY é empregada na pesquisa quando se quer
mostrar as linhas em uma ordem específica – afinal, sem a cláusula ORDER BY,
as linhas são retornadas na ordem conveniente para o Oracle.

Finalmente, tal comando não altera a ordem dos dados que estão armazenados
no banco de dados*/
