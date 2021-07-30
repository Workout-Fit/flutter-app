import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';

final client = GraphQLClient(
  link: HttpLink(dotenv.env['GRAPHQL_SERVER_HOST']!),
  cache: GraphQLCache(store: HiveStore()),
);
