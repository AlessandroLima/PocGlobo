# API - DataPlatform Challenge iOS

Esta é uma API de mock apenas para integração do app do Challenge de iOS.

## Iniciando

Para iniciar a API primeiro você deve instalar as dependencias.

Dica: Configure um venv (virtual enviroment) primeiro antes de instalar as dependencias:

```bash
python3 -m venv venv
source venv/bin/activate
```

Para instalar as dependencias, execute o seguinte comando:

```bash
make setup
```

Para executar a api, execute o comando:

```bash
make run
```

## Como fazer uma request

```bash
curl -H "Content-type: application/json" -X POST  localhost:5000/ -d '{"teste": "Hello" }'
```