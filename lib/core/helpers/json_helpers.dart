import 'package:cloud_firestore/cloud_firestore.dart';


Timestamp timestampFromJson(dynamic json) {
  return json is Timestamp
      ? json
      : Timestamp.fromMillisecondsSinceEpoch(json as int);
}

dynamic timestampToJson(Timestamp timestamp) =>
    timestamp.millisecondsSinceEpoch;
