

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_bug/bloc/query_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


import 'bloc/query_bloc.dart';


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

  GraphQLClient _client() {
    final HttpLink _httpLink = HttpLink(
        'https://imn2jwj4rja7dj3oloyzyopove.appsync-api.eu-central-1.amazonaws.com/graphql',
        defaultHeaders: {'x-api-key': 'da2-zsptnd2muned3mv5db45h6mhki'});
    return GraphQLClient(
        link: _httpLink, cache: GraphQLCache(store: HiveStore()));
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showUserData();
    });

    //  getQuery();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showUserData() async {
    final storage = FlutterSecureStorage();
    String user = await storage.read(key: 'UserData');
    print('user: $user');
  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<QueryBloc, UserState>(
      builder: (context, state) {
        
        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [CircularProgressIndicator()],
          ),
        ));
      },
    );
  }
}


                  // 'PK': 'MOB#' +
                  //     'c48a365d-92bf-43cf-8237-13d7fe10c7df', //cognitoID,
                  // 'CRAT': isoDate,
                  // 'MBL': '+3069811302502'