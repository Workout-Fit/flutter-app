import 'package:graphql/client.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:workout/api/schema.dart';

class WorkoutBloc extends QueryBloc<GetWorkoutById$Query> {
  WorkoutBloc({
    required GraphQLClient client,
    WatchQueryOptions? options,
  }) : super(
          client: client,
          options: options ??
              WatchQueryOptions(
                document: GET_WORKOUT_BY_ID_QUERY_DOCUMENT,
              ),
        );

  @override
  GetWorkoutById$Query parseData(Map<String, dynamic>? data) {
    return GetWorkoutById$Query.fromJson(data ?? {});
  }
}
