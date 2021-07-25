// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
part 'schema.graphql.g.dart';

mixin WorkoutDetailsMixin {
  @JsonKey(name: '__typename')
  String? $$typename;
  late String id;
  late String userId;
  WorkoutDetailsMixin$BasedOn? basedOn;
  late String name;
  String? description;
  List<String?>? muscleGroups;
  List<WorkoutDetailsMixin$Exercises?>? exercises;
}

@JsonSerializable(explicitToJson: true)
class GetWorkoutsByUserId$Query$GetWorkoutsByUserId$Exercises
    extends JsonSerializable with EquatableMixin {
  GetWorkoutsByUserId$Query$GetWorkoutsByUserId$Exercises();

  factory GetWorkoutsByUserId$Query$GetWorkoutsByUserId$Exercises.fromJson(
          Map<String, dynamic> json) =>
      _$GetWorkoutsByUserId$Query$GetWorkoutsByUserId$ExercisesFromJson(json);

  late String exerciseId;

  @override
  List<Object?> get props => [exerciseId];
  @override
  Map<String, dynamic> toJson() =>
      _$GetWorkoutsByUserId$Query$GetWorkoutsByUserId$ExercisesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetWorkoutsByUserId$Query$GetWorkoutsByUserId extends JsonSerializable
    with EquatableMixin {
  GetWorkoutsByUserId$Query$GetWorkoutsByUserId();

  factory GetWorkoutsByUserId$Query$GetWorkoutsByUserId.fromJson(
          Map<String, dynamic> json) =>
      _$GetWorkoutsByUserId$Query$GetWorkoutsByUserIdFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late String id;

  late String name;

  List<String?>? muscleGroups;

  List<GetWorkoutsByUserId$Query$GetWorkoutsByUserId$Exercises?>? exercises;

  @override
  List<Object?> get props => [$$typename, id, name, muscleGroups, exercises];
  @override
  Map<String, dynamic> toJson() =>
      _$GetWorkoutsByUserId$Query$GetWorkoutsByUserIdToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetWorkoutsByUserId$Query extends JsonSerializable with EquatableMixin {
  GetWorkoutsByUserId$Query();

  factory GetWorkoutsByUserId$Query.fromJson(Map<String, dynamic> json) =>
      _$GetWorkoutsByUserId$QueryFromJson(json);

  List<GetWorkoutsByUserId$Query$GetWorkoutsByUserId?>? getWorkoutsByUserId;

  @override
  List<Object?> get props => [getWorkoutsByUserId];
  @override
  Map<String, dynamic> toJson() => _$GetWorkoutsByUserId$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkout$Mutation$CreateWorkout$Exercises extends JsonSerializable
    with EquatableMixin {
  CreateWorkout$Mutation$CreateWorkout$Exercises();

  factory CreateWorkout$Mutation$CreateWorkout$Exercises.fromJson(
          Map<String, dynamic> json) =>
      _$CreateWorkout$Mutation$CreateWorkout$ExercisesFromJson(json);

  late String exerciseId;

  @override
  List<Object?> get props => [exerciseId];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateWorkout$Mutation$CreateWorkout$ExercisesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkout$Mutation$CreateWorkout extends JsonSerializable
    with EquatableMixin {
  CreateWorkout$Mutation$CreateWorkout();

  factory CreateWorkout$Mutation$CreateWorkout.fromJson(
          Map<String, dynamic> json) =>
      _$CreateWorkout$Mutation$CreateWorkoutFromJson(json);

  late String id;

  late String name;

  List<String?>? muscleGroups;

  List<CreateWorkout$Mutation$CreateWorkout$Exercises?>? exercises;

  @override
  List<Object?> get props => [id, name, muscleGroups, exercises];
  @override
  Map<String, dynamic> toJson() =>
      _$CreateWorkout$Mutation$CreateWorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkout$Mutation extends JsonSerializable with EquatableMixin {
  CreateWorkout$Mutation();

  factory CreateWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkout$MutationFromJson(json);

  CreateWorkout$Mutation$CreateWorkout? createWorkout;

  @override
  List<Object?> get props => [createWorkout];
  @override
  Map<String, dynamic> toJson() => _$CreateWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutInput extends JsonSerializable with EquatableMixin {
  WorkoutInput(
      {this.basedOnId,
      this.description,
      this.exercises,
      this.id,
      required this.name,
      required this.userId});

  factory WorkoutInput.fromJson(Map<String, dynamic> json) =>
      _$WorkoutInputFromJson(json);

  String? basedOnId;

  String? description;

  List<ExercisesInput?>? exercises;

  String? id;

  late String name;

  late String userId;

  @override
  List<Object?> get props =>
      [basedOnId, description, exercises, id, name, userId];
  @override
  Map<String, dynamic> toJson() => _$WorkoutInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ExercisesInput extends JsonSerializable with EquatableMixin {
  ExercisesInput(
      {required this.exerciseId,
      this.notes,
      required this.repetitions,
      required this.rest,
      required this.sets});

  factory ExercisesInput.fromJson(Map<String, dynamic> json) =>
      _$ExercisesInputFromJson(json);

  late String exerciseId;

  String? notes;

  late int repetitions;

  late int rest;

  late int sets;

  @override
  List<Object?> get props => [exerciseId, notes, repetitions, rest, sets];
  @override
  Map<String, dynamic> toJson() => _$ExercisesInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteWorkout$Mutation$DeleteWorkout extends JsonSerializable
    with EquatableMixin {
  DeleteWorkout$Mutation$DeleteWorkout();

  factory DeleteWorkout$Mutation$DeleteWorkout.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteWorkout$Mutation$DeleteWorkoutFromJson(json);

  late String id;

  late String name;

  @override
  List<Object?> get props => [id, name];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteWorkout$Mutation$DeleteWorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteWorkout$Mutation extends JsonSerializable with EquatableMixin {
  DeleteWorkout$Mutation();

  factory DeleteWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$DeleteWorkout$MutationFromJson(json);

  DeleteWorkout$Mutation$DeleteWorkout? deleteWorkout;

  @override
  List<Object?> get props => [deleteWorkout];
  @override
  Map<String, dynamic> toJson() => _$DeleteWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutDetailsMixin$BasedOn$User extends JsonSerializable
    with EquatableMixin {
  WorkoutDetailsMixin$BasedOn$User();

  factory WorkoutDetailsMixin$BasedOn$User.fromJson(
          Map<String, dynamic> json) =>
      _$WorkoutDetailsMixin$BasedOn$UserFromJson(json);

  String? username;

  @override
  List<Object?> get props => [username];
  @override
  Map<String, dynamic> toJson() =>
      _$WorkoutDetailsMixin$BasedOn$UserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutDetailsMixin$BasedOn extends JsonSerializable with EquatableMixin {
  WorkoutDetailsMixin$BasedOn();

  factory WorkoutDetailsMixin$BasedOn.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDetailsMixin$BasedOnFromJson(json);

  late String id;

  WorkoutDetailsMixin$BasedOn$User? user;

  @override
  List<Object?> get props => [id, user];
  @override
  Map<String, dynamic> toJson() => _$WorkoutDetailsMixin$BasedOnToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutDetailsMixin$Exercises$Exercise$MuscleGroup
    extends JsonSerializable with EquatableMixin {
  WorkoutDetailsMixin$Exercises$Exercise$MuscleGroup();

  factory WorkoutDetailsMixin$Exercises$Exercise$MuscleGroup.fromJson(
          Map<String, dynamic> json) =>
      _$WorkoutDetailsMixin$Exercises$Exercise$MuscleGroupFromJson(json);

  late String name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() =>
      _$WorkoutDetailsMixin$Exercises$Exercise$MuscleGroupToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutDetailsMixin$Exercises$Exercise extends JsonSerializable
    with EquatableMixin {
  WorkoutDetailsMixin$Exercises$Exercise();

  factory WorkoutDetailsMixin$Exercises$Exercise.fromJson(
          Map<String, dynamic> json) =>
      _$WorkoutDetailsMixin$Exercises$ExerciseFromJson(json);

  String? name;

  WorkoutDetailsMixin$Exercises$Exercise$MuscleGroup? muscleGroup;

  @override
  List<Object?> get props => [name, muscleGroup];
  @override
  Map<String, dynamic> toJson() =>
      _$WorkoutDetailsMixin$Exercises$ExerciseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WorkoutDetailsMixin$Exercises extends JsonSerializable
    with EquatableMixin {
  WorkoutDetailsMixin$Exercises();

  factory WorkoutDetailsMixin$Exercises.fromJson(Map<String, dynamic> json) =>
      _$WorkoutDetailsMixin$ExercisesFromJson(json);

  late String exerciseId;

  late int sets;

  late int repetitions;

  late int rest;

  String? notes;

  WorkoutDetailsMixin$Exercises$Exercise? exercise;

  @override
  List<Object?> get props =>
      [exerciseId, sets, repetitions, rest, notes, exercise];
  @override
  Map<String, dynamic> toJson() => _$WorkoutDetailsMixin$ExercisesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetWorkoutById$Query$GetWorkoutById extends JsonSerializable
    with EquatableMixin, WorkoutDetailsMixin {
  GetWorkoutById$Query$GetWorkoutById();

  factory GetWorkoutById$Query$GetWorkoutById.fromJson(
          Map<String, dynamic> json) =>
      _$GetWorkoutById$Query$GetWorkoutByIdFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        userId,
        basedOn,
        name,
        description,
        muscleGroups,
        exercises
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$GetWorkoutById$Query$GetWorkoutByIdToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetWorkoutById$Query extends JsonSerializable with EquatableMixin {
  GetWorkoutById$Query();

  factory GetWorkoutById$Query.fromJson(Map<String, dynamic> json) =>
      _$GetWorkoutById$QueryFromJson(json);

  GetWorkoutById$Query$GetWorkoutById? getWorkoutById;

  @override
  List<Object?> get props => [getWorkoutById];
  @override
  Map<String, dynamic> toJson() => _$GetWorkoutById$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkout$Mutation$UpdateWorkout extends JsonSerializable
    with EquatableMixin, WorkoutDetailsMixin {
  UpdateWorkout$Mutation$UpdateWorkout();

  factory UpdateWorkout$Mutation$UpdateWorkout.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateWorkout$Mutation$UpdateWorkoutFromJson(json);

  @override
  List<Object?> get props => [
        $$typename,
        id,
        userId,
        basedOn,
        name,
        description,
        muscleGroups,
        exercises
      ];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateWorkout$Mutation$UpdateWorkoutToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkout$Mutation extends JsonSerializable with EquatableMixin {
  UpdateWorkout$Mutation();

  factory UpdateWorkout$Mutation.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkout$MutationFromJson(json);

  UpdateWorkout$Mutation$UpdateWorkout? updateWorkout;

  @override
  List<Object?> get props => [updateWorkout];
  @override
  Map<String, dynamic> toJson() => _$UpdateWorkout$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchExercises$Query$GetExercises$MuscleGroup extends JsonSerializable
    with EquatableMixin {
  SearchExercises$Query$GetExercises$MuscleGroup();

  factory SearchExercises$Query$GetExercises$MuscleGroup.fromJson(
          Map<String, dynamic> json) =>
      _$SearchExercises$Query$GetExercises$MuscleGroupFromJson(json);

  late String name;

  @override
  List<Object?> get props => [name];
  @override
  Map<String, dynamic> toJson() =>
      _$SearchExercises$Query$GetExercises$MuscleGroupToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchExercises$Query$GetExercises extends JsonSerializable
    with EquatableMixin {
  SearchExercises$Query$GetExercises();

  factory SearchExercises$Query$GetExercises.fromJson(
          Map<String, dynamic> json) =>
      _$SearchExercises$Query$GetExercisesFromJson(json);

  @JsonKey(name: '__typename')
  String? $$typename;

  late String id;

  String? name;

  SearchExercises$Query$GetExercises$MuscleGroup? muscleGroup;

  @override
  List<Object?> get props => [$$typename, id, name, muscleGroup];
  @override
  Map<String, dynamic> toJson() =>
      _$SearchExercises$Query$GetExercisesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SearchExercises$Query extends JsonSerializable with EquatableMixin {
  SearchExercises$Query();

  factory SearchExercises$Query.fromJson(Map<String, dynamic> json) =>
      _$SearchExercises$QueryFromJson(json);

  List<SearchExercises$Query$GetExercises?>? getExercises;

  @override
  List<Object?> get props => [getExercises];
  @override
  Map<String, dynamic> toJson() => _$SearchExercises$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUser$Mutation$CreateUser extends JsonSerializable
    with EquatableMixin {
  CreateUser$Mutation$CreateUser();

  factory CreateUser$Mutation$CreateUser.fromJson(Map<String, dynamic> json) =>
      _$CreateUser$Mutation$CreateUserFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$CreateUser$Mutation$CreateUserToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateUser$Mutation extends JsonSerializable with EquatableMixin {
  CreateUser$Mutation();

  factory CreateUser$Mutation.fromJson(Map<String, dynamic> json) =>
      _$CreateUser$MutationFromJson(json);

  CreateUser$Mutation$CreateUser? createUser;

  @override
  List<Object?> get props => [createUser];
  @override
  Map<String, dynamic> toJson() => _$CreateUser$MutationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProfileInfoInput extends JsonSerializable with EquatableMixin {
  ProfileInfoInput(
      {this.bio,
      this.height,
      required this.name,
      this.profilePicture,
      required this.username,
      this.weight});

  factory ProfileInfoInput.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfoInputFromJson(json);

  String? bio;

  double? height;

  late String name;

  String? profilePicture;

  late String username;

  double? weight;

  @override
  List<Object?> get props =>
      [bio, height, name, profilePicture, username, weight];
  @override
  Map<String, dynamic> toJson() => _$ProfileInfoInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserById$Query$GetUserById$ProfileInfo extends JsonSerializable
    with EquatableMixin {
  GetUserById$Query$GetUserById$ProfileInfo();

  factory GetUserById$Query$GetUserById$ProfileInfo.fromJson(
          Map<String, dynamic> json) =>
      _$GetUserById$Query$GetUserById$ProfileInfoFromJson(json);

  String? username;

  String? name;

  double? height;

  double? weight;

  String? profilePicture;

  String? bio;

  @override
  List<Object?> get props =>
      [username, name, height, weight, profilePicture, bio];
  @override
  Map<String, dynamic> toJson() =>
      _$GetUserById$Query$GetUserById$ProfileInfoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserById$Query$GetUserById extends JsonSerializable
    with EquatableMixin {
  GetUserById$Query$GetUserById();

  factory GetUserById$Query$GetUserById.fromJson(Map<String, dynamic> json) =>
      _$GetUserById$Query$GetUserByIdFromJson(json);

  late String id;

  GetUserById$Query$GetUserById$ProfileInfo? profileInfo;

  @override
  List<Object?> get props => [id, profileInfo];
  @override
  Map<String, dynamic> toJson() => _$GetUserById$Query$GetUserByIdToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetUserById$Query extends JsonSerializable with EquatableMixin {
  GetUserById$Query();

  factory GetUserById$Query.fromJson(Map<String, dynamic> json) =>
      _$GetUserById$QueryFromJson(json);

  GetUserById$Query$GetUserById? getUserById;

  @override
  List<Object?> get props => [getUserById];
  @override
  Map<String, dynamic> toJson() => _$GetUserById$QueryToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetWorkoutsByUserIdArguments extends JsonSerializable
    with EquatableMixin {
  GetWorkoutsByUserIdArguments({required this.userId});

  @override
  factory GetWorkoutsByUserIdArguments.fromJson(Map<String, dynamic> json) =>
      _$GetWorkoutsByUserIdArgumentsFromJson(json);

  late String userId;

  @override
  List<Object?> get props => [userId];
  @override
  Map<String, dynamic> toJson() => _$GetWorkoutsByUserIdArgumentsToJson(this);
}

final GET_WORKOUTS_BY_USER_ID_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetWorkoutsByUserId'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getWorkoutsByUserId'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'userId'),
                  value: VariableNode(name: NameNode(value: 'userId')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'muscleGroups'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'exercises'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'exerciseId'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class GetWorkoutsByUserIdQuery extends GraphQLQuery<GetWorkoutsByUserId$Query,
    GetWorkoutsByUserIdArguments> {
  GetWorkoutsByUserIdQuery({required this.variables});

  @override
  final DocumentNode document = GET_WORKOUTS_BY_USER_ID_QUERY_DOCUMENT;

  @override
  final String operationName = 'GetWorkoutsByUserId';

  @override
  final GetWorkoutsByUserIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetWorkoutsByUserId$Query parse(Map<String, dynamic> json) =>
      GetWorkoutsByUserId$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateWorkoutArguments extends JsonSerializable with EquatableMixin {
  CreateWorkoutArguments({required this.workout});

  @override
  factory CreateWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateWorkoutArgumentsFromJson(json);

  late WorkoutInput workout;

  @override
  List<Object?> get props => [workout];
  @override
  Map<String, dynamic> toJson() => _$CreateWorkoutArgumentsToJson(this);
}

final CREATE_WORKOUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CreateWorkout'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'workout')),
            type: NamedTypeNode(
                name: NameNode(value: 'WorkoutInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createWorkout'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'workout'),
                  value: VariableNode(name: NameNode(value: 'workout')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'muscleGroups'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'exercises'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'exerciseId'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class CreateWorkoutMutation
    extends GraphQLQuery<CreateWorkout$Mutation, CreateWorkoutArguments> {
  CreateWorkoutMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_WORKOUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'CreateWorkout';

  @override
  final CreateWorkoutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateWorkout$Mutation parse(Map<String, dynamic> json) =>
      CreateWorkout$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteWorkoutArguments extends JsonSerializable with EquatableMixin {
  DeleteWorkoutArguments({required this.id});

  @override
  factory DeleteWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteWorkoutArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$DeleteWorkoutArgumentsToJson(this);
}

final DELETE_WORKOUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteWorkout'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'id')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'deleteWorkout'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class DeleteWorkoutMutation
    extends GraphQLQuery<DeleteWorkout$Mutation, DeleteWorkoutArguments> {
  DeleteWorkoutMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_WORKOUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'DeleteWorkout';

  @override
  final DeleteWorkoutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteWorkout$Mutation parse(Map<String, dynamic> json) =>
      DeleteWorkout$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GetWorkoutByIdArguments extends JsonSerializable with EquatableMixin {
  GetWorkoutByIdArguments({required this.id});

  @override
  factory GetWorkoutByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$GetWorkoutByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$GetWorkoutByIdArgumentsToJson(this);
}

final GET_WORKOUT_BY_ID_QUERY_DOCUMENT = DocumentNode(definitions: [
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutDetails'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Workout'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'userId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'basedOn'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'muscleGroups'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'exercises'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'exerciseId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'sets'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'repetitions'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'rest'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'notes'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'exercise'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'muscleGroup'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ]))
            ]))
      ])),
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetWorkoutById'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'id')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getWorkoutById'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutDetails'), directives: [])
            ]))
      ]))
]);

class GetWorkoutByIdQuery
    extends GraphQLQuery<GetWorkoutById$Query, GetWorkoutByIdArguments> {
  GetWorkoutByIdQuery({required this.variables});

  @override
  final DocumentNode document = GET_WORKOUT_BY_ID_QUERY_DOCUMENT;

  @override
  final String operationName = 'GetWorkoutById';

  @override
  final GetWorkoutByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetWorkoutById$Query parse(Map<String, dynamic> json) =>
      GetWorkoutById$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateWorkoutArguments extends JsonSerializable with EquatableMixin {
  UpdateWorkoutArguments({required this.workout});

  @override
  factory UpdateWorkoutArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateWorkoutArgumentsFromJson(json);

  late WorkoutInput workout;

  @override
  List<Object?> get props => [workout];
  @override
  Map<String, dynamic> toJson() => _$UpdateWorkoutArgumentsToJson(this);
}

final UPDATE_WORKOUT_MUTATION_DOCUMENT = DocumentNode(definitions: [
  FragmentDefinitionNode(
      name: NameNode(value: 'WorkoutDetails'),
      typeCondition: TypeConditionNode(
          on: NamedTypeNode(
              name: NameNode(value: 'Workout'), isNonNull: false)),
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'userId'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'basedOn'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'user'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ])),
        FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'description'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'muscleGroups'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null),
        FieldNode(
            name: NameNode(value: 'exercises'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'exerciseId'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'sets'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'repetitions'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'rest'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'notes'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'exercise'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'muscleGroup'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: SelectionSetNode(selections: [
                          FieldNode(
                              name: NameNode(value: 'name'),
                              alias: null,
                              arguments: [],
                              directives: [],
                              selectionSet: null)
                        ]))
                  ]))
            ]))
      ])),
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateWorkout'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'workout')),
            type: NamedTypeNode(
                name: NameNode(value: 'WorkoutInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'updateWorkout'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'workout'),
                  value: VariableNode(name: NameNode(value: 'workout')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FragmentSpreadNode(
                  name: NameNode(value: 'WorkoutDetails'), directives: [])
            ]))
      ]))
]);

class UpdateWorkoutMutation
    extends GraphQLQuery<UpdateWorkout$Mutation, UpdateWorkoutArguments> {
  UpdateWorkoutMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_WORKOUT_MUTATION_DOCUMENT;

  @override
  final String operationName = 'UpdateWorkout';

  @override
  final UpdateWorkoutArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateWorkout$Mutation parse(Map<String, dynamic> json) =>
      UpdateWorkout$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class SearchExercisesArguments extends JsonSerializable with EquatableMixin {
  SearchExercisesArguments({this.exerciseName});

  @override
  factory SearchExercisesArguments.fromJson(Map<String, dynamic> json) =>
      _$SearchExercisesArgumentsFromJson(json);

  final String? exerciseName;

  @override
  List<Object?> get props => [exerciseName];
  @override
  Map<String, dynamic> toJson() => _$SearchExercisesArgumentsToJson(this);
}

final SEARCH_EXERCISES_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'SearchExercises'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'exerciseName')),
            type: NamedTypeNode(
                name: NameNode(value: 'String'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getExercises'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'name'),
                  value: VariableNode(name: NameNode(value: 'exerciseName')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: '__typename'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'muscleGroup'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class SearchExercisesQuery
    extends GraphQLQuery<SearchExercises$Query, SearchExercisesArguments> {
  SearchExercisesQuery({required this.variables});

  @override
  final DocumentNode document = SEARCH_EXERCISES_QUERY_DOCUMENT;

  @override
  final String operationName = 'SearchExercises';

  @override
  final SearchExercisesArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  SearchExercises$Query parse(Map<String, dynamic> json) =>
      SearchExercises$Query.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateUserArguments extends JsonSerializable with EquatableMixin {
  CreateUserArguments({required this.userId, required this.profileInfo});

  @override
  factory CreateUserArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateUserArgumentsFromJson(json);

  late String userId;

  late ProfileInfoInput profileInfo;

  @override
  List<Object?> get props => [userId, profileInfo];
  @override
  Map<String, dynamic> toJson() => _$CreateUserArgumentsToJson(this);
}

final CREATE_USER_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'createUser'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'userId')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'profileInfo')),
            type: NamedTypeNode(
                name: NameNode(value: 'ProfileInfoInput'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'createUser'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'userId'),
                  value: VariableNode(name: NameNode(value: 'userId'))),
              ArgumentNode(
                  name: NameNode(value: 'profileInfo'),
                  value: VariableNode(name: NameNode(value: 'profileInfo')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class CreateUserMutation
    extends GraphQLQuery<CreateUser$Mutation, CreateUserArguments> {
  CreateUserMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_USER_MUTATION_DOCUMENT;

  @override
  final String operationName = 'createUser';

  @override
  final CreateUserArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateUser$Mutation parse(Map<String, dynamic> json) =>
      CreateUser$Mutation.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GetUserByIdArguments extends JsonSerializable with EquatableMixin {
  GetUserByIdArguments({required this.id});

  @override
  factory GetUserByIdArguments.fromJson(Map<String, dynamic> json) =>
      _$GetUserByIdArgumentsFromJson(json);

  late String id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$GetUserByIdArgumentsToJson(this);
}

final GET_USER_BY_ID_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'getUserById'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'id')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'getUserById'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'profileInfo'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'username'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'name'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'height'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'weight'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'profilePicture'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null),
                    FieldNode(
                        name: NameNode(value: 'bio'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class GetUserByIdQuery
    extends GraphQLQuery<GetUserById$Query, GetUserByIdArguments> {
  GetUserByIdQuery({required this.variables});

  @override
  final DocumentNode document = GET_USER_BY_ID_QUERY_DOCUMENT;

  @override
  final String operationName = 'getUserById';

  @override
  final GetUserByIdArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetUserById$Query parse(Map<String, dynamic> json) =>
      GetUserById$Query.fromJson(json);
}
