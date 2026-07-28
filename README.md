# Digidex Evolutiva
 
Enciclopedia interactiva de Digimon para iPhone, iPad y Mac. Explora las sagas animadas, consulta la ficha de cada Digimon, navega por sus cadenas evolutivas y guarda tus favoritos.
 
---
 
## Capturas de pantalla
 
> Añade aquí las capturas del simulador cuando las tengas.
 
---
 
## Stack tecnológico
 
| Capa | Tecnología |
|---|---|
| Lenguaje | Swift 5.10 |
| UI | SwiftUI (iOS 17+) |
| Arquitectura | MVVM |
| Estado | `@Observable` en ViewModels · `@Environment` en Views |
| Datos (Fase 1) | JSON local + Assets Catalog |
| Persistencia | UserDefaults |

| Plataformas | iPhone · iPad · Mac |
 
---
---
 
## Funcionalidades
 
- **Home** — 4 sagas animadas con desplegable en cascada (Adventure, Adventure 02, Tamers, Frontier). Protagonistas y antagonistas de cada saga con badges de color.
- **DigiDex** — Lista completa de Digimon con búsqueda en tiempo real y filtros por nivel evolutivo.
- **Detalle** — Ficha completa con imagen, atributos, debilidades y navegación recursiva por la cadena evolutiva navegando entre fichas.
- **Favoritos** — Grid de 2 columnas con los Digimon marcados como favoritos. Persiste entre sesiones con UserDefaults.
- **Perfil** — Avatar, nombre de usuario y opciones para cambiar nombre, contraseña y foto de perfil.
- **Auth** — Login y Registro con validación de campos y hash de contraseña.

---
 
# Estructura del proyecto
 
```
DigiDex/
├── App/
│   ├── Models/
│   │   ├── DigimonsModel.swift         → Digimon: nivel, atributo, cadena evolutiva
│   │   ├── SagaModel.swift             → Saga: destacados con rol y orden
│   │   └── UserModel.swift             → Usuario para autenticación local
│   │
│   ├── ViewModels/
│   │   ├── AuthViewModel.swift              → login, registro y sesión (@Observable)
│   │   ├── DigiDexViewModel.swift           → búsqueda y filtros (@Observable)
│   │   ├── DigimonStore.swift               → fuente de verdad de datos (@Observable)
│   │   ├── FavoriteViewModel.swift          → favoritos con UserDefaults (@Observable)
│   │   └── HomeViewModel.swift              → desplegable de sagas (@Observable)
│   │
│   └── Views/
│       ├── DigiDex/
│       │   ├── Detaill/
│       │   │   └── DigimonDetailView.swift
│       │   └── DigiDexView.swift
│       ├── Favorites/
│       │   ├── FavoriteCardView.swift
│       │   └── FavoritesView.swift
│       ├── Home/
│       │   ├── HomeView.swift
│       │   └── SagaCardView.swift
│       ├── Perfil/
│       │   └── ProfileView.swift
│       ├── Sesion/
│       │   ├── AuthContenVeiw.swift
│       │   ├── LoginView.swift
│       │   └── RegisterView.swift
│       ├── Splash/
│       │   └──SplashView.swift
│       ├── mainTabView.swift
│       └── Root.swift
│
├── Data/
│   ├── digimon.json                    → 42 Digimon con evoluciones completas
│   └── saga.json                       → 4 sagas con Digimon destacados
│
├── Extesions/
│   ├── AppTab.swift                    → enum de tabs del TabBar
│   ├── BadgesView.swift                → badge reutilizable con color
│   ├── CardBackground.swift            → ViewModifier digidexCardStyle
│   ├── CustomTabBar.swift              → tab bar personalizado
│   ├── DigimonImageView.swift          → imagen con fallback de iniciales
│   ├── DigimonRow.swift                → fila reutilizable para lista y Home
│   └── SagaLogoView.swift              → logo de saga con fallback
│
├── Service/
│   └── JSONLoader.swift                → carga genérica de JSON desde el bundle
│
├── Assets/
└── DigiDexApp.swift                    → entry point, inyección de @Environment
```
 
---

## Modelo de datos
 
### Digimon
 
```json
{
  "id": 3,
  "name": "Agumon",
  "level": "Rookie",
  "attribute": "Vaccine",
  "type": "Reptile",
  "description": "Pequeño Digimon reptil con gran potencial evolutivo.",
  "image": "agumon",
  "weaknesses": ["Virus", "Agua"],
  "evolvesFrom": ["Koromon"],
  "evolvesTo": ["Greymon"]
}
```
 
### Saga
 
```json
{
  "id": 1,
  "name": "Digimon Adventure",
  "season": 1,
  "logo": "logo_adventure",
  "year": 1999,
  "featured": [
    { "digimonId": 3,  "role": "protagonist", "order": 1 },
    { "digimonId": 15, "role": "antagonist",  "order": 7 }
  ]
}
```
---
## Sistema de atributos
 
Los atributos funcionan como piedra-papel-tijera:
 
```
Vaccine → vence a → Virus
Virus   → vence a → Data
Data    → vence a → Vaccine
```
 
---
 
## Paleta de colores
 
| Token | Hex | Uso |
|---|---|---|
| `digidexBackground` | `#0F0F1A` | Fondo principal |
| `digidexSurface` | `#1A1A2A` | Superficies e inputs |
| `digidexCard` | `#222235` | Cards y filas |
| `digidexBlue` | `#3B82F6` | Protagonistas · Champion · Vaccine |
| `digidexRed` | `#C0392B` | Antagonistas · Virus · Mega · errores |
| `digidexAmber` | `#F59E0B` | Tab activo · Ultimate |
| `digidexGreen` | `#24B46D` | Rookie · Data |
| `digidexTextSecondary` | `#9499AA` | Texto secundario |
| `digidexBorder` | `#2A2A40` | Bordes de 0.5px |
| `digidexTabBar` | `#12121E` | Fondo del tab bar |
 
---
## Desarrollado por
 
**Osasu Sánchez**
Julio · 2026
 
---
