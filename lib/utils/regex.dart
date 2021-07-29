final RegExp workoutURLRegEx = new RegExp(
  r"^http[s]?://workout\.app/view/([^\s]+)",
  caseSensitive: false,
  multiLine: false,
);

final RegExp usernameRegEx = new RegExp(
  r"^[\w\d]+$",
  caseSensitive: false,
  multiLine: false,
);
