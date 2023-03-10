import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:najot_talim/entities/card_model.dart';

class FireStoreRepository {
 static Future<List<CardModel>> get(String id) async {
    List<CardModel> proList = [];
    try {
      final pro = await FirebaseFirestore.instance.collection(id).get();
      for (var element in pro.docs) {
        proList.add(CardModel.fromJson(element.data()));
      }
      return proList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future getItem(String id,String docs) async {
    List proList = [];
    try {
      final pro = await FirebaseFirestore.instance.collection(id).doc(docs).get();
      print('FireStoreRepository.get ${pro.data()}');
      // pro.doc;
      // pro.docs.forEach((element) {
      //   return proList.add(element.data());
      // });
      return pro.data();
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
  static Future<void> deleteTask(String id , String docs) async {
    try {
      final pro = await FirebaseFirestore.instance.collection(id);
   pro.doc(docs).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
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
