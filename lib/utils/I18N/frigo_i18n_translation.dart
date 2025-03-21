enum FrigoPageTranslation {
  title,
  qrcode,
  ai,
}

class FrigoPageI18n {
  static const Map<FrigoPageTranslation, String> frigoPageTranslations = {
    FrigoPageTranslation.title: 'Frigo',
    FrigoPageTranslation.qrcode: 'Scannez un QR Code',
    FrigoPageTranslation.ai: "Scannez un ticket de caisse",
  };

  static String? getTranslation(FrigoPageTranslation key) {
    return frigoPageTranslations[key];
  }
}
