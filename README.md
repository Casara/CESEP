# nTI - CESEP

# Como contribuir?

Para contribuir com o projeto, é necessário ter uma conta no [GitHub](https://github.com) e criar um **fork** deste deste projeto em sua conta.

## O que é um fork?

Um fork é a forma como o GitHub (e não o git!) faz para que alguém possa copiar o projeto para sí e modificar como bem entender, sem que interfira no projeto principal. É muito utilizado para contribuições em outros projetos, que é o nosso caso.

Mais informações: [https://help.github.com/articles/fork-a-repo](https://help.github.com/articles/fork-a-repo)

## OK, tenho um fork do projeto. O que eu faço agora?

Depois de ter um fork do projeto e ter o projeto clonado em sua máquina, é hora de criar um **branch**. Um branch serve para separarmos as modificações que desejamos fazer do **master** do projeto, que teoricamente é o que está em produção. Para isto, temos que executar o seguinte comando (no diretório do projeto):

	$ git checkout -b nome-do-branch
	
## Criei o meu branch, e agora?

Depois de criado o **branch**, você pode fazer as alterações que você quiser no projeto, fazer os commits e então fazer push. Após fazer, poderá entrar na sua página do projeto no GitHub e fazer um pull request ao projeto.