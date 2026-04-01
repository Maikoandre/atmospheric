# Atmospheric

Atmospheric é um aplicativo de clima elegante e dinâmico feito em Flutter, capaz de relatar previsões granulares e robustas nativamente. Ele utiliza o plano gratuito da API OpenWeather, desenvolvido dinamicamente em modelos preditivos ricos para a semana toda, contornando completamente as restrições premium.

## 🏗 Arquitetura

O projeto adere a um padrão de UI limpo e orientado a serviços, comum em ambientes Flutter escaláveis. Ele divide estritamente os algoritmos de processamento para simplificar o dimensionamento da lógica:

- `lib/models/`: Contém representações padrão de Data Transfer Object (DTO). Definições de mapeamento JSON complexas convertem dados brutos não estruturados de forma limpa em configurações tipadas prontas para entrar em widgets de UI com segurança.
- `lib/services/`: Abstrai ferramentas de integração externa explicitamente. Implementa com segurança a camada de endpoints de API HTTP enquanto acopla perfeitamente a lógica aos serviços de geolocalização em nível de sistema operacional de forma segura (integrando lógica de cache, traduções de posição e injeções dotenv nativamente longe dos ciclos da UI).
- `lib/components/`: Abriga estruturas de layout isoladas e altamente reutilizáveis, mapeando estados genéricos nativamente, garantindo o mínimo de duplicação na base de código da UI (ex: Appbar base, Navbars inferiores dinâmicos).
- `lib/pages/`: Views de roteamento dedicadas que conectam a lógica de gerenciamento de estado global aos recursos de módulos específicos.

## 🛣️ Rotas e Páginas

Atmospheric implementa uma arquitetura de roteamento por stack indexado (bottom-bar) estático, preservando o estado em segundo plano enquanto alterna Views específicas:

- **`Home / Dashboard View`** (`lib/pages/home.dart`): O núcleo central do aplicativo que renderiza estatísticas detalhadas de telemetria diretamente via endpoints em tempo real. Apresenta diversos visuais interativos deslizantes para modelos dinâmicos preditivos de vários dias.
- **`Location View`** (`lib/pages/location.dart`): Projetado para integrações de rastreamento de localização manual.
- **`Search View`** (`lib/pages/search.dart`): Voltado para pesquisas de localização globais externamente.
- **`Settings View`** (`lib/pages/settings.dart`): Estrutura base destinada a temas, alternância de medidas (Métrico/Imperial) e gerenciamento de configurações de rastreamento de cache de UI.

## 📡 Endpoints da API

Atmospheric usa a **OpenWeather API** (acesso de plano gratuito [Free Tier] otimizado explicitamente), executando a lógica de integração de concorrência dupla com segurança.

**URL Base**: `https://api.openweathermap.org/data/2.5`

1. **Ciclo de Métricas do Clima Atual**
   - **Endpoint**: `GET /weather`
   - **Propósito**: Coleta métricas meteorológicas instantâneas baseadas nos limites rastreados por geolocalização do dispositivo (`lat` e `lon`). Preenche métricas atuais essenciais de forma estática: Temperatura principal, distâncias de Visibilidade, porcentagens de Umidade Relativa e métricas de Pressão Atmosférica. 
   - **Estrutura de Mapeamento**: Decodifica nativamente para o modelo central de base `Weather`.

2. **Matriz de Análise Preditiva (5 Dias)**
   - **Endpoint**: `GET /forecast`
   - **Propósito**: Uma ferramenta de previsão abrangente que puxa 40 métricas individuais a cada 3 horas, representando rigorosamente um ciclo contínuo de prevendo 5 dias completos com limite da licença gratuíta.
   - **Agregação e Sub-roteamento Interno**: 
     - *Integração em Escala Horária:* Mapeado nativamente pela lista para extrair os períodos adjacentes pelo campo `weather.hourly`, gerando marcações das horas AM/PM das próximas horas com precisão para serem passados a Dashboard.
     - *Computação Agregada Diária (Daily):* Um algoritmo construído no Model lê todos os pontos independentes de 3-horas e agrupa organizadamente pelos dias sequentes correspondentes! Ele localiza iterativamente os extremos mínimos (`minTemp`) absolutos e os cumes quentes da temperatura (`maxTemp`) que batem naquele mesmo dia isolado, projetando cada limite final seguro aos cartões agrupados pela fila de `weather.daily` list.

## 📦 Principais Dependências

- `http`: Integrações da camada REST e segurança de rede rápida.
- `geolocator`: Rastreamento dinâmico posicional em tempo real diretamente integrado aos sensores de GPS do respectivo sistema que executa requisição.
- `geocoding`: Estrutura inteligente mapeando dados crus de coordenadas em limites geográficos regionais exatos por aproximações de estado ou cidades.
- `flutter_dotenv`: Mapeador de diretórios restritos integrados em configuração central prevenindo exportes dos tokens e chaves seguras acidentalmente para os versionamentos de controle de ramificações do Github.
