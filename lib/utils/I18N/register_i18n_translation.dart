enum RegisterPageTranslation {
  title,
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
      RegisterPageTranslation.title: 'Register',
      RegisterPageTranslation.email: 'Email',
      RegisterPageTranslation.password: 'Password',
      RegisterPageTranslation.firstName: 'First name',
      RegisterPageTranslation.lastName: 'Last name',
      RegisterPageTranslation.age: 'Age',
      RegisterPageTranslation.register: 'Register',
      RegisterPageTranslation.emailEmpty: 'Email cannot be empty',
      RegisterPageTranslation.passwordEmpty: 'Password cannot be empty',
      RegisterPageTranslation.emailInvalid: 'Email is invalid',
      RegisterPageTranslation.registerSuccess: 'Register success',
      RegisterPageTranslation.registerFailed: 'Register failed',
  };

  static String? getTranslation(RegisterPageTranslation key) {
    return registerPageTranslations[key];
  }
}