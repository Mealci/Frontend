import 'package:mealci/models/poop_enums.dart';

class Poop {
  StoolComposition stoolComposition;
  int quantity;
  Feeling feeling;
  bool hasExcessiveFlatulence;
  bool hasPain;
  bool hasAbdominalBloating;
  bool hasMucus;
  bool hasFoodResidue;
  bool hasColic;
  bool hasUnusualSmells;

  Poop({
    required this.stoolComposition,
    required this.quantity,
    required this.feeling,
    required this.hasExcessiveFlatulence,
    required this.hasPain,
    required this.hasAbdominalBloating,
    required this.hasMucus,
    required this.hasFoodResidue,
    required this.hasColic,
    required this.hasUnusualSmells,
  });

  factory Poop.fromJson(Map<String, dynamic> json) {
    return Poop(
      stoolComposition: json['stoolComposition'],
      quantity: json['quantity'],
      feeling: json['feeling'],
      hasExcessiveFlatulence: json['HasExcessiveFlatulence'],
      hasPain: json['HasPain'],
      hasAbdominalBloating: json['HasAbdominalBloating'],
      hasMucus: json['HasMucus'],
      hasFoodResidue: json['HasFoodResidue'],
      hasColic: json['HasColic'],
      hasUnusualSmells: json['HasUnusualSmells'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stoolComposition':
          stoolComposition.toString().toUpperCase().split('.').last,
      'quantity': quantity,
      'feeling': feeling.toString().toUpperCase().split('.').last,
      'HasExcessiveFlatulence': hasExcessiveFlatulence,
      'HasPain': hasPain,
      'HasAbdominalBloating': hasAbdominalBloating,
      'HasMucus': hasMucus,
      'HasFoodResidue': hasFoodResidue,
      'HasColic': hasColic,
      'HasUnusualSmells': hasUnusualSmells,
    };
  }
}
