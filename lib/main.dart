import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:solh_ai_app/helper/shared_prefrences/shared_prefrences_singleton.dart';
import 'package:solh_ai_app/modules/homescreen.dart';
import 'package:solh_ai_app/services/graphql_client.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GraphqlClient.I.init();

  await Prefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphqlClient.I.client,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: const Homescreen(),
      ),
    );
  }
}
