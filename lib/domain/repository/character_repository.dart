import 'package:dartz/dartz.dart';
import 'package:chara_ql/domain/model/character_domain.dart';
import 'package:chara_ql/error/failures.dart';

abstract class HomeRepository {
  Future<List<Character>> getCharacters(int page);
}
