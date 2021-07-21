import 'dart:async';
import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:chara_ql/domain/model/character_domain.dart';
import 'package:chara_ql/presentation/model/character_item.dart';

class FlutterGraphQLStore extends UserStore<Character> {
StreamController<CharacterItem> _userController = StreamController<CharacterItem>();

  Stream<CharacterItem> get userStream => _userController.stream;

  userStore() {
    init();
  }

  @override
  Future<bool> setUser(Character userDto) {
    _userController.sink.add(userDto.mapToPresentation());
    return super.setUser(userDto);
  }

  @override
  Character mapUserDto(decode) {
    print("UserDto> $decode");
    Character character =  Character();
    _userController.sink.add(character.mapToPresentation());
    return character;
  }

  Future<void> init() async {
    Character user = await getLoggedInUserJson();
    _userController.sink.add(user?.mapToPresentation());
  }

  Future<bool> forceLogoutUser() async {
    await removeUser();
    // _userSessionExpired.add(true);
    return true;
  }
}
