<div align="center">
  <h1>🌤️ Atmospheric</h1>
  <p><strong>Um aplicativo de clima elegante, dinâmico e nativo construído com Flutter.</strong></p>
  <p>
    <a href="https://flutter.dev/"><img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter"></a>
    <a href="https://dart.dev/"><img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart"></a>
    <a href="https://openweathermap.org/api"><img src="https://img.shields.io/badge/OpenWeather-API-orange?style=for-the-badge&logo=openweathermap" alt="OpenWeather API"></a>
  </p>
</div>

---

## 📖 Visão Geral

O **Atmospheric** é um aplicativo de clima sofisticado e dinâmico, desenvolvido com Flutter, que oferece previsões meteorológicas robustas e granulares. Ele consome de forma inteligente a camada gratuita da API OpenWeather, transformando dinamicamente previsões brutas de 3 horas em modelos preditivos abrangentes e precisos para toda a semana, contornando restrições premium com uma agregação inteligente no frontend.

Projetado com princípios modernos de UI/UX, o Atmospheric apresenta *glassmorphism*, sliders interativos fluidos e layouts estéticos em *bento-grid* para apresentar dados complexos de telemetria de forma limpa.

---

## ✨ Principais Recursos

- **Telemetria Climática em Tempo Real:** Atualizações ao vivo sobre temperatura, umidade, velocidade do vento, pressão e visibilidade.
- **Slider Preditivo de Hora em Hora:** Linha do tempo fluida mapeando o clima para as próximas 24 horas.
- **Previsão de 5 Dias Agregada:** Algoritmo de agregação inteligente que processa 40 pontos de dados individuais da API (a cada 3 horas) em extremos diários de mínima/máxima integrados.
- **Integração de Localização e Geocodificação:** Busca nativamente coordenadas GPS do sistema e realiza geocodificação reversa para nomes de cidades legíveis por humanos.
- **Layout Bento Grid:** Métricas climáticas importantes exibidas em um formato de grade moderno e de fácil digestão.
- **Navegação com Preservação de Estado:** Utiliza uma abordagem de roteamento por pilha indexada para manter processos de fundo ativos enquanto alterna as visualizações sem interrupções.
- **Segurança de Ambiente:** As chaves de API são protegidas através da integração segura com arquivos `.env`.

---

## 🏗️ Arquitetura e Estrutura do Projeto

O projeto adere estritamente a um padrão de UI limpo e orientado a serviços, comum em ambientes Flutter altamente escaláveis. Ele reforça a separação de responsabilidades, dividindo o processamento algorítmico da renderização de widgets.

```text
atmospheric/
├── android/            # Arquivos de projeto nativo Android
├── ios/                # Arquivos de projeto nativo iOS
├── web/                # Arquivos de aplicação Web
├── assets/
│   ├── images/         # Ativos estáticos locais
│   └── .env            # Configuração de ambiente (Não rastreado pelo git)
├── lib/
│   ├── components/     # Estruturas de widgets altamente reutilizáveis e isoladas
│   ├── models/         # DTOs principais da aplicação mapeando JSON
│   ├── pages/          # Pontos de entrada lógicos para o roteamento da aplicação
│   ├── services/       # Abstrações para integração externa (HTTP, Geolocalização)
│   └── main.dart       # Ponto de entrada e configuração de estado global
└── pubspec.yaml        # Gerenciador de dependências do Flutter
```

### 🧠 Divisão da Lógica de Domínio

- **`lib/models/`**: Contém Objetos de Transferência de Dados (DTOs). Mapeamentos JSON complexos convertem respostas HTTP brutas em configurações tipadas prontas para injeção na interface. Inclui entidades como `Weather`, `HourlyForecast` e `DailyForecast`.
- **`lib/services/`**: Implementa o acesso seguro aos endpoints da API e acopla a lógica geográfica aos serviços de geolocalização do sistema operacional, mantendo a busca de dados abstraída do ciclo de vida da UI.
- **`lib/components/`**: Abriga estruturas de layout autocontidas para evitar duplicação. Gerencia componentes globais como a AppBar base e a barra de navegação inferior dinâmica.
- **`lib/pages/`**: As visualizações de rota principais que conectam o estado global com recursos modulares específicos.

---

## 🛣️ Navegação e Roteamento

O Atmospheric implementa uma arquitetura de roteamento por pilha indexada (IndexedStack), garantindo que o progresso do usuário e o estado da aplicação sejam preservados suavemente entre as abas, sem re-renderizações desnecessárias.

