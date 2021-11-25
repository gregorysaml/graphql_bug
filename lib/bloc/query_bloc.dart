import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_bug/bloc/models.dart';
import 'package:graphql_bug/bloc/repository.dart';
import 'package:meta/meta.dart';

part 'query_event.dart';
part 'query_state.dart';

class QueryBloc extends Bloc<QueryEvent, QueryState> {
  final QueriesMul queriesMul; 

  List<Repo> userQuery;

  QueryBloc({@required this.queriesMul}) : super(QueryInitial()) {

    @override
    Stream<QueryState> mapEventToState(QueryEvent event,)async*{
      try{
        if(event is LoadMyRepos ){
          yield* 
        }
      }
      catch(_,stackTrace){
// ignore: avoid_print
print('erro $_ and $stackTrace');
      }
    }

  }
}
