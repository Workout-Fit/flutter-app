const getWorkoutsByUserId = r'''
  query GetWorkoutsByUserId($userId: String!) {
    getWorkoutsByUserId(userId: $userId) {
      id,
      name,
      muscleGroups,
      exercises {
        exerciseId
      }
    }
  }
''';
