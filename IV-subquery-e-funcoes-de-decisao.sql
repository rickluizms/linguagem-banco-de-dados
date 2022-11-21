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








































































































               
               
               
          
