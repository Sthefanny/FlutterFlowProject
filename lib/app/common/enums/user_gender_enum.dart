import 'package:json_annotation/json_annotation.dart';

enum UserGender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
  @JsonValue('preferNotToSay')
  preferNotToSay,
}

extension UserGenderExt on UserGender {
  static const enumMap = {
    UserGender.male: 'Male',
    UserGender.female: 'Female',
    UserGender.preferNotToSay: 'Prefer not to say',
  };

  String get getString => enumMap[this]!;
}
