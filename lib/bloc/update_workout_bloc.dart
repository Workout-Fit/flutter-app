import 'package:graphql/client.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:workout/api/schema.dart';

class UpdateWorkoutBloc extends MutationBloc<UpdateWorkout$Mutation> {
  UpdateWorkoutBloc({
    required GraphQLClient client,
    WatchQueryOptions? options,
  }) : super(
          client: client,
          options: options ??
              WatchQueryOptions(
                document: UPDATE_WORKOUT_MUTATION_DOCUMENT,
              ),
        );

  @override
  UpdateWorkout$Mutation parseData(Map<String, dynamic>? data) {
    return UpdateWorkout$Mutation.fromJson(data ?? {});
  }
}
