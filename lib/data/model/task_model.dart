class MyTasks {
  List<Task>? task;

  MyTasks({this.task});
  factory MyTasks.fromJson(Map<String, dynamic> json) {
    return MyTasks(
        task: (json['tasks'] as List)
            .map((item) => Task.fromJson(item))
            .toList());
  }

  Map<String, dynamic> toJson() => {'tasks': task};
}

class Task {
  String? taskName;
  String? status;
  String? priority;
  String? date;
  List<AssignedTo>? assignedTo;

  Task({this.assignedTo, this.date, this.priority, this.status, this.taskName});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        taskName: json['taskName'],
        status: json['status'],
        priority: json['priority'],
        date: json['date'],
        assignedTo: (json['assignedTo'] as List)
            .map((item) => AssignedTo.fromJson(item))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'taskName': taskName,
        'status': status,
        'priority': priority,
        'date': date,
        'assignedTo': assignedTo
      };
}

class AssignedTo {
  String? profileImage;
  String? personName;

  AssignedTo({this.personName, this.profileImage});

  factory AssignedTo.fromJson(Map<String, dynamic> json) {
    return AssignedTo(
      personName: json['personName'],
      profileImage: json['profileImage'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'personName': personName, 'profileImage': profileImage};
}
