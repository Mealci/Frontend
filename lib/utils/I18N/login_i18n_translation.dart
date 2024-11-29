enum LoginPageTranslation {
  title,
  email,
  password,
  login,
  loginSuccess,
  loginFailed,
  loginPageTranslations,
}

class LoginPageI18n {
  static const Map<LoginPageTranslation, String> loginPageTranslations = {
      LoginPageTranslation.title: 'Login',
      LoginPageTranslation.email: 'Email',
      LoginPageTranslation.password: 'Password',
      LoginPageTranslation.login: 'Login',
      LoginPageTranslation.loginSuccess: 'Login success',
      LoginPageTranslation.loginFailed: 'Login failed',
  };

  static String? getTranslation(LoginPageTranslation key) {
    return loginPageTranslations[key];
  }
}

enum LoginThirdPageTranslation {
  title,
  login,
  register,
  apple,
  google,
  facebook,
}

class LoginThirdPageI18n {
  static const Map<LoginThirdPageTranslation, String> loginThirdPageTranslation = {
      LoginThirdPageTranslation.title: 'LoginThird',
      LoginThirdPageTranslation.login: 'Se connecter',
      LoginThirdPageTranslation.register: 'S\'inscrire avec email',
      LoginThirdPageTranslation.apple: 'Apple',
      LoginThirdPageTranslation.google: 'Google',
      LoginThirdPageTranslation.facebook: 'Facebook',
  };

  static String? getTranslation(LoginThirdPageTranslation key) {
    return loginThirdPageTranslation[key];
  }
}

