# Engenharia_de_software_PPGCC

## Github Pages
[Github Pages](https://alissonf216.github.io/modelo-documentacao-projetos/)

## PROJETO: Modelo de FORECASTING Dengue no Brasil 

### Descrição do Projeto: 
O projeto visa desenvolver uma ferramenta com o intuito de realizar previsões do número de casos de dengue no país. A solução disponibilizará uma interface para que o usuário interaja com o modelo de forecasting, definindo a granularidade dessa projeção utilizando dados demográficos históricos como logradouro, unidade federativa, gênero, faixa etária para planejar o futuro.


### Justificativa:
A dengue é uma enfermidade que acomete países tropicais como o Brasil. Anualmente, o debate sobre a necessidade de combater e prevenir a doença ressurge quando ela volta à evidência devido à chegada do verão, onde há tradicionalmente um aumento exponencial de casos. A existência dessa ferramenta se justifica ao usarmos os dados históricos oficiais e torná-los um recurso para facilitar o processo de planejamento para o combate à dengue.


### Fonte de Dados:

- Dataset: [https://data.mendeley.com/datasets/2d3kr8zynf/4](https://data.mendeley.com/datasets/2d3kr8zynf/4)
- Fonte: Sistema de Informação de Agravo de Notificação (SINAN)
- Referência
Sampaio, Vanderson; Endo, Patricia; Lynn, Theo; Oliveira, Thomás; Silva Neto, Sebastião; Medeiros Neto, Leonides; Teixiera, Igor (2022), “Arbovirus clinical data, Brazil, 2013–2020”, Mendeley Data, V4, doi: 10.17632/2d3kr8zynf.4


### Grupo 2
- Flávia Barcellos
- Franklin Aurelio
- Victor Moraes
- Alisson Franclin


## Task Board
[Board](https://github.com/users/FranklinAurelio/projects/1/views/1)


### PLANO DE ESCOPO


Definição de Esforço: 1 a 5, sendo 1 pouquíssimo esforço e 5 muito esforço.


### Etapa 1: Configuração de Projeto 


Recurso: GitHub
- Alinhamento e definição do projeto
- Criação de Repositório 
- Configuração de Projeto 
- Criação de Board de Tarefas


*Esforço Estimado: 2* 
 
## Etapa 2: Base de Dados 


Recurso: Python, Terraform, AWS


- Definição de base de dados 
- Tratamento de dados
- Análise exploratória de dados
- Criação da infraestrutura como código para provisionamento de serviços na nuvem


*Esforço Estimado:  3*


### Etapa 3: Modelagem


Recurso: Stats model, Algoritmo Prophet, Python, C#, .NET

- Análise de Séries Temporais
- Modelagem 
- Treinamento de Modelo 
- Validação de Modelo 


*Esforço Estimado:  4*


### Etapa 4: Integração entre Back e Front 

Recurso: Flutter, .Net, Dart

- Criação dos serviços para consumo das API’s
- Modelagem de dados 
- Desrealização dos dados
- Tratamentos para retornos das APIs
- Criação dos processos assíncronos
- Validação do consumo de dados
 
*Esforço Estimado:  4*
 
### Etapa 5: Front end 


Recurso: Flutter, Dart, Js

- Montagem do ambiente em dart/flutter
- Configuração do ambiente web para a plataforma
- Criação da UI/UX
- Codificação das funcionalidades e telas
- Validação de fluidez


*Esforço Estimado:  3*
  
### Etapa 6: Infra 
 
- Provisionamento de serviços de computação em nuvem da AWS
- CloudFront, serviço de CDN para entrega da aplicação front-end
- S3, serviço de storage, para armazenamento da aplicação front-end
- App Runner, serviço de aplicação para hospedagem da aplicação back-end
- Lambda Function, serviço de execução de código sem servidor
- Criação do código terraform para implantação da infraestrutura AWS 
 *Esforço Estimado: 3*
 
### Etapa 7: Documentação 


- Descrição de frameworks e requisitos técnicos
- Montagem de ambiente
- Funcionalidades
- Controle de versão
 
*Esforço Estimado:  2*


### Utilização das branchs:

- main: Conjunto funcional ao usuário final, ou seja, todas as funcionalidades propostas estão funcionando, testadas e vão ser disponibilizadas ao usuário final.
- develop: Branch estável de funcionalidades que ainda não forão totalmente exploradas, mas a princípio estão funcionando com execuções válidas e que como não estão na master podem ainda não fazer sentido ao usuário final sendo utilizadas em conjunto com algumas outras funcionalidades.
- BRANCHS DE IMPLEMENTAÇÃO DE FUNCIONALIDADES: A partir da develop criamos uma branch nomeada `feature/NOMEDAFUNCIONALIDADE` (exemplo: `feature/correcao-erros`), indicando o desenvolvimento de algo, uma classe, uma correção, um pedaço de código que será usado por outra feature, mas que sozinho já faz sentido ser nomeado como uma funcionalidade nova. Lembrar que quando terminar uma feature e ela estiver pronta, fazer um merge dessa feature na develop que está online, verificar se não quebrou as funcionalidades da develop rapidamente olhando as alterações que foram realizadas na merge e o ambiente de desenvolvimento e se tudo estiver ok realizar um Push disso, se não, reverta a commit.

Para a nomenclatura das commits utilizar o prefixo do tipo da commit seguido de algum título para ela, o título pode ser em português, agora o prefixo estará dentro desse conjunto (pode ser revisto o conjunto):

- feat: Implementação de feature, pode ser pedaços de feature a branch para desenvolvimento de uma funcionalidade é sua então utilize as commits de modo como quiser, mas feat é para implementação de funcionalidade.
- fix: Correção de problemas
- chore: Mudanças que são mais de preparação e não tem uma implicação aparente como atualização de pacotes, adição de um pacote novo, atualização de um valor de uma variável que tem implicação apenas visual.
