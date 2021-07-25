// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'schema.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWorkoutsByUserId$Query$GetWorkoutsByUserId$Exercises
    _$GetWorkoutsByUserId$Query$GetWorkoutsByUserId$ExercisesFromJson(
        Map<String, dynamic> json) {
  return GetWorkoutsByUserId$Query$GetWorkoutsByUserId$Exercises()
    ..exerciseId = json['exerciseId'] as String;
}

Map<String, dynamic>
    _$GetWorkoutsByUserId$Query$GetWorkoutsByUserId$ExercisesToJson(
            GetWorkoutsByUserId$Query$GetWorkoutsByUserId$Exercises instance) =>
        <String, dynamic>{
          'exerciseId': instance.exerciseId,
        };

GetWorkoutsByUserId$Query$GetWorkoutsByUserId
    _$GetWorkoutsByUserId$Query$GetWorkoutsByUserIdFromJson(
        Map<String, dynamic> json) {
  return GetWorkoutsByUserId$Query$GetWorkoutsByUserId()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..muscleGroups = (json['muscleGroups'] as List<dynamic>?)
        ?.map((e) => e as String?)
        .toList()
    ..exercises = (json['exercises'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : GetWorkoutsByUserId$Query$GetWorkoutsByUserId$Exercises.fromJson(
                e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$GetWorkoutsByUserId$Query$GetWorkoutsByUserIdToJson(
        GetWorkoutsByUserId$Query$GetWorkoutsByUserId instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'muscleGroups': instance.muscleGroups,
      'exercises': instance.exercises?.map((e) => e?.toJson()).toList(),
    };

GetWorkoutsByUserId$Query _$GetWorkoutsByUserId$QueryFromJson(
    Map<String, dynamic> json) {
  return GetWorkoutsByUserId$Query()
    ..getWorkoutsByUserId = (json['getWorkoutsByUserId'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : GetWorkoutsByUserId$Query$GetWorkoutsByUserId.fromJson(
                e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$GetWorkoutsByUserId$QueryToJson(
        GetWorkoutsByUserId$Query instance) =>
    <String, dynamic>{
      'getWorkoutsByUserId':
          instance.getWorkoutsByUserId?.map((e) => e?.toJson()).toList(),
    };

CreateWorkout$Mutation$CreateWorkout$Exercises
    _$CreateWorkout$Mutation$CreateWorkout$ExercisesFromJson(
        Map<String, dynamic> json) {
  return CreateWorkout$Mutation$CreateWorkout$Exercises()
    ..exerciseId = json['exerciseId'] as String;
}

Map<String, dynamic> _$CreateWorkout$Mutation$CreateWorkout$ExercisesToJson(
        CreateWorkout$Mutation$CreateWorkout$Exercises instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
    };

CreateWorkout$Mutation$CreateWorkout
    _$CreateWorkout$Mutation$CreateWorkoutFromJson(Map<String, dynamic> json) {
  return CreateWorkout$Mutation$CreateWorkout()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..muscleGroups = (json['muscleGroups'] as List<dynamic>?)
        ?.map((e) => e as String?)
        .toList()
    ..exercises = (json['exercises'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : CreateWorkout$Mutation$CreateWorkout$Exercises.fromJson(
                e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CreateWorkout$Mutation$CreateWorkoutToJson(
        CreateWorkout$Mutation$CreateWorkout instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'muscleGroups': instance.muscleGroups,
      'exercises': instance.exercises?.map((e) => e?.toJson()).toList(),
    };

CreateWorkout$Mutation _$CreateWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return CreateWorkout$Mutation()
    ..createWorkout = json['createWorkout'] == null
        ? null
        : CreateWorkout$Mutation$CreateWorkout.fromJson(
            json['createWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateWorkout$MutationToJson(
        CreateWorkout$Mutation instance) =>
    <String, dynamic>{
      'createWorkout': instance.createWorkout?.toJson(),
    };

WorkoutInput _$WorkoutInputFromJson(Map<String, dynamic> json) {
  return WorkoutInput(
    basedOnId: json['basedOnId'] as String?,
    description: json['description'] as String?,
    exercises: (json['exercises'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : ExercisesInput.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as String?,
    name: json['name'] as String,
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$WorkoutInputToJson(WorkoutInput instance) =>
    <String, dynamic>{
      'basedOnId': instance.basedOnId,
      'description': instance.description,
      'exercises': instance.exercises?.map((e) => e?.toJson()).toList(),
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
    };

ExercisesInput _$ExercisesInputFromJson(Map<String, dynamic> json) {
  return ExercisesInput(
    exerciseId: json['exerciseId'] as String,
    notes: json['notes'] as String?,
    repetitions: json['repetitions'] as int,
    rest: json['rest'] as int,
    sets: json['sets'] as int,
  );
}

Map<String, dynamic> _$ExercisesInputToJson(ExercisesInput instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'notes': instance.notes,
      'repetitions': instance.repetitions,
      'rest': instance.rest,
      'sets': instance.sets,
    };

DeleteWorkout$Mutation$DeleteWorkout
    _$DeleteWorkout$Mutation$DeleteWorkoutFromJson(Map<String, dynamic> json) {
  return DeleteWorkout$Mutation$DeleteWorkout()
    ..id = json['id'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$DeleteWorkout$Mutation$DeleteWorkoutToJson(
        DeleteWorkout$Mutation$DeleteWorkout instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

DeleteWorkout$Mutation _$DeleteWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkout$Mutation()
    ..deleteWorkout = json['deleteWorkout'] == null
        ? null
        : DeleteWorkout$Mutation$DeleteWorkout.fromJson(
            json['deleteWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$DeleteWorkout$MutationToJson(
        DeleteWorkout$Mutation instance) =>
    <String, dynamic>{
      'deleteWorkout': instance.deleteWorkout?.toJson(),
    };

WorkoutDetailsMixin$BasedOn$User _$WorkoutDetailsMixin$BasedOn$UserFromJson(
    Map<String, dynamic> json) {
  return WorkoutDetailsMixin$BasedOn$User()
    ..username = json['username'] as String?;
}

Map<String, dynamic> _$WorkoutDetailsMixin$BasedOn$UserToJson(
        WorkoutDetailsMixin$BasedOn$User instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

WorkoutDetailsMixin$BasedOn _$WorkoutDetailsMixin$BasedOnFromJson(
    Map<String, dynamic> json) {
  return WorkoutDetailsMixin$BasedOn()
    ..id = json['id'] as String
    ..user = json['user'] == null
        ? null
        : WorkoutDetailsMixin$BasedOn$User.fromJson(
            json['user'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutDetailsMixin$BasedOnToJson(
        WorkoutDetailsMixin$BasedOn instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user?.toJson(),
    };

WorkoutDetailsMixin$Exercises$Exercise$MuscleGroup
    _$WorkoutDetailsMixin$Exercises$Exercise$MuscleGroupFromJson(
        Map<String, dynamic> json) {
  return WorkoutDetailsMixin$Exercises$Exercise$MuscleGroup()
    ..name = json['name'] as String;
}

Map<String, dynamic> _$WorkoutDetailsMixin$Exercises$Exercise$MuscleGroupToJson(
        WorkoutDetailsMixin$Exercises$Exercise$MuscleGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

WorkoutDetailsMixin$Exercises$Exercise
    _$WorkoutDetailsMixin$Exercises$ExerciseFromJson(
        Map<String, dynamic> json) {
  return WorkoutDetailsMixin$Exercises$Exercise()
    ..name = json['name'] as String?
    ..muscleGroup = json['muscleGroup'] == null
        ? null
        : WorkoutDetailsMixin$Exercises$Exercise$MuscleGroup.fromJson(
            json['muscleGroup'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutDetailsMixin$Exercises$ExerciseToJson(
        WorkoutDetailsMixin$Exercises$Exercise instance) =>
    <String, dynamic>{
      'name': instance.name,
      'muscleGroup': instance.muscleGroup?.toJson(),
    };

WorkoutDetailsMixin$Exercises _$WorkoutDetailsMixin$ExercisesFromJson(
    Map<String, dynamic> json) {
  return WorkoutDetailsMixin$Exercises()
    ..exerciseId = json['exerciseId'] as String
    ..sets = json['sets'] as int
    ..repetitions = json['repetitions'] as int
    ..rest = json['rest'] as int
    ..notes = json['notes'] as String?
    ..exercise = json['exercise'] == null
        ? null
        : WorkoutDetailsMixin$Exercises$Exercise.fromJson(
            json['exercise'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WorkoutDetailsMixin$ExercisesToJson(
        WorkoutDetailsMixin$Exercises instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'sets': instance.sets,
      'repetitions': instance.repetitions,
      'rest': instance.rest,
      'notes': instance.notes,
      'exercise': instance.exercise?.toJson(),
    };

GetWorkoutById$Query$GetWorkoutById
    _$GetWorkoutById$Query$GetWorkoutByIdFromJson(Map<String, dynamic> json) {
  return GetWorkoutById$Query$GetWorkoutById()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..userId = json['userId'] as String
    ..basedOn = json['basedOn'] == null
        ? null
        : WorkoutDetailsMixin$BasedOn.fromJson(
            json['basedOn'] as Map<String, dynamic>)
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..muscleGroups = (json['muscleGroups'] as List<dynamic>?)
        ?.map((e) => e as String?)
        .toList()
    ..exercises = (json['exercises'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : WorkoutDetailsMixin$Exercises.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$GetWorkoutById$Query$GetWorkoutByIdToJson(
        GetWorkoutById$Query$GetWorkoutById instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'userId': instance.userId,
      'basedOn': instance.basedOn?.toJson(),
      'name': instance.name,
      'description': instance.description,
      'muscleGroups': instance.muscleGroups,
      'exercises': instance.exercises?.map((e) => e?.toJson()).toList(),
    };

GetWorkoutById$Query _$GetWorkoutById$QueryFromJson(Map<String, dynamic> json) {
  return GetWorkoutById$Query()
    ..getWorkoutById = json['getWorkoutById'] == null
        ? null
        : GetWorkoutById$Query$GetWorkoutById.fromJson(
            json['getWorkoutById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetWorkoutById$QueryToJson(
        GetWorkoutById$Query instance) =>
    <String, dynamic>{
      'getWorkoutById': instance.getWorkoutById?.toJson(),
    };

UpdateWorkout$Mutation$UpdateWorkout
    _$UpdateWorkout$Mutation$UpdateWorkoutFromJson(Map<String, dynamic> json) {
  return UpdateWorkout$Mutation$UpdateWorkout()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..userId = json['userId'] as String
    ..basedOn = json['basedOn'] == null
        ? null
        : WorkoutDetailsMixin$BasedOn.fromJson(
            json['basedOn'] as Map<String, dynamic>)
    ..name = json['name'] as String
    ..description = json['description'] as String?
    ..muscleGroups = (json['muscleGroups'] as List<dynamic>?)
        ?.map((e) => e as String?)
        .toList()
    ..exercises = (json['exercises'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : WorkoutDetailsMixin$Exercises.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$UpdateWorkout$Mutation$UpdateWorkoutToJson(
        UpdateWorkout$Mutation$UpdateWorkout instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'userId': instance.userId,
      'basedOn': instance.basedOn?.toJson(),
      'name': instance.name,
      'description': instance.description,
      'muscleGroups': instance.muscleGroups,
      'exercises': instance.exercises?.map((e) => e?.toJson()).toList(),
    };

UpdateWorkout$Mutation _$UpdateWorkout$MutationFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkout$Mutation()
    ..updateWorkout = json['updateWorkout'] == null
        ? null
        : UpdateWorkout$Mutation$UpdateWorkout.fromJson(
            json['updateWorkout'] as Map<String, dynamic>);
}

Map<String, dynamic> _$UpdateWorkout$MutationToJson(
        UpdateWorkout$Mutation instance) =>
    <String, dynamic>{
      'updateWorkout': instance.updateWorkout?.toJson(),
    };

SearchExercises$Query$GetExercises$MuscleGroup
    _$SearchExercises$Query$GetExercises$MuscleGroupFromJson(
        Map<String, dynamic> json) {
  return SearchExercises$Query$GetExercises$MuscleGroup()
    ..name = json['name'] as String;
}

Map<String, dynamic> _$SearchExercises$Query$GetExercises$MuscleGroupToJson(
        SearchExercises$Query$GetExercises$MuscleGroup instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

SearchExercises$Query$GetExercises _$SearchExercises$Query$GetExercisesFromJson(
    Map<String, dynamic> json) {
  return SearchExercises$Query$GetExercises()
    ..$$typename = json['__typename'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String?
    ..muscleGroup = json['muscleGroup'] == null
        ? null
        : SearchExercises$Query$GetExercises$MuscleGroup.fromJson(
            json['muscleGroup'] as Map<String, dynamic>);
}

Map<String, dynamic> _$SearchExercises$Query$GetExercisesToJson(
        SearchExercises$Query$GetExercises instance) =>
    <String, dynamic>{
      '__typename': instance.$$typename,
      'id': instance.id,
      'name': instance.name,
      'muscleGroup': instance.muscleGroup?.toJson(),
    };

SearchExercises$Query _$SearchExercises$QueryFromJson(
    Map<String, dynamic> json) {
  return SearchExercises$Query()
    ..getExercises = (json['getExercises'] as List<dynamic>?)
        ?.map((e) => e == null
            ? null
            : SearchExercises$Query$GetExercises.fromJson(
                e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$SearchExercises$QueryToJson(
        SearchExercises$Query instance) =>
    <String, dynamic>{
      'getExercises': instance.getExercises?.map((e) => e?.toJson()).toList(),
    };

CreateUser$Mutation$CreateUser _$CreateUser$Mutation$CreateUserFromJson(
    Map<String, dynamic> json) {
  return CreateUser$Mutation$CreateUser()..id = json['id'] as String;
}

Map<String, dynamic> _$CreateUser$Mutation$CreateUserToJson(
        CreateUser$Mutation$CreateUser instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateUser$Mutation _$CreateUser$MutationFromJson(Map<String, dynamic> json) {
  return CreateUser$Mutation()
    ..createUser = json['createUser'] == null
        ? null
        : CreateUser$Mutation$CreateUser.fromJson(
            json['createUser'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CreateUser$MutationToJson(
        CreateUser$Mutation instance) =>
    <String, dynamic>{
      'createUser': instance.createUser?.toJson(),
    };

ProfileInfoInput _$ProfileInfoInputFromJson(Map<String, dynamic> json) {
  return ProfileInfoInput(
    bio: json['bio'] as String?,
    height: (json['height'] as num?)?.toDouble(),
    name: json['name'] as String,
    profilePicture: json['profilePicture'] as String?,
    username: json['username'] as String,
    weight: (json['weight'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$ProfileInfoInputToJson(ProfileInfoInput instance) =>
    <String, dynamic>{
      'bio': instance.bio,
      'height': instance.height,
      'name': instance.name,
      'profilePicture': instance.profilePicture,
      'username': instance.username,
      'weight': instance.weight,
    };

GetUserById$Query$GetUserById$ProfileInfo
    _$GetUserById$Query$GetUserById$ProfileInfoFromJson(
        Map<String, dynamic> json) {
  return GetUserById$Query$GetUserById$ProfileInfo()
    ..username = json['username'] as String?
    ..name = json['name'] as String?
    ..height = (json['height'] as num?)?.toDouble()
    ..weight = (json['weight'] as num?)?.toDouble()
    ..profilePicture = json['profilePicture'] as String?
    ..bio = json['bio'] as String?;
}

Map<String, dynamic> _$GetUserById$Query$GetUserById$ProfileInfoToJson(
        GetUserById$Query$GetUserById$ProfileInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'height': instance.height,
      'weight': instance.weight,
      'profilePicture': instance.profilePicture,
      'bio': instance.bio,
    };

GetUserById$Query$GetUserById _$GetUserById$Query$GetUserByIdFromJson(
    Map<String, dynamic> json) {
  return GetUserById$Query$GetUserById()
    ..id = json['id'] as String
    ..profileInfo = json['profileInfo'] == null
        ? null
        : GetUserById$Query$GetUserById$ProfileInfo.fromJson(
            json['profileInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetUserById$Query$GetUserByIdToJson(
        GetUserById$Query$GetUserById instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profileInfo': instance.profileInfo?.toJson(),
    };

GetUserById$Query _$GetUserById$QueryFromJson(Map<String, dynamic> json) {
  return GetUserById$Query()
    ..getUserById = json['getUserById'] == null
        ? null
        : GetUserById$Query$GetUserById.fromJson(
            json['getUserById'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GetUserById$QueryToJson(GetUserById$Query instance) =>
    <String, dynamic>{
      'getUserById': instance.getUserById?.toJson(),
    };

GetWorkoutsByUserIdArguments _$GetWorkoutsByUserIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return GetWorkoutsByUserIdArguments(
    userId: json['userId'] as String,
  );
}

Map<String, dynamic> _$GetWorkoutsByUserIdArgumentsToJson(
        GetWorkoutsByUserIdArguments instance) =>
    <String, dynamic>{
      'userId': instance.userId,
    };

CreateWorkoutArguments _$CreateWorkoutArgumentsFromJson(
    Map<String, dynamic> json) {
  return CreateWorkoutArguments(
    workout: WorkoutInput.fromJson(json['workout'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateWorkoutArgumentsToJson(
        CreateWorkoutArguments instance) =>
    <String, dynamic>{
      'workout': instance.workout.toJson(),
    };

DeleteWorkoutArguments _$DeleteWorkoutArgumentsFromJson(
    Map<String, dynamic> json) {
  return DeleteWorkoutArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DeleteWorkoutArgumentsToJson(
        DeleteWorkoutArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

GetWorkoutByIdArguments _$GetWorkoutByIdArgumentsFromJson(
    Map<String, dynamic> json) {
  return GetWorkoutByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$GetWorkoutByIdArgumentsToJson(
        GetWorkoutByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

UpdateWorkoutArguments _$UpdateWorkoutArgumentsFromJson(
    Map<String, dynamic> json) {
  return UpdateWorkoutArguments(
    workout: WorkoutInput.fromJson(json['workout'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateWorkoutArgumentsToJson(
        UpdateWorkoutArguments instance) =>
    <String, dynamic>{
      'workout': instance.workout.toJson(),
    };

SearchExercisesArguments _$SearchExercisesArgumentsFromJson(
    Map<String, dynamic> json) {
  return SearchExercisesArguments(
    exerciseName: json['exerciseName'] as String?,
  );
}

Map<String, dynamic> _$SearchExercisesArgumentsToJson(
        SearchExercisesArguments instance) =>
    <String, dynamic>{
      'exerciseName': instance.exerciseName,
    };

CreateUserArguments _$CreateUserArgumentsFromJson(Map<String, dynamic> json) {
  return CreateUserArguments(
    userId: json['userId'] as String,
    profileInfo:
        ProfileInfoInput.fromJson(json['profileInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateUserArgumentsToJson(
        CreateUserArguments instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'profileInfo': instance.profileInfo.toJson(),
    };

GetUserByIdArguments _$GetUserByIdArgumentsFromJson(Map<String, dynamic> json) {
  return GetUserByIdArguments(
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$GetUserByIdArgumentsToJson(
        GetUserByIdArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
