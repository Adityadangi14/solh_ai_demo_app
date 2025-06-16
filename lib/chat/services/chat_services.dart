import 'package:graphql_flutter/graphql_flutter.dart';

class ChatServices {
  Future<String?> sendInitialMessage(
    GraphQLClient client, {

    required String userId,
  }) async {
    String mutation = '''
      mutation {
      sendInitialMessage(input: { userID: "$userId" }) {
    response
    }
  }
    ''';

    RegExp regExp = RegExp(r'[\b]');

    mutation = mutation.replaceAll(regExp, "");

    print(mutation);

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      queryRequestTimeout: Duration(minutes: 5),
    );

    final QueryResult result = await client.mutate(options);
    print(result.data);
    if (result.hasException) {
      print('GraphQL Error: ${result.exception}');
      return null;
    }

    return result.data?['sendInitialMessage']?['response'];
  }

  Future<String?> getResponse(
    GraphQLClient client, {
    required String query,
    required String userId,
  }) async {
    final String safeUserId = (userId);

    String mutation = '''
     mutation {
  getResposne(input: { query: "$query", userId: "$userId"}) {
    response
  }
}
''';

    RegExp regExp = RegExp(r'[\b]');

    mutation = mutation.replaceAll(regExp, "");

    print(mutation);

    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      queryRequestTimeout: Duration(minutes: 5),
    );

    final QueryResult result = await client.mutate(options);
    print(result.data);
    if (result.hasException) {
      print('GraphQL Error: ${result.exception}');
      return null;
    }

    return result.data?['getResposne']?['response'];
  }

  Future<List<Map<String, dynamic>>> getChatByUserId(
    GraphQLClient client, {
    required String userId,
  }) async {
    String query = '''
     query GetAllChat {
  chatsByUserId(userID:"$userId") {
    query
    answer  
    timestamp
    userID
  }
}
   ''';

    final options = QueryOptions(
      document: gql(query),
      variables: {'userID': userId},
      fetchPolicy: FetchPolicy.networkOnly, // Always fetch fresh data
    );

    final result = await client.query(options);

    if (result.hasException) {
      print("GraphQL Error: ${result.exception.toString()}");
      throw Exception("Failed to fetch chats");
    }

    final List<dynamic> rawData = result.data?['chatsByUserId'] ?? [];
    return rawData.cast<Map<String, dynamic>>();
  }
}
