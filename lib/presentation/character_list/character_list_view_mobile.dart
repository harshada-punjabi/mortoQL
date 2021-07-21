
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:chara_ql/presentation/base/flutter_graphql_landing_base_view.dart';
import 'package:chara_ql/presentation/character_list/character_list_view_model.dart';
import '../../api_queries/graph_queries.dart';
import '../../flutter_graphql_landing_page_route_path.dart';
import '../../screens/characters/character_details.dart';

class CharacterListViewMobile extends FlutterGraphQLBaseModelWidget<CharacterListViewModel>{
  @override
  Widget buildContent(BuildContext context,CharacterListViewModel model) {
    return  Query(
        options: QueryOptions(
            document: gql(getAllCharacters), variables: {"page": 1}),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (model.busy) {
            return Center(child: CircularProgressIndicator());
          }
          if (result.hasException) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
                result.exception.toString(),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
              action: SnackBarAction(label: 'RETRY', onPressed: () {}),
              behavior: SnackBarBehavior.fixed,
            ));
          }

          if (result.data == null) {
            return Column(
              children: [
                Center(
                  child: Image.asset('assets/rick_mort_splash.png'),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                      'Uhh Morty, you do know there is nothing but junk to watch on TV'),
                ),
              ],
            );
          }

          final List characters = result.data['characters']['results'];

          final int charactersResponse =
          result.data['characters']['info']['next'];

          FetchMoreOptions fetchMoreCharacters = FetchMoreOptions(
              variables: {'next': charactersResponse},
              updateQuery: (previousResultData, fetchMoreResultData) {
                final List<dynamic> locales = [
                  ...previousResultData['characters']['results']
                  as List<dynamic>,
                  ...fetchMoreResultData['characters']['results']
                  as List<dynamic>
                ];

                fetchMoreResultData['characters']['results'] = locales;

                return fetchMoreResultData;
              });

          ScrollController _scrollController = ScrollController();
          _scrollController.addListener(() {
            if (_scrollController.position.maxScrollExtent ==
                _scrollController.position.pixels) {
              if (!model.busy) {
                fetchMore(fetchMoreCharacters);
              }
            }
          });

          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (BuildContext context, int index) {
              final character = characters[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  // leading: Hero(
                  //   tag: character['id'],
                  //   child: CachedNetworkImage(
                  //     height: 100,
                  //     imageUrl: character['image'],
                  //     fit: BoxFit.contain,
                  //     //fadeInDuration: Duration(milliseconds: 500),
                  //   ),
                  // ),
                  title: Text(
                    character['name'],
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  subtitle: Text(character['species']),
                  trailing: Text(character['gender']),
                  onTap: () {
                    print('nnbnvnvn ${character['name']}');
                    Navigator.of(context).pushNamed(FlutterGraphQLLandingRoutePaths.characterDetail, arguments: character);
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (_) =>
                        //         CharacterDetails(
                        //           id: character['id'],
                        //           characterName: character['name'],
                        //           characterGender: character['gender'],
                        //           characterSpecies: character['species'],
                        //         ),
                        //   ),
                        // );
                  }
                ),
              );
            },
          );
        });
  }


}




