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

    for (int i = 0; i < numberOfTasks; i++) {
      DateTime now = DateTime.now();
      final dueTime = Timestamp.fromDate(
        now.add(Duration(minutes: sequenceOfTasks * (i + 1))),
      );

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

  Future<List<TaskModel>> getTasks(String status) async {
    try {
      Query query = _firestore
          .collection(FirestoreCollections.users)
          .doc(_auth.currentUser!.uid)
          .collection(FirestoreCollections.tasks);

      query = query.where("status", isEqualTo: status).orderBy("title");

      QuerySnapshot<Object?> snapshot = await query.get();

      List<TaskModel> tasks = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data["id"] = doc.id;
        return TaskModel.fromJson(data);
      }).toList();

      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask(String taskId, String status) async {
    try {
      await _firestore
          .collection(FirestoreCollections.users)
          .doc(_auth.currentUser!.uid)
          .collection(FirestoreCollections.tasks)
          .doc(taskId)
          .update({"status": status});
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> hasAssigned() async {
    try {
      Query query = _firestore
          .collection(FirestoreCollections.users)
          .doc(_auth.currentUser!.uid)
          .collection(FirestoreCollections.tasks);

      query = query.where("status", isEqualTo: TaskStatus.assigned.name);

      QuerySnapshot result = await query.limit(1).get();

      return result.docs.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }
}
