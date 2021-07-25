import 'package:graphql/client.dart';

final client = GraphQLClient(
  link: HttpLink('https://workout-gql.herokuapp.com/graphql'),
  cache: GraphQLCache(store: HiveStore()),
);
