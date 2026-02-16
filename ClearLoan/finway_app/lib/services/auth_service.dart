class AppUser {
  final String phone;
  final String password;
  final String passportId; // only collected at registration
  final String fullName;
  final String workplace;

  const AppUser({
    required this.phone,
    required this.password,
    required this.passportId,
    required this.fullName,
    required this.workplace,
  });
}

/// Simple in-memory auth for hackathon prototype.
/// Replace with Firebase / backend later.
class AuthService {
  static AppUser? _current;
  static AppUser? _registered;

  static bool get isLoggedIn => _current != null;
  static AppUser? get currentUser => _current;

  static String? register({
    required String phone,
    required String password,
    required String passportId,
    required String fullName,
    required String workplace,
  }) {
    if (phone.trim().isEmpty || password.trim().isEmpty) {
      return 'Phone and password are required';
    }
    _registered = AppUser(
      phone: phone.trim(),
      password: password,
      passportId: passportId.trim(),
      fullName: fullName.trim(),
      workplace: workplace.trim(),
    );
    _current = _registered;
    return null;
  }

  static String? login({
    required String phone,
    required String password,
  }) {
    if (_registered == null) return 'No user registered yet';
    if (_registered!.phone != phone.trim()) return 'Incorrect phone number';
    if (_registered!.password != password) return 'Incorrect password';
    _current = _registered;
    return null;
  }

  static void logout() {
    _current = null;
  }
}
