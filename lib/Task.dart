class Task {
  String taskName;
  String workInterval;
  String breakInterval;
  // int id;
  // bool isComplete
  //
  Task({this.taskName, this.breakInterval, this.workInterval});

  Map toJson() => {
        'taskName': taskName,
        'workInterval': workInterval,
        'breakInterval': breakInterval,
      };

  Task.fromJson(Map<String, dynamic> json)
      : taskName = json['taskName'],
        workInterval = json['workInterval'],
        breakInterval = json['breakInterval'];
}
