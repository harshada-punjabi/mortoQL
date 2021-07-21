
import 'package:chara_ql/domain/model/character_domain.dart';
import 'package:chara_ql/domain/repository/character_repository.dart';
import 'package:chara_ql/presentation/model/character_item.dart';

import 'usecase.dart';

class GetCharactersUseCase extends BaseUseCase<List<CharacterItem>, CharacterParams> {
final HomeRepository _repository;

GetCharactersUseCase(this._repository);

@override
Future<List<CharacterItem>> buildUseCaseFuture(
    {CharacterParams params}) async {
  List<Character> characterDomainList = await _repository.getCharacters(params.page);
  return characterDomainList.mapToCharacterListItem();
}
}
class CharacterParams {
  CharacterParams(this.page);

  final int page;
}