part of 'query_bloc.dart';

@immutable
abstract class QueryState {}

class QueryInitial extends QueryState {
    @override
  String toString() => 'Initial';
}

class UserLoading extends QueryState {
  @override
  String toString() => 'ReposLoading';
}

class UserNotLoaded extends QueryState {
  final List<GraphQLError> errors;

  UserNotLoaded([this.errors]) : super();

  @override
  String toString() => 'ReposNotLoaded';
}
class UserLoaded extends QueryState {
  final List<Repo> results;

  UserLoaded({@required this.results})
      : assert(results != null),
        super();

  @override
  String toString() => 'UserResults: {$results }';
}