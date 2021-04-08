class Task {
  String name;
  String workDuration;
  String breakDuration;
  // int id;
  // bool isComplete;
  //
  Task(
    this.name,
    this.breakDuration,
    this.workDuration,
  );

  Map toJson() => {
        'name': name,
        'workDuration': workDuration,
        'breakDuration': breakDuration,
      };
}
