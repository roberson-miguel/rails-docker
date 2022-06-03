# Projeto de CRUD com Sidekiq e Redis

## Pré-requisitos

 - Máquina de desenvolvimento local executando o Ubuntu 18.04
 - Usuário não raiz com privilégios sudo.
 - O Docker instalado no seu computador - [Como instalar Docker](https://docs.docker.com/engine/install/ubuntu/).
 - O Docker Compose instalado em seu computador [Como instalar o Docker-Compose](https://docs.docker.com/compose/install/).
 - Ajustes pós-instalação: [Utilizar Docker sem sudo](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) É preciso reiniciar o PC após essas configurações.

## Para subir o projeto

- Faça um Fork desse projeto.
- Clone esse repositório.
- Acesse a pasta do projeto.

- Crie um arquivo .env na raiz do projeto
```env
DATABASE_NAME=rails_development
DATABASE_USER=sammy
DATABASE_PASSWORD=shark
DATABASE_HOST=database
REDIS_HOST=redis
```

- Compile as imagens de contêiner e crie os serviços

```
docker-compose up -d
```

- Crie e propague seu banco de dados e execute migrações

```
docker-compose exec app bundle exec rake db:setup db:migrate
```

- Abra um terminal e digite:
```
docker-compose up
```

- No seu navegador:
```
http://localhost:3000/
```
ou
```
http://your_server_ip:3000
```

- Clique no botão `Create Shark` para criar o tubarão.
- Será solicitado que coloque um nome de usuário (sammy) e senha (shark)
- Clique em Home, na barra de navegação do site para voltar à página de destino principal do aplicativo. Agora, podemos testar se o Sidekiq está funcionando.

- Clique no botão `Which Sharks Are in Danger?`. Como não fez upload de nenhum tubarão em perigo:
![image](https://user-images.githubusercontent.com/41292851/171695502-8ba2bbd5-17c8-4b4a-a5a1-d91952996cbd.png)

- Clique em `Import Endangered Sharks`para importar os tubarões. 
- Será solicitado que coloque um nome de usuário (sammy) e senha (shark)
- Você verá uma mensagem de status informando que os tubarões foram importados:
![image](https://user-images.githubusercontent.com/41292851/171695711-3738f613-95d7-4769-ac38-88353b1693d7.png)

- Você verá também o início da importação. Atualize sua página para ver a tabela inteira:
![image](https://user-images.githubusercontent.com/41292851/171696159-629bfc9e-9a4d-4ba5-b28b-789908845a43.png)

- Graças ao Sidekiq, o upload de nosso lote grande de tubarões em perigo foi bem-sucedido, sem bloquear o navegador ou interferir com outras funcionalidades do aplicativo.

- Clique no botão `Home`, no final da página, para voltar à página principal do aplicativo:

- A partir daqui, clique em `Which Sharks Are in Danger?` novamente. Você verá os tubarões que foram carregados novamente.

- Agora que sabemos que nosso aplicativo está funcionando corretamente, podemos testar a permanência dos nossos dados.

- Abra um terminal com console rails usando:
```
docker-compose exec app bundle exec rails console
```

Dentro do console, digite o comando abaixo e confira o tubarão que voce criou:
```
Shark.last.inspect
```

- Depois, você poderá verificar se os seus tubarões `Endangered` permaneceram, num total de 73, usando o seguinte comando
```
Endangered.all.count
```
- Caso queira conferir o Sidekiq funcionando
```
docker-compose up -d
```

- Saia do console com `Exit`

- Para sair do projeto
```
docker-compose down
```