1. **`Home / Dashboard View`** (`lib/pages/home.dart`): O núcleo central que computa e renderiza a telemetria ao vivo. Exibe listas de rolagem horizontal de 24 horas e o gráfico de máximas/mínimas processado de 5 dias.
2. **`Location View`** (`lib/pages/location.dart`): Espaço dedicado para métricas localizadas como Índice UV, pôr do sol, Qualidade do Ar (AQI) e previsões estendidas de 7 dias em um layout estético *glassmorphic*.
3. **`Search View`** (`lib/pages/search.dart`): Interface suave para busca de locais globais, exibindo buscas recentes e sugestões populares sobre um mapa global em tons de cinza.
4. **`Settings View`** (`lib/pages/settings.dart`): Dedicado às preferências do usuário. Inclui opções de gerenciamento de tema (Modo Escuro), troca de unidades (Métrico/Imperial), notificações e informações "Sobre".

---

## 📡 Endpoints da API e Sincronização

O Atmospheric utiliza a **API OpenWeather** (Modo Gratuito), estruturada para minimizar requisições de rede enquanto maximiza a informação exibida.

**URL Base**: `https://api.openweathermap.org/data/2.5`

1. **Snapshot do Clima Atual**
   - **Endpoint**: `GET /weather`
   - **Propósito**: Coleta dados climáticos instantâneos baseados nas coordenadas do dispositivo (`lat` e `lon`). Alimenta as métricas estáticas visuais: Temperatura, Visibilidade, Umidade Relativa e Pressão Barométrica.

2. **Matriz de Análise Preditiva (Previsão de 5 Dias)**
   - **Endpoint**: `GET /forecast`
   - **Propósito**: Uma ferramenta abrangente que extrai 40 registros temporais (com intervalo de 3 horas).
   - **Motor de Agregação Interno**:
     - *Escala Horária:* Mapeia diretamente as janelas próximas para formar o slider preditivo de 24 horas.
     - *Computação Diária:* Um modelo personalizado percorre todos os pontos de dados de 3 horas, agrupando-os por dia do calendário. Isola as mínimas (`minTemp`) e máximas (`maxTemp`) absolutas daquele dia para a interface.

3. **Metadados de Poluição do Ar (AQI)**
   - **Endpoint**: `GET /air_pollution`
   - **Propósito**: Coleta indicadores de saúde da qualidade do ar local para mapear valores do Índice de Qualidade do Ar (AQI).

4. **Exposição Ultravioleta (Índice UV)**
   - **Endpoint**: `GET /uvi`
   - **Propósito**: Endpoint utilizado para coletar métricas de intensidade solar para rastreamento de segurança e saúde.

---

## 📦 Dependências Principais

- `http`: Gerencia a camada REST para ingestão da API.
- `geolocator`: Rastreamento posicional dinâmico em tempo real conectado aos sensores GPS nativos.
- `geocoding`: Converte coordenadas globais em nomes de regiões geográficas, resolvendo cidades e estados.
- `flutter_dotenv`: Injetor seguro de tokens de ambiente para proteger as chaves de API.
- `logger`: Gerenciamento profissional de logs no console para monitorar requisições e erros HTTP.

---

## 🚀 Instalação e Configuração

Para rodar o Atmospheric localmente, siga estes passos:

### 1. Pré-requisitos
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Versão 3.11.0 ou superior)
- IDE (VS Code, Android Studio, IntelliJ)
- Emulador Android/iOS ou Dispositivo Físico

### 2. Clonar o Repositório
```bash
git clone https://github.com/seu-usuario/atmospheric.git
cd atmospheric
```

### 3. Instalar Dependências
```bash
flutter pub get
```

### 4. Configurar Variáveis de Ambiente
O Atmospheric requer uma chave da API OpenWeather.
1. Obtenha uma chave gratuita em [OpenWeatherMap](https://openweathermap.org/api).
2. Crie um arquivo `.env` na raiz do projeto.
3. Adicione sua chave no arquivo:
```env
API_KEY=sua_chave_aqui
```

### 5. Rodar a Aplicação
```bash
flutter run
```

---

## 🤝 Contribuição

Contribuições são bem-vindas!
1. Faça um Fork do repositório.
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`).
3. Comite suas mudanças (`git commit -m 'Adiciona MinhaFeature'`).
4. Dê um push na branch (`git push origin feature/MinhaFeature`).
5. Abra um Pull Request.

---

## 📄 Licença

Distribuído sob a Licença MIT. Veja `LICENSE` para mais informações.

---
<div align="center">
  <p><b>ATMOSPHERIC WEATHER ENGINE</b><br><i>"Refinando Seu Céu Desde 2024"</i></p>
</div>
