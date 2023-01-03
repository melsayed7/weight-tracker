import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/model/my_user.dart';
import 'package:weight_tracker/model/user_weight.dart';

class DatabaseHelper {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static Future<void> registerUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> getUser(String userID) async {
    var docSnapShot = await getUserCollection().doc(userID).get();
    return docSnapShot.data();
  }

  static CollectionReference<UserWeight> getUserWeightCollection() {
    return FirebaseFirestore.instance
        .collection('weight')
        .withConverter<UserWeight>(
          fromFirestore: (snapshot, options) =>
              UserWeight.fromJson(snapshot.data()!),
          toFirestore: (userWeight, options) => userWeight.toJson(),
        );
  }

  static Future<void> addWeightToFirebase(UserWeight weight) {
    var collection = getUserWeightCollection();
    var docRef = collection.doc();
    weight.id = docRef.id;
    return docRef.set(weight);
  }

  static Stream<QuerySnapshot<UserWeight>> getDataFromFirebase() {
    return getUserWeightCollection().where('date').snapshots();
  }

  static Future<void> deleteWeightFromFirebase(UserWeight weight) async {
    return await getUserWeightCollection().doc(weight.id).delete();
  }

  static Future<void> updateWeightFromFirebase(UserWeight weight) {
    return getUserWeightCollection().doc(weight.id).update(weight.toJson());
  }
}
