# ClearLoan Flutter App — Deploy/Build Notes

## Set backend URL (local vs production)

This app reads the backend base URL from a build-time define:

- `API_BASE_URL`

### Run locally
Chrome:
```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://127.0.0.1:8000
```

Android emulator:
```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000
```

### Run with deployed backend (Koyeb)
```bash
flutter run -d chrome --dart-define=API_BASE_URL=https://YOUR-APP.koyeb.app
```

## Build APK / AAB (Google Play)

APK:
```bash
flutter clean
flutter pub get
flutter build apk --release --dart-define=API_BASE_URL=https://YOUR-APP.koyeb.app
```

AAB:
```bash
flutter build appbundle --release --dart-define=API_BASE_URL=https://YOUR-APP.koyeb.app
```

After build:
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`
