import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:page_transition/page_transition.dart';
import 'package:chara_ql/presentation/character_list/character_list_view.dart';

import 'flutter_graphql_landing_page_route_path.dart';

import 'screens/characters/character_details.dart';


class FlutterGraphQLLandingRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case FlutterGraphQLLandingRoutePaths.characters:
        return PageTransition(
          child: CharacterListView(),
          settings: RouteSettings(name: FlutterGraphQLLandingRoutePaths.characters),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 450),
        );
      break;

      case FlutterGraphQLLandingRoutePaths.characterDetail:
        return PageTransition(
          child: CharacterDetails(characterItem: settings.arguments,),
          settings: RouteSettings(name: FlutterGraphQLLandingRoutePaths.characterDetail ),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 450),
        );
        break;
    }
  }
}
