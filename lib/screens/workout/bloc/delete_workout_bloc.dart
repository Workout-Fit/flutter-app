import 'package:graphql/client.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:workout/api/schema.dart';

class DeleteWorkoutBloc extends MutationBloc<DeleteWorkout$Mutation> {
  DeleteWorkoutBloc({
    required GraphQLClient client,
    WatchQueryOptions? options,
  }) : super(
          client: client,
          options: options ??
              WatchQueryOptions(
                document: DELETE_WORKOUT_MUTATION_DOCUMENT,
              ),
        );

  @override
  DeleteWorkout$Mutation parseData(Map<String, dynamic>? data) {
    return DeleteWorkout$Mutation.fromJson(data ?? {});
  }
}
