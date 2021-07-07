import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlProvider extends StatelessWidget {
  final Widget child;
  final String subscriptionUri;
  final String hostUri;
  final ValueNotifier<GraphQLClient> client;

  GraphqlProvider({
    required this.child,
    required this.hostUri,
    this.subscriptionUri = "",
  }) : client = ValueNotifier<GraphQLClient>(
          GraphQLClient(
            link: HttpLink(hostUri),
            cache: GraphQLCache(store: HiveStore()),
          ),
        );

  @override
  Widget build(BuildContext context) => GraphQLProvider(
        client: client,
        child: child,
      );
}
