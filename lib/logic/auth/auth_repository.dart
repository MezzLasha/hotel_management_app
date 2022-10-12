class AuthRepository {
  Future<void> login() async {
    print('attempting login...');
    await Future.delayed(const Duration(seconds: 1));
    print('logged in!');
  }

  Future<void> register() async {
    print('attempting to register...');
    await Future.delayed(const Duration(seconds: 1));
    print('registered!');
  }
}
