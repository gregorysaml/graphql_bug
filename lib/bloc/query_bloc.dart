
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

  QueryBloc({@required this.queriesMul}) : super(UserLoading());

    Stream<QueryState> mapEventToState(
    QueryEvent event,
  ) async* {
    try {
      if (event is Loadmyuser) {
        yield* _mapReposToState();
        // } else if (event is UpdateReposAfterMutations) {
        //   yield* _mapUpdateAfterMutatationToState(event.repo);
      } 
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }




    Stream<QueryState> _mapReposToState() async* {
      try {
        yield UserLoading();

        final queryResults = await queriesMul.getUserQuery();
        print('queryResults: $queryResults');

        if (queryResults.hasException) {
          yield UserNotLoaded(queryResults.exception.graphqlErrors);
          return;
        }
        final List<dynamic> repos =
            queryResults.data['GetMobileUserData']['items'] as List<dynamic>;
            
        print('repos: $repos');
        final List<Repo> user = repos.map((dynamic e) => Repo(
            pK: e['PK'] as String,
            sK: e['SK'] as String,
            user: e['USER'] as String,
            name: e['NAME'] as String,
            email: e['EML'] as String,
            mbl: e['MBL'] as String,
            strpi: e['STRPI'] as String)).toList();

            userQuery=user;
        yield UserLoaded(results: user);
      } catch (_, stackTrace) {
// ignore: avoid_print
yield UserNotLoaded(_);
        
      }
    }
  }

