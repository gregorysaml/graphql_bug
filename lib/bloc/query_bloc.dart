// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_bug/bloc/models.dart';
import 'package:graphql_bug/bloc/repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

part 'query_event.dart';
part 'query_state.dart';

class QueryBloc extends Bloc<QueryEvent, UserState> {
  final QueriesMul queriesMul;

  List<Repo> userQuery;

  QueryBloc({@required this.queriesMul}) : super(UserLoading());

    @override
  Stream<UserState> mapEventToState(
    QueryEvent event,
  ) async* {
    try {
      if (event is Loadmyuser) {
        yield* _mapReposToState();
        } else if (event is MakeMyUser) {
          yield* mutationCreateUser();
      } 
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield state;
    }
  }




    Stream<UserState> _mapReposToState() async* {
      try {
        List userlist=[];
        yield UserLoading();

        final queryResults = await queriesMul.getUserQuery();
        print('queryResults: $queryResults');

        if (queryResults.hasException) {
          yield UserNotLoaded(queryResults.exception.graphqlErrors);
          return;
        }

         

        final List<dynamic> repos =
            queryResults.data['GetMobileUserData']['items'] as List<dynamic>;
            final storage= FlutterSecureStorage();
            await storage.write(key: 'UserData', value: repos[0].toString());

        // List data=queryResults.data['GetMobileUserData']['items'];
        // print('data: $data');
        // List<Repo> userr=[];
        //  data.forEach((e) {
        //    userr.add(Repo(
          
        //     pK: e['PK'] as String,
        //     sK: e['SK'] as String,
        //     user: e['USER'] as String,
        //     name: e['NAME'] as String,
        //     email: e['EML'] as String,
        //     mbl: e['MBL'] as String,
        //     strpi: e['STRPI'] as String)); });
       
        final List<Repo> user = (repos).map((dynamic e) => Repo(
          
            pK: e['PK'] as String,
            sK: e['SK'] as String,
            user: e['USER'] as String,
            name: e['NAME'] as String,
            email: e['EML'] as String,
            mbl: e['MBL'] as String,
            strpi: e['STRPI'] as String)).toList();

            userQuery=user;

            userlist=List.from(user);

          
            
            print('test ${user.first.pK}');
        yield UserLoaded(results: user);
      } catch (_, stackTrace) {
// ignore: avoid_print
print('$_ $stackTrace');
yield UserNotLoaded(_);
        
      }
    }


    Stream<UserState> mutationCreateUser () async* {
    try {


      final queryResults = await queriesMul.makeUserMutation();
      print('queryResults: $queryResults');
      final result=queryResults.exception.graphqlErrors;
      print('result: $result');

      if (queryResults.hasException) {
        // @TODO Improve error handling here, may be introduce a hasError Method
        if(queryResults.exception.linkException is NetworkException){
          yield NetworkEx(error: queryResults.exception.linkException.toString());
        }

        // if(true  )
        // yield UserExist(error: queryResults.exception.graphqlErrors);


        print('queryResults ${queryResults.data}');
        final yeah =queryResults.exception.graphqlErrors;
        final tset =yeah[0].message;
        print('tset: $tset');
        print('yeah: ${yeah[0].message}');
        return;
      }

      yield UserLoaded(results:userQuery );
    } catch (error) {
      print('error: $error');
    
    }
  }

  Map<String, Object> extractRepositoryData(Map<String, Object> data) {
    final Map<String, Object> action = data['action'] as Map<String, Object>;

    if (action == null) {
      return null;
    }

    return action['starrable'] as Map<String, Object>;
  }
  }

