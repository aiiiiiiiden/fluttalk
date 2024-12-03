import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttalk/data/repository/repository.dart';

typedef Converter<T> = T Function(Map<String, dynamic>);

class FirebaseFirestoreRepository implements Repository {
  final FirebaseFirestore firestore;
  FirebaseFirestoreRepository({required this.firestore});
  Stream<T?> stream<T>({
    required String collection,
    required String document,
    required Converter<T> converter,
  }) {
    return firestore.collection(collection).doc(document).snapshots().map(
      (snapshot) {
        final data = snapshot.data();
        return data != null ? converter(snapshot.data()!) : null;
      },
    );
  }
}
