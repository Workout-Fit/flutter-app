class Workout {
  final String id;
  final String authorId;
  final String name;
  final String description;
  final String creationDate;
  final String? basedOn;

  Workout(
      this.id, this.authorId, this.name, this.description, this.creationDate,
      [this.basedOn]);

  Workout.fromJson(Map<String, dynamic> json)
      : id = json["workout_id"],
        authorId = json["author_id"],
        name = json["name"],
        description = json["description"],
        creationDate = json["creation_date"],
        basedOn = json["based_on"];

  Map<String, dynamic> toJson() => {
        "workout_id": id,
        "author_id": authorId,
        "name": name,
        "description": description,
        "creation_date": creationDate,
        "based_on": basedOn
      };
}
