import 'package:graphql/client.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:workout/api/schema.dart';

class CreateWorkoutBloc extends MutationBloc<CreateWorkout$Mutation> {
  CreateWorkoutBloc({
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
  CreateWorkout$Mutation parseData(Map<String, dynamic>? data) {
    return CreateWorkout$Mutation.fromJson(data ?? {});
  }
}
