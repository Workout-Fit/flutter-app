import 'package:graphql/client.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:workout/api/schema.dart';

class CopyWorkoutBloc extends MutationBloc<CopyWorkout$Mutation> {
  CopyWorkoutBloc({
    required GraphQLClient client,
    WatchQueryOptions? options,
  }) : super(
          client: client,
          options: options ??
              WatchQueryOptions(
                document: COPY_WORKOUT_MUTATION_DOCUMENT,
              ),
        );

  @override
  CopyWorkout$Mutation parseData(Map<String, dynamic>? data) {
    return CopyWorkout$Mutation.fromJson(data ?? {});
  }
}
