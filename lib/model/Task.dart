class Task {
  String id;
  String taskName;
  String workInterval;
  String breakInterval;
  bool isComplete;

  Task(
      {this.id,
      this.taskName,
      this.breakInterval,
      this.workInterval,
      this.isComplete = false});

  // Convert Map object
  Map toJson() => {
        'this.id': id,
        'taskName': taskName,
        'workInterval': workInterval,
        'breakInterval': breakInterval,
        'isComplete': isComplete,
      };

  // Substitute Map object for Task
  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        taskName = json['taskName'],
        workInterval = json['workInterval'],
        breakInterval = json['breakInterval'],
        isComplete = json['isComplete'];
}
