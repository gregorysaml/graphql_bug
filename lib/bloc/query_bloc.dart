import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_bug/bloc/models.dart';
import 'package:graphql_bug/bloc/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

part 'query_event.dart';
part 'query_state.dart';

class QueryBloc extends Bloc<QueryEvent, QueryState> {
  final QueriesMul queriesMul;

  List<Repo> userQuery;

  QueryBloc({@required this.queriesMul}) : super(QueryInitial()) {
    @override
    Stream<QueryState> mapEventToState(
      QueryEvent event,
    ) async* {
      try {
        yield UserLoading();

        final queryResults = await queriesMul.getUserQuery();

        if (queryResults.hasException) {
          yield UserNotLoaded(queryResults.exception.graphqlErrors);
        }
        final List<dynamic> repos =
            queryResults.data['GetMobileUserData']['items'] as List<dynamic>;
        final List<Repo> user = repos.map((dynamic e) => Repo(
            pK: e['PK'] as String,
            sK: e['SK'] as String,
            user: e['USER'] as String,
            name: e['NAME'] as String,
            email: e['EML'] as String,
            mbl: e['MBL'] as String,
            strpi: e['STRPI'] as String));

        yield UserLoaded(results: user);
      } catch (_, stackTrace) {
// ignore: avoid_print
        print('erro $_ and $stackTrace');
      }
    }
  }
}
