enum TaskStatus { unassigned, assigned, completed }


extension TaskStatusExtension on TaskStatus {
  String toShortString() {
    return toString().split('.').last;
  }

  static TaskStatus fromString(String status) {
    return TaskStatus.values.firstWhere((e) => e.toShortString() == status);
  }
}