
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';

import 'package:chara_ql/domain/usecase/get_character_list_usecase.dart';
import 'package:chara_ql/presentation/base/flutter_graphql_landing_base_view.dart';
import 'package:chara_ql/presentation/model/character_item.dart';


class CharacterListViewModel extends FlutterGraphQLLandingBaseViewModel {
  CharacterListViewModel({this.getCharactersUseCase});
  List<CharacterItem> _characterList = [];

  GetCharactersUseCase getCharactersUseCase;

  List<CharacterItem> get characterList => _characterList;

  bool notConnected = false;

  set characterList(List<CharacterItem> value) {
    _characterList = value;
    notifyListeners();
  }


  void refresh() {
    notifyListeners();
  }

  Future<dynamic> getCharacterList({CharacterParams params}) async {
    //if the data is loading
    setBusy(true);
    List<CharacterItem> result =
    await getCharactersUseCase.buildUseCaseFuture(params: params).catchError((error) {
      print("error> ${error.toString()}");
      if(error.toString().toLowerCase().compareTo('Connection to API server failed due to internet connection'.toLowerCase())==0) {
        notConnected = true;
      }
      setBusy(false);
    }, test: (error) => error is CharacterListLandingError);
    if (result != null) {
      characterList.addAll(result);
      print('length of the user list is as follows ${characterList.length}');
    }
    setBusy(false);
  }

}
