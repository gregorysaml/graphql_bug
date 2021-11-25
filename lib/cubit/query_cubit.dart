

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_bug/const/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

part 'query_state.dart';

class QueryCubit extends Cubit<QueryState> {
  QueryCubit() : super(QueryState(result: {}));

 

     GraphQLClient client;
   Future<Map> getPosts() async {
    final results=await client.query(QueryOptions(document: gql(getUserData),),);
    
    print('results: $results');
    if(results.hasException){
      throw results.exception;
    }else{
  results.data;
    }
  }

   getuser() async {
     emit(getuser());
     try
     {
        final results=await client.query(QueryOptions(document: gql(getUserData),),);
       emit(state.result);
     }
     catch(e){
print(e);
     }
   }

}
