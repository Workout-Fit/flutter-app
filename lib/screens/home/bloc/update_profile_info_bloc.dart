import 'package:graphql/client.dart';
import 'package:graphql_flutter_bloc/graphql_flutter_bloc.dart';
import 'package:workout/api/schema.graphql.dart';

class UpdateProfileInfoBloc extends MutationBloc<UpdateProfileInfo$Mutation> {
  UpdateProfileInfoBloc({
    required GraphQLClient client,
    WatchQueryOptions? options,
  }) : super(
          client: client,
          options: options ??
              WatchQueryOptions(
                document: UPDATE_PROFILE_INFO_MUTATION_DOCUMENT,
              ),
        );

  @override
  UpdateProfileInfo$Mutation parseData(Map<String, dynamic>? data) {
    return UpdateProfileInfo$Mutation.fromJson(data ?? {});
  }
}
