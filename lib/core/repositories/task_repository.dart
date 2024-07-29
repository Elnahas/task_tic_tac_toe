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
    try {
      var collection = _firestore
          .collection(FirestoreCollections.users)
          .doc(_auth.currentUser!.uid)
          .collection(FirestoreCollections.tasks);

      // Fetch current documents
      var snapshots = await collection.get();

      // Create a batch
      var batch = _firestore.batch();

      // Add delete operations to the batch
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batch to delete current documents
      await batch.commit();

      // Create new tasks with the new sequence
      //final now = Timestamp.now();
      for (int i = 0; i < numberOfTasks; i++) {

        final durationInMinutes = sequenceOfTasks * (i + 1);
        final dueTime = DateTime.fromMillisecondsSinceEpoch(
            Duration(minutes: durationInMinutes).inMilliseconds);
        final dueTimeTimestamp = Timestamp.fromDate(dueTime);

        final taskId = const Uuid().v4();
        final task = TaskModel(
          isArchive: false,
          id: taskId,
          title: "Task ${i + 1}",
          status: TaskStatus.unassigned,
          dueTime: dueTimeTimestamp,
        );
        await collection.doc(taskId).set(task.toJson());
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TaskModel>> getTasks(String status) async {
    try {
      Query query = _firestore
          .collection(FirestoreCollections.users)
          .doc(_auth.currentUser!.uid)
          .collection(FirestoreCollections.tasks);

      query = query
          .where("status", isEqualTo: status)
          .where("is_archive", isEqualTo: false)
          .orderBy("title");

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

  Future<void> updateTaskArchive(String taskId, bool isArchive) async {
    try {
      await _firestore
          .collection(FirestoreCollections.users)
          .doc(_auth.currentUser!.uid)
          .collection(FirestoreCollections.tasks)
          .doc(taskId)
          .update(
              {"is_archive": isArchive, "status": TaskStatus.unassigned.name});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reloadTasks() async {
    try {
      QuerySnapshot<Object?> snapshot = await _firestore
          .collection(FirestoreCollections.users)
          .doc(_auth.currentUser!.uid)
          .collection(FirestoreCollections.tasks)
          .get();

      List<TaskModel> tasks = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data["id"] = doc.id;
        return TaskModel.fromJson(data);
      }).toList();

      for (var task in tasks) {
        await updateTaskArchive(task.id, false);
      }
    } catch (e) {
      rethrow;
    }
  }
}
