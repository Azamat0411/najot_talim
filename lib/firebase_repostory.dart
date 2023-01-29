import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreRepository {
  // final _fireStore = FirebaseFirestore.instance.collection(GetStorage().read("email"));
 static Future<List> get(String id) async {
    List proList = [];
    try {
      final pro = await FirebaseFirestore.instance.collection(id).get();
      print('FireStoreRepository.get $id');
      pro.docs.forEach((element) {
        return proList.add(element.data());
      });
      return proList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
 // static Future<void> update({Task? task}) async {
 //    try {
 //      final pro = await FirebaseFirestore.instance.collection(GetStorage().read("email"));
 //   pro.doc(task!.id).update(task.toMap());
 //    } catch (e) {
 //      throw Exception(e.toString());
 //    }
 //  }
 //  static Future<void> deleteTask({Task? task}) async {
 //    try {
 //      final pro = await FirebaseFirestore.instance.collection(GetStorage().read("email"));
 //   pro.doc(task!.id).delete();
 //    } catch (e) {
 //      throw Exception(e.toString());
 //    }
 //  }
 //  static Future<void> deleteTaskList({List? task}) async {
 //    try {
 //      final pro = await FirebaseFirestore.instance.collection(GetStorage().read("email"));
 // for (var item in task!){
 //   pro.doc(item.id).delete();
 // }
 //    } catch (e) {
 //      throw Exception(e.toString());
 //    }
 //  }
}
