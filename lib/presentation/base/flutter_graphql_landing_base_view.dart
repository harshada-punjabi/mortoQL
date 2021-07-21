import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base_architecture/exception/base_error.dart';
import 'package:flutter_base_architecture/exception/base_error_parser.dart';
import 'package:flutter_base_architecture/ui/base_model_widget.dart';
import 'package:flutter_base_architecture/ui/base_statefulwidget.dart';
import 'package:flutter_base_architecture/ui/base_widget.dart';
import 'package:flutter_base_architecture/viewmodels/base_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chara_ql/domain/model/character_domain.dart';

import '../../flutter_graphql_landing_page_route_path.dart';


class FlutterGraphQLLandingBaseViewModel extends BaseViewModel {
  bool _dataChanged = false;

  bool get hasDataChanged => _dataChanged;

  set dataChanged(bool value) {
    _dataChanged = value;
  }

  FlutterGraphQLLandingBaseViewModel({busy = false}) : super(busy: busy);
}

abstract class FlutterGraphQLBaseView<VM extends FlutterGraphQLLandingBaseViewModel>
    extends BaseStatefulWidget<VM> {
  FlutterGraphQLBaseView({Key key}) : super(key: key);
}

abstract class FlutterGraphQLViewBaseState<VM extends FlutterGraphQLLandingBaseViewModel,
        T extends FlutterGraphQLBaseView<VM>>
    extends BaseStatefulScreen<VM, T, FlutterGraphQLLandingErrorParser, Character> {
  ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  PreferredSizeWidget buildAppbar() {
    return PreferredSize(
      child: SizedBox.shrink(),
      preferredSize: Size(0, 0),
    );
  }


  void onModelReady(VM model) {
    model.onErrorListener((error) {
      showUserListToastMessage(getErrorMessage(error));
    });
  }

  @override
  Future<bool> userIsLoggedIn() async {
    bool status = await super.userIsLoggedIn();
    if (!status) {
      // TODO: Creating a temporary user with no onboarding experience
      await getLoggedInUser();
    }
    return status;
  }

  @override
  Widget getLayout() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor(),
      ),
      child: BaseWidget<VM>(
          viewModel: getViewModel(),
          onModelReady: onModelReady,
          builder: (context, VM model, Widget child) {
            return DefaultTabController(
              length: 2,
              child: SafeArea(
                child: Scaffold(
                    backgroundColor: scaffoldColor(),
                    key: scaffoldKey,
                    extendBodyBehindAppBar: extendBodyBehindAppBar(),
                    extendBody: extendBody(),
                    appBar: buildAppbar(),
                    body: buildBody(),
                    bottomNavigationBar: buildBottomNavigationBar(),
                    floatingActionButton: floatingActionButton(),
                    floatingActionButtonLocation: floatingActionButtonLocation(),
                    floatingActionButtonAnimator: floatingActionButtonAnimator(),
                    persistentFooterButtons: persistentFooterButtons(),
                    drawer: drawer(),
                    endDrawer: endDrawer(),
                    bottomSheet: bottomSheet(),
                    resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
                    drawerDragStartBehavior: drawerDragStartBehavior(),
                    drawerScrimColor: drawerScrimColor(),
                    drawerEdgeDragWidth: drawerEdgeDragWidth()),
              ),
            );
          }),
    );
  }

  @override
  String onBoardingRoutePath() {
    return FlutterGraphQLLandingRoutePaths.characters;
  }

  @override
  String widgetErrorMessage() {
    return 'unexpected error';
  }

  @override
  String errorLogo() {
    return '';
  }

  @override
  Color scaffoldColor() {
    return Colors.white;
  }

  bool extendBodyBehindAppBar() {
    return true;
  }

  bool extendBody() {
    return false;
  }
}

class CharacterListLandingError extends BaseError {
  CharacterListLandingError({
    message,
    type,
    error,
    stackTrace,
  }) : super(message: message, type: type, error: error);
}

class CharacterListLandingErrorType extends BaseErrorType {
  const CharacterListLandingErrorType(value) : super(value);
  static const CharacterListLandingErrorType INTERNET_CONNECTIVITY =
      const CharacterListLandingErrorType(1);
  static const CharacterListLandingErrorType INVALID_RESPONSE =
      const CharacterListLandingErrorType(2);
  static const CharacterListLandingErrorType SERVER_MESSAGE =
      const CharacterListLandingErrorType(3);
  static const CharacterListLandingErrorType OTHER =
      const CharacterListLandingErrorType(4);
}

class FlutterGraphQLLandingErrorParser extends BaseErrorParser {
  FlutterGraphQLLandingErrorParser() : super();
}

abstract class FlutterGraphQLBaseModelWidget<VM>
    extends BaseModelWidget<VM, FlutterGraphQLLandingErrorParser> {
  ThemeData _theme;

  ThemeData get theme => _theme;

  @override
  @mustCallSuper
  Widget build(context, VM model) {
    return buildContent(context, model);
  }

  Widget buildContent(BuildContext context, VM model);
}

showUserListToastMessage(
  String message, {
  Color backgroundColor,
  Color textColor,
  ToastGravity gravity: ToastGravity.BOTTOM,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 3,
    backgroundColor: backgroundColor != null
        ? backgroundColor
        : Colors.black.withOpacity(0.5),
    textColor: textColor != null ? textColor : Colors.white,
    fontSize: 14,
  );
}
