part of 'query_bloc.dart';


@immutable
abstract class QueryEvent extends Equatable{
 const QueryEvent([List props=const[]]):super();
}
 class Loadmyuser extends QueryEvent {


  @override
  String toString() => 'Loadss';

  @override

  List<Object> get props => [];


}

class MakeMyUser extends QueryEvent{
  @override
  String toString()=>'Making';

  @override
  List<Object> get props => [];

}

