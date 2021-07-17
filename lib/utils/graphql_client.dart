import 'package:graphql/client.dart';

final client = GraphQLClient(
  link: HttpLink('http://192.168.18.6:4000'),
  cache: GraphQLCache(store: HiveStore()),
);
