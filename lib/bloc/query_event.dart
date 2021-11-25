part of 'query_bloc.dart';

@immutable
abstract class QueryEvent extends Equatable{
 const QueryEvent([List props=const[]]):super();
}
 class LoadMyRepos extends QueryEvent {
  // the number of repositories to load, default is 50
  

  @override
  String toString() => 'LoadMyRepos';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

