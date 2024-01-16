<img src="https://raw.githubusercontent.com/MicaelliMedeiros/micaellimedeiros/master/image/computer-illustration.png" alt="ilustração de um computador" min-width="400px" max-width="400px" width="400px" align="right">

<p align="left"> 
  O objetivo desse projeto visa com segurança armazenar os eventos criados pelo usuário e o envio dos eventos a um servidor. Para alcançar esse objetivo foram implementados ás seguintes soluções abaixo:


<p align="left">
  🦄 Linguagens: **Coloque as linguagens que você desenvolve.**
</p>

<p align="left">
  💼 Ferramentas: **Coloque as suas ferramentas de trabalho.**
</p>

<p align="left">
  💌 Aqui vai uma mensagem para entrar em contato com você: ⤵️
</p>

<p align="left">
  <a href="#" title="Gmail">
  <img src="https://img.shields.io/badge/-Gmail-FF0000?style=flat-square&labelColor=FF0000&logo=gmail&logoColor=white&link=LINK-DO-SEU-GMAIL" alt="Gmail"/></a>
  <a href="#" title="LinkedIn">
  <img src="https://img.shields.io/badge/-Linkedin-0e76a8?style=flat-square&logo=Linkedin&logoColor=white&link=LINK-DO-SEU-LINKEDIN" alt="LinkedIn"/></a>
  <a href="#" title="WhatsApp">
  <img src="https://img.shields.io/badge/-WhatsApp-25d366?style=flat-square&labelColor=25d366&logo=whatsapp&logoColor=white&link=API-DO-SEU-WHATSAPP" alt="WhatsApp"/></a>
  <a href="#" title="Facebook">
  <img src="https://img.shields.io/badge/-Facebook-3b5998?style=flat-square&labelColor=3b5998&logo=facebook&logoColor=white&link=LINK-DO-SEU-FACEBOOK" alt="Facebook"/></a>
  <a href="#" title="Instagram">
  <img src="https://img.shields.io/badge/-Instagram-DF0174?style=flat-square&labelColor=DF0174&logo=instagram&logoColor=white&link=LINK-DO-SEU-INSTAGRAM" alt="Instagram"/></a>
</p>

# PocGlobo 

![Captura de Tela 2024-01-16 às 09 09 06](https://github.com/AlessandroLima/PocGlobo/assets/515100/e45a32b8-6656-456e-9e04-f0c2d3f5cfeb)

> O objetivo desse projeto visa com segurança armazenar os eventos criados pelo usuário e o envio dos eventos a um servidor. Para alcançar esse objetivo foram implementados ás seguintes soluções abaixo:

## Implementações

1. Banco SQLite nativo (O uso do SQLite diminue o custo do IO e garante que não se perca eventos em casos de falta de internet, ou falha no servidor).
2. Criação da tabela de eventos por reflexão automatizando a criação da tabela com base no model Events. Caso a tabela já exista o sistema ignora esse passo.
3. Serviço de envido customizável. O serviço de envio cria uma rotina que roda a cada n segundos, busca 10 evento no banco e envia ao servidor.
4. Criação de rotinas de prevenção de falhas como queda de internet ou falha no vervidor. (Os eventos sá serão apagados da tabela em caso de uma resposta de sucesso no servidor).
5. 
