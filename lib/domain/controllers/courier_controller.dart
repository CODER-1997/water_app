import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CourierController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addHistory(
      String destinationCollection, String documentId) async {
    try {
      // Retrieve the source document
      DocumentSnapshot sourceDocument = await _firestore.collection('waterOrders').doc(documentId).get();
      final CollectionReference _dataCollection = FirebaseFirestore.instance.collection(destinationCollection);

      // Extract data from the source document
      Object? data = sourceDocument.data();
      await _dataCollection.add({
        'items': data,
      });

      print('Document copied successfully.');
    } catch (e) {
      print('Error copying document: $e');
    }
  }
}
