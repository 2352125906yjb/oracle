实验1：SQL语句的执行计划分析与优化指导
实验目的
分析SQL执行计划，执行SQL语句的优化指导。理解分析SQL语句的执行计划的重要作用。

实验内容
对Oracle12c中的HR人力资源管理系统中的表进行查询与分析。
首先运行和分析教材中的样例：本训练任务目的是查询两个部门('IT'和'Sales')的部门总人数和平均工资，以下两个查询的结果是一样的。但效率不相同。
设计自己的查询语句，并作相应的分析，查询语句不能太简单。
教材中的查询语句
查询1：

set autotrace on

SELECT d.department_name,count(e.job_id)as "部门总人数",
avg(e.salary)as "平均工资"
from hr.departments d,hr.employees e
where d.department_id = e.department_id
and d.department_name in ('IT','Sales')
GROUP BY d.department_name;

运行结果：

<img src="https://github.com/2352125906yjb/oracle/blob/main/test1/%E5%9B%BE%E7%89%87%E4%B8%80.png">

解释计划：
<img src="https://github.com/2352125906yjb/oracle/blob/main/test1/%E5%9B%BE%E7%89%87%E4%B8%89.png">

查询2
set autotrace on

SELECT d.department_name,count(e.job_id)as "部门总人数",
avg(e.salary)as "平均工资"
FROM hr.departments d,hr.employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_name
HAVING d.department_name in ('IT','Sales');
执行上面两个比较复杂的返回相同查询结果数据集的SQL语句，通过分析SQL语句各自的执行计划，判断哪个SQL语句是最优的。最后将你认为最优的SQL语句通过sqldeveloper的优化指导工具进行优化指导，看看该工具有没有给出优化建议

运行结果：

<img src="https://github.com/2352125906yjb/oracle/blob/main/test1/%E5%9B%BE%E7%89%87%E4%BA%8C.png">

解释计划：
<img src="https://github.com/2352125906yjb/oracle/blob/main/test1/%E5%9B%BE%E7%89%874.png">

实验总结：
对两个代码语句进行了运行和深度比较，发现代码1比代码2的运行速度更快，大概是更加灵活的原因吧
