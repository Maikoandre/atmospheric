# Atmospheric 🌦️

Atmospheric é um aplicativo de clima moderno, elegante e intuitivo desenvolvido com Flutter. O projeto foca em uma interface de usuário limpa e informativa, utilizando padrões de design contemporâneos.

## ✨ Funcionalidades

- **Visão Geral em Tempo Real:** Card principal com localização, temperatura atual, condição climática e variações (máxima e mínima).
- **Métricas Detalhadas:** Visualização rápida de Humidade, Vento, Sensação Térmica e Visibilidade.
- **Previsão Horária:** Acompanhe a mudança do tempo nas próximas 24 horas através de uma lista horizontal interativa.
- **Previsão de 7 Dias:** Planeje sua semana com uma visão detalhada das temperaturas e condições para os próximos dias, incluindo barras de intervalo térmico.
- **Design Moderno:** Interface com gradientes suaves, sombras sutis e tipografia legível para uma experiência de usuário premium.

## 🚀 Tecnologias

- [Flutter](https://flutter.dev/) - Framework UI da Google
- [Dart](https://dart.dev/) - Linguagem de programação

## 📸 Interface

O design do Atmospheric utiliza uma paleta de cores baseada em tons de azul (`blueAccent` e `lightBlue`), proporcionando uma sensação de clareza e frescor.

*   **Página Inicial:** Layout unificado com cards informativos.
*   **Bento Grid:** Organização eficiente de dados meteorológicos secundários.
*   **Forecast:** Visualização clara de tendências temporais.

## 🛠️ Como Executar

### Pré-requisitos

- Flutter SDK instalado em sua máquina.
- Um emulador (Android/iOS) ou dispositivo físico conectado.

### Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/Maikoandre/atmospheric.git
   ```

2. Navegue até o diretório do projeto:
   ```bash
   cd atmospheric
   ```

3. Instale as dependências:
   ```bash
   flutter pub get
   ```

4. Execute o aplicativo:
   ```bash
   flutter run
   ```

## 🏗️ Estrutura do Projeto

```text
lib/
├── main.dart          # Ponto de entrada do app
├── components/        # Widgets reutilizáveis (em desenvolvimento)
└── pages/
    ├── home.dart      # Dashboard principal de clima
    ├── location.dart  # Gerenciamento de locais (em breve)
    ├── search.dart    # Busca de cidades (em breve)
    └── settings.dart  # Configurações do app
```

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
Desenvolvido com ❤️ por Maiko
