<h1 align='center'>Criando um Banco de dados para um Hospital</h1>

<h2>▹ Etapa 1 - Entendendo o problema</h2>
<h3 align='center'>Analise do Modelo de entidade-relacional para a criação do modelo conceitual</h3>
<p>
O hospital necessita de um sistema para sua área clínica que ajude a controlar consultas realizadas. Os médicos podem ser generalistas, especialistas ou residentes e têm seus dados pessoais cadastrados em planilhas digitais. Cada médico pode ter uma ou mais especialidades, que podem ser pediatria, clínica geral, gastroenterologia e dermatologia. Alguns registros antigos ainda estão em formulário de papel, mas será necessário incluir esses dados no novo sistema.

Os pacientes também precisam de cadastro, contendo dados pessoais (nome, data de nascimento, endereço, telefone e e-mail), documentos (CPF e RG) e convênio. Para cada convênio, são registrados nome, CNPJ e tempo de carência.

As consultas também têm sido registradas em planilhas, com data e hora de realização, médico responsável, paciente, valor da consulta ou nome do convênio, com o número da carteira. Também é necessário indicar na consulta qual a especialidade buscada pelo paciente.

Deseja-se ainda informatizar a receita do médico, de maneira que, no encerramento da consulta, ele possa registrar os medicamentos receitados, a quantidade e as instruções de uso. A partir disso, espera-se que o sistema imprima um relatório da receita ao paciente ou permita sua visualização via internet.
</p>
<h3 align='center'>Construção do Diagrama de entidade-relacional:</h3>
<p>
Pegamos todos os dados visiveis e criamos as conexões dele usando o DER, trazendo a noção de unidade e relacionamento ao nosso projeto(N:N).
</p>
<br>
<img align='center' src='DiagramaER-Hospital.png'/>
<br>

<h2>▹ Etapa 2 - Revisando e simplificando</h2>
<h3 align='center'>Normalizando e criando o Modelo Logico</h3>
<p>
Usando o DER para refinarmos todas as conexões, deixando ela mais precisa.
</p>
<h5 align='center'>Revisão</h5>
<br>
<img align='center' src='ModelagemLogica_Anterior-Hospital.png'/>
<br>
<h5 align='center'>Simplificação</h5>
<br>
<img align='center' src='ModelagemLogica-Hospital.png'/>
<br>

<h2>▹ Etapa 3 - Alimentando BD</h2>
<h3 align='center'>Inserindo dados no modelo fisico</h3>
<p>
Pegamos o dicionario de dados e inserimos no MySQL Workbench 8.0
</p>
<br>
<img align='center' src='dadosInsiridos-Hospital.png'/>
<br>

<h2>▹ Etapa 4 - Melhorando BD</h2>
<h3 align='center'>Alterando informações no BD</h3>
<p>
Modificando e corrigindo se necessario.
</p>
<br>
<img align='center' src='DadosAlterados-Hospital.png'/>
<br>

<h2>▹ Etapa 5 - Consultando dados</h2>
<h3 align='center'>Dando vida ao BD</h3>
<p>
Buscamos e trazemos informações necessarias e uteis do banco de dados
</p>
<br>
<img align='center' src='DadosAlterados-Hospital.png'/>
<br>
