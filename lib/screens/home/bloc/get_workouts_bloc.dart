import 'package:graphql/client.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:workout/api/schema.dart';

class WorkoutsBloc extends QueryBloc<GetWorkoutsByUserId$Query> {
  WorkoutsBloc({
    required GraphQLClient client,
    WatchQueryOptions? options,
  }) : super(
          client: client,
          options: options ??
              WatchQueryOptions(
                document: GET_WORKOUTS_BY_USER_ID_QUERY_DOCUMENT,
                fetchPolicy: FetchPolicy.cacheAndNetwork,
              ),
        );

  @override
  GetWorkoutsByUserId$Query parseData(Map<String, dynamic>? data) {
    return GetWorkoutsByUserId$Query.fromJson(data ?? {});
  }
}
