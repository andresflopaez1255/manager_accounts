# Manager Accounts

![Demo](assets/images/loading_app.gif)

## Descripción

**Manager Accounts** es una aplicación desarrollada con Flutter para gestionar cuentas y usuarios de forma sencilla y visual. Está pensada para administracion de perfiles y cuentas de plataformas de streaming.


## Estructura del proyecto

- **lib/**
	- **data/**: Fuentes de datos, repositorios e implementaciones.
	- **domain/**: Entidades y lógica de negocio.
	- **presentation/**: Pantallas, widgets y lógica de UI.
	- **utils/**: Configuración y utilidades (temas, rutas).
- **assets/**: Imágenes y fuentes (por ejemplo `assets/images/` y `assets/fonts/`).
- **ios/**, **android/**: Configuración nativa de cada plataforma.

## Tecnologías utilizadas

- **Flutter** (Dart)
- **Firebase** (firebase_core, firebase_messaging, opcional)
- **flutter_bloc** para gestión de estado
- **dio** para llamadas HTTP
- **shared_preferences** para almacenamiento local

## Instalación

```bash
git clone https://github.com/tuusuario/manager_accounts.git
cd manager_accounts
flutter pub get
```

### Ejecutar en Android

```bash
flutter run -d <android-device-id>
```

### Ejecutar en iOS

1. Asegúrate de tener CocoaPods instalado: `brew install cocoapods`
2. Precache de Flutter para iOS: `flutter precache --ios`
3. Instala pods:

```bash
cd ios
pod install --repo-update
cd ..
flutter run -d <ios-device-id>
```


