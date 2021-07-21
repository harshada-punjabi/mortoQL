import 'package:flutter_base_architecture/dto/base_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chara_ql/types/gender.dart';
import 'package:chara_ql/types/vital_status.dart';

part 'character_domain.freezed.dart';

@freezed
abstract class Character extends BaseDto with _$Character {
  const factory Character({
    @required String id,
    @required String name,
    @required VitalStatus vitalStatus,
    @required Gender gender,
    @required String type,
    @required String species,
    @required String image,
  }) = _Character;

}
