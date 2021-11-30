import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_bug/bloc/models.dart';
import 'package:graphql_bug/bloc/query_bloc.dart';
import 'package:graphql_bug/bloc/repository.dart';
import 'package:graphql_bug/loadingwidget.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

GraphQLClient _client() {
  final HttpLink _httpLink = HttpLink(
      'https://imn2jwj4rja7dj3oloyzyopove.appsync-api.eu-central-1.amazonaws.com/graphql',
      defaultHeaders: {'x-api-key': 'da2-zsptnd2muned3mv5db45h6mhki'});
  return GraphQLClient(
      link: _httpLink, cache: GraphQLCache(store: HiveStore()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   '/': (_) =>  const MyHomePage(),
      //   '/second': (context) => const LoadingPage(),
      //   '/trea': (context) => const Name(),
      // },
      home: const MyHomePage(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const Name(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final test = Repo();
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<QueryBloc>(context).add(Loadmyuser());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QueryBloc(queriesMul: QueriesMul(client: _client())),
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<QueryBloc>(context).add(Loadmyuser());
                      print(test.pK);
                      BlocProvider.of<QueryBloc>(context).add(MakeMyUser());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<QueryBloc>(context),
                            child: const LoadingPage(), 
                          ),
                        ),
                      );
                    },
                    child: const Text('Create a user'));
              })
            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
