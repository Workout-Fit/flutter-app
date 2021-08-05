import 'package:graphql/client.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:workout/api/schema.dart';

class GetProfileInfoBloc extends QueryBloc<GetUserById$Query> {
  GetProfileInfoBloc({
    required GraphQLClient client,
    WatchQueryOptions? options,
  }) : super(
          client: client,
          options: options ??
              WatchQueryOptions(
                document: GET_USER_BY_ID_QUERY_DOCUMENT,
                fetchPolicy: FetchPolicy.cacheAndNetwork,
              ),
        );

  @override
  GetUserById$Query parseData(Map<String, dynamic>? data) {
    return GetUserById$Query.fromJson(data ?? {});
  }
}
