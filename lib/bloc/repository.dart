import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';
import 'package:graphql_bug/bloc/models.dart';
import 'package:graphql_bug/const/queries.dart';

class QueriesMul {
  final GraphQLClient client;

  QueriesMul({@required this.client}) : assert(client != null);

  Future<QueryResult> getUserQuery() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: parseString(getUserData),
      variables: <String, dynamic>{
        'PK': 'MOB#c48a365d-92bf-43cf-8237-13d7fe10c7df',
      },
      fetchResults: true,
    );

    return await client.query(_options);
  }

  Future<QueryResult> toggleRepoStar(Repo repo) async {
    var document = makeUserMutation;

    final MutationOptions _options = MutationOptions(
      document: parseString(document),
      variables: <String, String>{
        'starrableId': repo.user,
      },
    );

    return await client.mutate(_options);
  }

  
}
