# Engenharia_de_software_PPGCC
##Utilização das branchs:

- main: Conjunto funcional ao usuário final, ou seja, todas as funcionalidades propostas estão funcionando, testadas e vão ser disponibilizadas ao usuário final.
- develop: Branch estável de funcionalidades que ainda não forão totalmente exploradas, mas a princípio estão funcionando com execuções válidas e que como não estão na master podem ainda não fazer sentido ao usuário final sendo utilizadas em conjunto com algumas outras funcionalidades.
- BRANCHS DE IMPLEMENTAÇÃO DE FUNCIONALIDADES: A partir da develop criamos uma branch nomeada `feature/NOMEDAFUNCIONALIDADE` (exemplo: `feature/correcao-erros`), indicando o desenvolvimento de algo, uma classe, uma correção, um pedaço de código que será usado por outra feature, mas que sozinho já faz sentido ser nomeado como uma funcionalidade nova. Lembrar que quando terminar uma feature e ela estiver pronta, fazer um merge dessa feature na develop que está online, verificar se não quebrou as funcionalidades da develop rapidamente olhando as alterações que foram realizadas na merge e o ambiente de desenvolvimento e se tudo estiver ok realizar um Push disso, se não, reverta a commit.

Para a nomenclatura das commits utilizar o prefixo do tipo da commit seguido de algum título para ela, o título pode ser em português, agora o prefixo estará dentro desse conjunto (pode ser revisto o conjunto):

- feat: Implementação de feature, pode ser pedaços de feature a branch para desenvolvimento de uma funcionalidade é sua então utilize as commits de modo como quiser, mas feat é para implementação de funcionalidade.
- fix: Correção de problemas
- chore: Mudanças que são mais de preparação e não tem uma implicação aparente como atualização de pacotes, adição de um pacote novo, atualização de um valor de uma variável que tem implicação apenas visual.
