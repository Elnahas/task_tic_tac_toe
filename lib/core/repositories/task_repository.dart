import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../data/enum/task_status.dart';
import '../data/model/task_model.dart';
import '../helpers/constants.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTasks({
    required int numberOfTasks,
    required int interval,
  }) async {
    final now = Timestamp.now();
    for (int i = 0; i < numberOfTasks; i++) {
      final dueTime = Timestamp.fromDate(
          now.toDate().add(Duration(minutes: interval * (i + 1))));
      final taskId = const Uuid().v4();
      final task = TaskModel(
        id: taskId,
        title: "Task ${i + 1}",
        status: TaskStatus.unassigned,
        dueTime: dueTime,
      );
      await _firestore
          .collection(FirestoreCollections.tasks)
          .doc(taskId)
          .set(task.toJson());
    }
  }
}
