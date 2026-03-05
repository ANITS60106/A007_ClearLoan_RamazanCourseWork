class AppConfig {
  /// Backend base URL.
  ///
  /// Use --dart-define=API_BASE_URL=... to override for builds/deploy.
  /// Examples:
  /// - Local (Chrome):  http://127.0.0.1:8000
  /// - Android emulator: http://10.0.2.2:8000
  /// - Koyeb:           https://your-app.koyeb.app
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000',
  );
}
