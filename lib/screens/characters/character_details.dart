import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:chara_ql/api_queries/graph_queries.dart'
    show getCharacterDetails;

import 'package:chara_ql/presentation/model/character_item.dart';

class CharacterDetails extends StatelessWidget {

 final CharacterItem characterItem;

  const CharacterDetails(
      {Key key,
     this.characterItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
            document: gql(getCharacterDetails),
            variables: {"id": int.tryParse(characterItem.id)}),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          final characterDetails = result.data['character'];
          final List characterEpisodes = characterDetails['episode'];

          return CustomScrollView(
            slivers: <Widget>[
              SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 300,
                  automaticallyImplyLeading: true,
                  leading: BackButton(
                    color: Colors.amber,
                  ),
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: characterDetails['id'],
                      child: CachedNetworkImage(
                        imageUrl: characterDetails['image'],
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.darken,
                        color: Colors.black12,
                      ),
                    ),
                    title: Text(characterItem.name),
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('STATUS'),
                              Text(characterDetails['status'])
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('SPECIES'),
                              Text(characterItem.species)
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('GENDER'),
                              Text(characterItem.gender.toString())
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text('TYPE'),
                              Text(characterDetails['type'] ?? '')
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'Home Planet 🌍:  ${characterDetails['origin']['name']}'),
                      Text('Episodes with ${characterItem.name}'),
                      Divider(),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: List<Widget>.generate(
                            characterEpisodes.length,
                            (index) => Chip(
                                  label:
                                      Text(characterEpisodes[index]['episode']),
                                )),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
