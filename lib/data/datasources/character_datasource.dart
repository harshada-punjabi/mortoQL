
import 'package:chara_ql/domain/model/character_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CharacterModel>> getCharacters(int page);
}