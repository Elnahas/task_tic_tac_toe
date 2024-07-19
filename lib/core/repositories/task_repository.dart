import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../data/enum/task_status.dart';
import '../data/model/task_model.dart';
import '../helpers/constants.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createTasks({
    required int numberOfTasks,
    required int sequenceOfTasks,
  }) async {
    final now = Timestamp.now();
    for (int i = 0; i < numberOfTasks; i++) {
      final dueTime = Timestamp.fromDate(
          now.toDate().add(Duration(minutes: sequenceOfTasks * (i + 1))));
      final taskId = const Uuid().v4();
      final task = TaskModel(
        id: taskId,
        title: "Task ${i + 1}",
        status: TaskStatus.unassigned,
        dueTime: dueTime,
      );
      await _firestore
          .collection(FirestoreCollections.users)
          .doc(_auth.currentUser!.uid)
          .collection(FirestoreCollections.tasks)
          .doc(taskId)
          .set(task.toJson());
    }
  }

  Future<List<TaskModel>> getTasks(String? status) async {
    try {
      Query query = _firestore
          .collection(FirestoreCollections.users)
          .doc(_auth.currentUser!.uid)
          .collection(FirestoreCollections.tasks);

      query = query.where('status', isEqualTo: status);

      QuerySnapshot<Object?> snapshot = await query.get();

      List<TaskModel> tasks = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return TaskModel.fromJson(data);
      }).toList();

      return tasks;
    } catch (e) {
      rethrow;
    }
  }
}
