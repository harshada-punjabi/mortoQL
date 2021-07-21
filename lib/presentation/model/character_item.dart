
import 'package:chara_ql/domain/model/character_domain.dart';
import 'package:chara_ql/types/gender.dart';
import 'package:chara_ql/types/vital_status.dart';

class CharacterItem {

  final String id;
  final String name;
  final VitalStatus vitalStatus;
  final Gender gender;
  final String type;
  final String species;
  final String image;

  CharacterItem({
    this.id,
    this.name,
    this.vitalStatus,
    this.gender,
    this.type,
    this.species,
    this.image,

  });

}

extension DomainToPresenationExt on Character {
  CharacterItem mapToPresentation() => CharacterItem(
      id: this.id,
      name: this.name,
      vitalStatus: this.vitalStatus,
    gender: this.gender,
    type: this.type,
    species: this.species,
    image: this.image

  );
}
extension PresentationToDomain on CharacterItem {
  Character mapToPDomain() => Character(
      id: this.id,
      name: this.name,
      vitalStatus: this.vitalStatus,
      gender: this.gender,
      type: this.type,
      species: this.species,
      image: this.image
  );
}
extension CharacterListExtension on List<Character> {
  List<CharacterItem> mapToCharacterListItem() =>
      map((e) => e.mapToPresentation()).toList();
}