import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;

class GraphqlClient {
  GraphqlClient._();
  static final I = GraphqlClient._();

  late ValueNotifier<GraphQLClient> client;

  Future<void> init() async {
    await initHiveForFlutter();

    final httpClient = _TimeoutHttpClient(
      http.Client(),
      const Duration(minutes: 3),
    );

    final HttpLink httpLink = HttpLink(
      'http://192.168.1.23:3000/query',
      httpClient: httpClient,
    );

    client = ValueNotifier(
      GraphQLClient(link: httpLink, cache: GraphQLCache(store: HiveStore())),
    );
  }
}

class _TimeoutHttpClient extends http.BaseClient {
  final http.Client _inner;
  final Duration _timeout;

  _TimeoutHttpClient(this._inner, this._timeout);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request).timeout(_timeout);
  }
}
