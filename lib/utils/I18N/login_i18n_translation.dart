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
    LoginPageTranslation.title: 'Veuillez vous connecter 💜',
    LoginPageTranslation.email: 'Email',
    LoginPageTranslation.password: 'Mot de passe',
    LoginPageTranslation.login: 'Connexion',
    LoginPageTranslation.loginSuccess: 'Connexion réussie',
    LoginPageTranslation.loginFailed: 'Erreur lors de la connexion',
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
  welcomeTo,
  MealSCI,
  or,
}

class LoginThirdPageI18n {
  static const Map<LoginThirdPageTranslation, String>
      loginThirdPageTranslation = {
    LoginThirdPageTranslation.title: 'LoginThird',
    LoginThirdPageTranslation.login: 'Se connecter',
    LoginThirdPageTranslation.register: 'Créer un compte',
    LoginThirdPageTranslation.apple: 'Apple',
    LoginThirdPageTranslation.google: 'Google',
    LoginThirdPageTranslation.facebook: 'Facebook',
    LoginThirdPageTranslation.welcomeTo: 'Bienvenue sur ',
    LoginThirdPageTranslation.MealSCI: 'MealSCI',
    LoginThirdPageTranslation.or: 'ou',
  };

  static String? getTranslation(LoginThirdPageTranslation key) {
    return loginThirdPageTranslation[key];
  }
}
