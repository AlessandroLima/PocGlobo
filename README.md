<img src="https://raw.githubusercontent.com/MicaelliMedeiros/micaellimedeiros/master/image/computer-illustration.png" alt="ilustração de um computador" min-width="400px" max-width="400px" width="400px" align="right">

<p align="left"> 
  O objetivo desse projeto visa com segurança armazenar os eventos criados pelo usuário e o envio dos eventos a um servidor.
</p>
<p align="left">
  🦄 Linguagem: **Swift com UI feita em SwiftUI, banco de dados SQLite e gerenciamento de pacotes via SPM**
</p>

<p align="left">
  💼 Ferramentas: xCode e VSCode**
</p>

<p align="left">
  💌 Em caso de contato: ⤵️
</p>

<p align="left">
  <a href="#" title="Gmail">
  <img src="https://img.shields.io/badge/-Gmail-FF0000?style=flat-square&labelColor=FF0000&logo=gmail&logoColor=white&link=aletlima@gmail.com" alt="Gmail"/></a>
  <a href="#" title="LinkedIn">
  <img src="https://img.shields.io/badge/-Linkedin-0e76a8?style=flat-square&logo=Linkedin&logoColor=white&link="https://www.linkedin.com/in/alessandro-teixeira-lima-11ba2421/" alt="LinkedIn"/></a>
</p>

# PocGlobo - Envio de eventos.

![Captura de Tela 2024-01-16 às 09 09 06](https://github.com/AlessandroLima/PocGlobo/assets/515100/e45a32b8-6656-456e-9e04-f0c2d3f5cfeb)

> O objetivo desse projeto visa com segurança armazenar os eventos criados pelo usuário e o envio dos eventos a um servidor. Para alcançar esse objetivo foram implementados ás seguintes soluções abaixo:

## Implementações

1. Banco SQLite nativo (O uso do SQLite diminue o custo do IO e garante que não se perca eventos em casos de falta de internet, falha no servidor ou crash do aplicativo).
2. Criação da tabela de eventos por reflexão automatizando a criação da tabela com base no model Events. Caso a tabela já exista o sistema ignora esse passo.
3. Serviço de envido customizável. O serviço de envio cria uma rotina que roda a cada n segundos, busca 10 evento no banco e envia ao servidor.
4. Criação de rotinas de prevenção de falhas como queda de internet ou falha no vervidor. (Os eventos só serão apagados da tabela em caso de uma resposta de sucesso no servidor).
5. Todas ás variáveis de ambiente são customizáveis:(Tipos de eventos, nome do banco, tempo de espera entre envios, número de enventos enviados e dados dos servidor.
6. Foi usado para gerencimento de pacotes o Swift Package Manager que evita erros comuns do CocoaPods.

## 💻 Pré-requisitos

Antes de começar, verifique se você atendeu aos seguintes requisitos:

- Xcode 13.2.1 ou +

## 🚀 Instalando PocGlogo

1. Clone o projeto via Git: git clone https://github.com/AlessandroLima/PocGlobo.git
2. Click em PocGlobo > PocGlobo > PocGlobo.xcodeproj
3. Quando a tela principal do projeto aparecer já terão sido criados 2 eventos (OpenApp e openScreen).
4. Para testes click no botão login e após n segundos ocorrerá o envio de um evento (onclick).
5. Para testes mais avançados click no botão "Adicionar eventos". A cada click você pode adicionar 100 eventos.
