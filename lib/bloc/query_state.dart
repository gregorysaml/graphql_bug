part of 'query_bloc.dart';

@immutable
abstract class UserState {}

class QueryInitial extends UserState {
  QueryInitial(UserLoading userLoading);

    @override
  String toString() => 'Initial';
}

class UserLoading extends UserState {
  @override
  String toString() => 'ReposLoading';
}

class UserNotLoaded extends UserState {
  final List<GraphQLError> errors;
  UserNotLoaded([this.errors]) : super();

  @override
  String toString() => 'ReposNotLoaded';
}
class UserLoaded extends UserState {
  final List<Repo> results;

  UserLoaded({@required this.results})
      : assert(results != null),
        super();

  @override
  String toString() => 'UserResults: {$results }';
}