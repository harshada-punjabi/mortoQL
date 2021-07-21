
import 'package:flutter/material.dart';
import 'package:flutter_base_architecture/responsive/orientation_layout.dart';
import 'package:flutter_base_architecture/responsive/screen_type_layout.dart';
import 'package:chara_ql/presentation/base/flutter_graphql_landing_base_view.dart';
import 'character_list_view_mobile.dart';
import 'character_list_view_model.dart';


class CharacterListView extends FlutterGraphQLBaseView<CharacterListViewModel> {
  CharacterListView();

  @override
  CharacterListViewState createState() => CharacterListViewState();
}

class CharacterListViewState
    extends FlutterGraphQLViewBaseState<CharacterListViewModel, CharacterListView> {


  UserListViewState() {
    setRequiresLogin(false);
  }

  @override
  Widget buildBody() {
    return ScreenTypeLayout(
      mobile: OrientationLayoutBuilder(
          portrait: (context) =>
              CharacterListViewMobile()
      ),
    );
  }

  @override
  PreferredSizeWidget buildAppbar() {
    return AppBar(
      centerTitle: true,
      title: Text('Flutter GraphQL Example'),

    );
  }


  @override
  CharacterListViewModel initViewModel() {
    return CharacterListViewModel();
  }

  @override
  Color statusBarColor() {
    return Color(0xFF181822);
  }
}
