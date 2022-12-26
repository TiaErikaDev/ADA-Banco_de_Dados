--Criação do banco de dados do Exercicio_2_Comercio

--Criando a tabela Funcionario
create table comercial_2_irmaos.Funcionario(
	CodFun serial not null,
	nome varchar (25) not null,
	sobrenome varchar (25) not null,
	nascimento date,
	cargo varchar (20) not null,
	salario integer,
	departamento integer,
	primary key (CodFun)
	);

--Alterando a sequência do codfun para iniciar em 1001
ALTER SEQUENCE funcionario_codfun_seq RESTART WITH 1001;

--Populando a tabela funcionario
insert into comercial_2_irmaos.Funcionario (nome, sobrenome, nascimento, cargo, salario, departamento)
values
('Alberto', 'Silva', '05-01-1990', 'Supervisor', 5000, 102),
('Silvia', 'Pires', '13-05-1985', 'Vendedor', 2500, 102),
('Mário', 'Oliveira', '20-11-1970', 'Diretor', 10000, 104),
('Roberto', 'Albuquerque', '05-03-1981', 'Supervisor', 5300, 101),
('Horácio', 'Almeida', '18-10-1973', 'Gerente', 8000, 103),
('Fabiana', 'Rossi', '07-08-1980', 'Gerente', 8000, 101),
('Maria', 'Silva', '07-03-1979', 'Vendedor', 2700, 102),
('Joana', 'Pereira', '17-04-1965', 'Supervisor', 8000, 103),
('Márcia', 'Sousa', '05-12-1968', 'Gerente', 8500, 105),
('Antônio', 'Santos', '07-02-1988', 'Programador', 3500, 105);

--Visualizando a tabela funcionario
select * from comercial_2_irmaos.Funcionario;

--Criando a tabela departamento
create table comercial_2_irmaos.Departamento(
	CodDep serial not null,
	nome varchar (20) not null,
	local varchar (20),
	funcionario_responsavel integer not null,
	primary key (CodDep),
	foreign key (funcionario_responsavel) references comercial_2_irmaos.Funcionario (CodFun)
	);

--Alterando a sequência do codfun para iniciar em 1001
ALTER SEQUENCE departamento_coddep_seq RESTART WITH 101;

--Populando a tabela departamento
insert into comercial_2_irmaos.Departamento (nome, local, funcionario_responsavel)
values
('Administração', 'Matriz', 1006),
('Vendas', 'Filial', 1001),
('RH', 'Matriz', 1008),
('Diretoria', 'Matriz', 1003),
('CPD', 'Matriz', 1009);

--Visualizando a tabela departamento
select * from comercial_2_irmaos.Departamento;

--Alterando a tabela funcionario e acrescentando a chave estrangeira na coluna departamento
ALTER TABLE comercial_2_irmaos.funcionario
ADD CONSTRAINT fk_id_departamento FOREIGN KEY (departamento) REFERENCES comercial_2_irmaos.Departamento(CodDep);

--Criando a tabela projeto
create table comercial_2_irmaos.Projeto(
	CodProj serial,
	descricao varchar (100),
	funcionario_responsavel integer,
	horas_previstas integer,
	primary key (CodProj),
	foreign key (funcionario_responsavel) references comercial_2_irmaos.Funcionario (CodFun)
	);

--Populando a tabela projeto
insert into comercial_2_irmaos.Projeto (descricao, funcionario_responsavel, horas_previstas)
values 
('Ampliação do setor de vendas', 1001, 100),
('Implantação do sistema de RH', 1009, 80),
('Auditoria interna', 1004, 120);

--Visualizando a tabela projeto
select * from comercial_2_irmaos.Projeto;

--Listar nome e sobrenome ordenado por sobrenome:
select nome, sobrenome from comercial_2_irmaos.funcionario order by sobrenome; 

--Listar todos os campos de funcionários ordenados por departamento:
select * from funcionario order by departamento;

--Liste os funcionários que têm salário superior a R$ 5.000,00 ordenados pelo nome completo:
select nome, sobrenome from comercial_2_irmaos.funcionario where salario > 5000 order by nome, sobrenome;

--Liste a data de nascimento e o primeiro nome dos funcionários ordenados do mais novo para o mais velho:
select nome, nascimento from comercial_2_irmaos.funcionario order by nascimento desc; 

--Liste o total da folha de pagamento:
select sum(salario) as Folha_Pagamento from comercial_2_irmaos.funcionario;

--Liste o nome, o nome do departamento e a função de todos os funcionários:
select f.nome as Nome_funcionário, d.nome as Departamento, f.cargo as Funcão 
from comercial_2_irmaos.funcionario f 
inner join comercial_2_irmaos.departamento d on d.coddep = f.departamento;

--Liste todos departamentos com seus respectivos responsáveis:
select d.nome as Departamento, f.nome, f.sobrenome 
from comercial_2_irmaos.funcionario f 
inner join comercial_2_irmaos.departamento d on d.funcionario_responsavel = f.codfun;

--Liste o valor da folha de pagamento de cada departamento (nome):
select departamento, sum(salario) as Folha_Pagamento 
from comercial_2_irmaos.funcionario 
group by departamento
order by departamento;

--Liste os departamentos dos funcionários que têm a função de supervisor:
select d.coddep, d.nome as Departamento 
from comercial_2_irmaos.funcionario f 
inner join comercial_2_irmaos.departamento d on d.coddep = f.departamento
where cargo = 'Supervisor';

--Liste a quantidade de funcionários desta empresa:
select count(CodFun) Quantidade_Funcionarios from comercial_2_irmaos.funcionario; 

--Liste o salário médio pago pela empresa:
select avg(salario) as Salario_Medio from comercial_2_irmaos.funcionario; 

--Liste o menor salário pago pela empresa em cada departamento:
select departamento, min(salario) as Menor_Salario 
from comercial_2_irmaos.funcionario  
group by departamento
order by departamento;

--Liste o nome do departamento e do funcionário ordenados por departamento e funcionário:
select d.nome as Departamento, f.nome as Funcionario  
from comercial_2_irmaos.funcionario f 
inner join comercial_2_irmaos.departamento d on f.departamento = d.coddep
order by departamento, funcionario;

--Liste os nomes dos funcionários que trabalham no Recursos Humanos:
select f.nome, f.sobrenome, d.nome as departamento 
from comercial_2_irmaos.funcionario f
inner join comercial_2_irmaos.departamento d on f.departamento = d.coddep
where departamento = 103;

--Liste os projetos e os nomes dos responsáveis:
select p.descricao as Projeto, f.nome, f.sobrenome 
from comercial_2_irmaos.funcionario f
inner join comercial_2_irmaos.projeto p on f.codfun = p.funcionario_responsavel;

--Responda as perguntas a seguir:
--○ Qual o comando para aumentar o salário dos funcionários que sejam do setor de
--Vendas, e que não sejam chefe do setor, em 5%?
select nome, cargo, salario, salario + (salario * 5)/100 as Salario_com_aumento 
from comercial_2_irmaos.funcionario f 
where cargo = 'Vendedor';

--Qual o comando para alterar o número de horas previstas para 100 h, do projeto
--“Implantação do sistema de RH”?
UPDATE comercial_2_irmaos.projeto SET horas_previstas = 100 WHERE horas_previstas = 80;

--Quais os comandos para mudar o cargo do funcionário Antônio Santos para
--“Analista” e seu salário para 5000?
UPDATE comercial_2_irmaos.funcionario SET cargo = 'Analista' WHERE nome = 'Antônio';
update comercial_2_irmaos.funcionario set salario = 5000 where nome = 'Antônio';