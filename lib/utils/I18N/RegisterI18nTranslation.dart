enum RegisterPageTranslation {
  title,
  email,
  password,
  confirmPassword,
  screenName,
  register,
  login,
  emailEmpty,
  passwordEmpty,
  confirmPasswordEmpty,
  passwordNotMatch,
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
      RegisterPageTranslation.confirmPassword: 'Confirm Password',
      RegisterPageTranslation.screenName: 'Screen Name',
      RegisterPageTranslation.register: 'Register',
      RegisterPageTranslation.login: 'Login',
      RegisterPageTranslation.emailEmpty: 'Email cannot be empty',
      RegisterPageTranslation.passwordEmpty: 'Password cannot be empty',
      RegisterPageTranslation.confirmPasswordEmpty: 'Confirm Password cannot be empty',
      RegisterPageTranslation.passwordNotMatch: 'Password does not match',
      RegisterPageTranslation.emailInvalid: 'Email is invalid',
      RegisterPageTranslation.registerSuccess: 'Register success',
      RegisterPageTranslation.registerFailed: 'Register failed',
  };

  static String? getTranslation(RegisterPageTranslation key) {
    return registerPageTranslations[key];
  }
}