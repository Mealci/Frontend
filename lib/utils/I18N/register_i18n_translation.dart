enum RegisterPageTranslation {
  title1,
  title2,
  email,
  password,
  register,
  firstName,
  lastName,
  age,
  emailEmpty,
  passwordEmpty,
  emailInvalid,
  registerSuccess,
  registerFailed,
  registerPageTranslations,
}

class RegisterPageI18n {
  static const Map<RegisterPageTranslation, String> registerPageTranslations = {
    RegisterPageTranslation.title1: 'Veuillez vous ',
    RegisterPageTranslation.title2: 'inscrire 💜',
    RegisterPageTranslation.email: 'E-mail',
    RegisterPageTranslation.password: 'Mot de passe',
    RegisterPageTranslation.firstName: 'Prénom',
    RegisterPageTranslation.lastName: 'Nom de famille',
    RegisterPageTranslation.age: 'Âge',
    RegisterPageTranslation.register: 'S\'inscrire',
    RegisterPageTranslation.emailEmpty: 'L\'e-mail ne peut pas être vide',
    RegisterPageTranslation.passwordEmpty:
        'Le mot de passe ne peut pas être vide',
    RegisterPageTranslation.emailInvalid: 'L\'e-mail est invalide',
    RegisterPageTranslation.registerSuccess: 'Inscription réussie',
    RegisterPageTranslation.registerFailed: 'Inscription échouée',
  };

  static String? getTranslation(RegisterPageTranslation key) {
    return registerPageTranslations[key];
  }
}
