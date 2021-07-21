import 'package:chara_ql/datasource/local/flutter_graphql_business_store.dart';
import 'package:chara_ql/presentation/base/flutter_graphql_landing_base_view.dart';
import 'package:flutter_base_architecture/data/local/sharedpreferences/user_stores.dart';
import 'package:flutter_base_architecture/data/remote/rest_service.dart';
import 'package:flutter_base_architecture/exception/base_error_handler.dart' as err;
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:chara_ql/data/datasources/character_datasource.dart';
import 'package:chara_ql/data/repository/character_repository_impl.dart';
import 'package:chara_ql/datasource/local/flutter_graphql_business_store.dart';
import 'package:chara_ql/datasource/remote/implementation/character_datasource_impl.dart';
import 'package:chara_ql/domain/model/character_domain.dart';
import 'package:chara_ql/domain/repository/character_repository.dart';
import 'package:chara_ql/domain/usecase/get_character_list_usecase.dart';
import 'package:chara_ql/presentation/base/flutter_graphql_landing_base_view.dart';
import 'package:chara_ql/presentation/model/character_item.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [

  Provider(create:(_) => FlutterGraphQLStore()),
  Provider(create:(_) => FlutterGraphQLLandingErrorParser()),
  Provider(create: (_) => RESTService()),

  // Provider(create: (_) => DataConnectionChecker()),

];

List<SingleChildWidget> uiConsumableProviders = [
  StreamProvider<CharacterItem>(
    initialData: CharacterItem(),
    create: (context) =>
    Provider.of<FlutterGraphQLStore>(context, listen: false).userStream,
  ),

];
List<SingleChildWidget> dependentServices = [
  ProxyProvider<FlutterGraphQLLandingErrorParser,
      err.ErrorHandler<FlutterGraphQLLandingErrorParser>>(
    update: (context, errorParser, errorHandler) =>
        err.ErrorHandler<FlutterGraphQLLandingErrorParser>(errorParser),
  ),

  ProxyProvider<FlutterGraphQLStore, UserStore<Character>>(
    update: (
        context,
        localStore,
        userStore,
        ) =>
    localStore,
  ),
  ProxyProvider<GraphQLClient, HomeRemoteDataSource>(
    update: (context, gql, repository) => HomeRemoteDataSourceImpl(gql),
  ),
  ProxyProvider<HomeRemoteDataSource, HomeRepository>(
    update: (context, dataSource, repository) => HomeRepositoryImpl(dataSource),
  ),
  ProxyProvider<HomeRepository, GetCharactersUseCase>(
    update:
        (context, HomeRepository repo, GetCharactersUseCase usecase) =>
            GetCharactersUseCase(repo),
  ),

];
