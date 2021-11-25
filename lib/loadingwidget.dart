// ignore_for_file: avoid_print, file_names
import 'package:flutter/material.dart';
import 'package:graphql_bug/const/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoadingPage extends StatefulWidget {
  final String userId;
  final String userPhone;

  const LoadingPage({Key key, this.userId, this.userPhone}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Map userdata;
  Map mutation;
  bool isqueryed = false;
  bool existinUser = false;

  Future<Map> getQuery({userId}) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var userdata = await client.query(QueryOptions(
      fetchPolicy: FetchPolicy.networkOnly,
      document: gql(getUserData),
    ));
    // ignore: unrelated_type_equality_checks
    if (userdata.exception == true) {
      print(userdata.exception);
      // throw (userdata.exception);
    }
    if (userdata.isLoading) {
      print('userdata.isLoading: $userdata.isLoading');
    }
    print('userdata1: $userdata');

    isqueryed = true;

    return userdata.data;
  }




  Future nav(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();

    Future.delayed(Duration.zero).then((value) => {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => const Name()))
          //with push named works
          Navigator.of(context).pushNamed(
            '/trea',
          )
        });
  }

  @override
  void initState() {
    //  getQuery();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    // ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:const [
          // Mutation(
          //     options: MutationOptions(
          //         cacheRereadPolicy: CacheRereadPolicy.ignoreAll,
          //         onCompleted: (data) {},
          //         onError: (data) {},
          //         document: gql(makeUserMutation)),
          //     builder: (RunMutation runMutation, QueryResult result) {
          //       getQuery();
          //       DateTime now = DateTime.now();
          //       String isoDate = now.toIso8601String();
          //       print('isoDate: $isoDate');
          //       runMutation({

          //       });
          //       userdata = result.data;

          //       WidgetsBinding.instance.addPostFrameCallback((_) {
          //         nav(context);
          //       });

          //       return const SizedBox.shrink();
          //     }),
          CircularProgressIndicator()
        ],
      ),
    ));
  }
}


                  // 'PK': 'MOB#' +
                  //     'c48a365d-92bf-43cf-8237-13d7fe10c7df', //cognitoID,
                  // 'CRAT': isoDate,
                  // 'MBL': '+3069811302502'