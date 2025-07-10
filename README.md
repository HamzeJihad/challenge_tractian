# 🚀 Tractian Challenge – Mobile Software Engineer (Flutter)

Os ativos são essenciais para o funcionamento do setor e podem incluir tudo, desde equipamentos de fabricação a veículos de transporte e sistemas de geração de energia. A gestão e a manutenção adequadas são cruciais para garantir que eles continuem operando com eficiência e eficácia. Uma maneira prática de visualizar a hierarquia de ativos é por meio de uma estrutura em árvore.

---

## 🎥 Preview do Projeto


https://github.com/user-attachments/assets/bd010000-1956-4c27-90ae-df06db314e1b


---

## 🏛️ Arquitetura e Decisões de Implementação

A arquitetura do projeto foi pensada para ser **escalável**, **performática** e de **fácil manutenção**, seguindo os princípios do **Clean Architecture** com uma abordagem **MVVM (Model-View-ViewModel)**.

O foco principal foi resolver os três maiores gargalos de performance em uma aplicação deste tipo: **processamento de dados**, **complexidade de algoritmo** e **renderização de listas**.

---

### 1. ⚙️ Performance e Concorrência – Uso de Isolates

A construção e filtragem de uma árvore com muitos nós é uma tarefa computacionalmente intensiva que pode travar a thread principal da UI, causando engasgos e uma má experiência ao usuário.

> ✅ Toda a lógica de construção e filtragem da árvore é executada em uma isolate utilizando `compute`.

Isso garante que a thread de UI permaneça 100% livre para interações e animações, mantendo a navegação fluida independentemente do tamanho da árvore.

---

### 2. 📈 Eficiência de Algoritmo – Construção da Árvore em O(N)

A construção da árvore foi otimizada para **complexidade linear O(N)**, evitando abordagens ingênuas com laços aninhados que levariam a O(N²).

> ✅ Utiliza `Map<String, Node>` para conexão pai-filho em tempo constante `O(1)`.

Essa estrutura garante que o tempo de processamento cresça linearmente com o número de ativos.

---

### 3. 🧱 Renderização Otimizada – Árvore Plana + ListView.builder

Renderizar widgets aninhados para milhares de nós seria um anti-padrão. A solução adotada:

- Transforma a hierarquia em uma `List<VisibleNode>` plana;
- Usa `ListView.builder` com *lazy rendering*;
- Reduz drasticamente o custo de renderização;
- Nenhuma dependência externa foi usada para a UI da árvore — **controle total da performance**.

---

## 📦 Pacotes Utilizados

A seleção de pacotes foi mínima e estratégica:

| Pacote              | Função                                                                 |
|---------------------|------------------------------------------------------------------------|
| `dio`               | Cliente HTTP robusto para chamadas à API da Tractian                   |
| `get_it`            | Injeção de dependência via Service Locator                             |
| `go_router`         | Navegação declarativa com suporte a rotas nomeadas                     |
| `flutter_svg`       | Renderização de ícones no formato SVG                                  |
| `font_awesome_flutter` | Ícones adicionais para complementar os do Material Design         |

---

## ✅ Conclusão

Este projeto demonstra como é possível construir uma interface hierárquica avançada em Flutter com:

- Alta performance de processamento e UI
- Estrutura limpa e escalável
- Estratégias eficazes para grandes volumes de dados

Tudo isso mantendo controle completo da lógica e renderização, sem depender de bibliotecas externas para a árvore visual.

---
