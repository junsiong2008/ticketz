import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticketz/models/attendance_update.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/models/payment_update.dart';

class FirestoreService {
  final FirebaseFirestore firestoreService = FirebaseFirestore.instance;

  Stream<List<Participant>> participantStream() {
    return firestoreService
        .collection('participants')
        .orderBy('englishName')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (document) => Participant.fromFirebase(document),
              )
              .toList(),
        );
  }

  Future<void> updatePaymentStatus(
      String documentId, bool isPaid, String editorEmail) async {
    final docRef = firestoreService.collection('participants').doc(documentId);
    final paymentUpdate = PaymentUpdate(
      editorEmail: editorEmail,
      editedDateTime: DateTime.now(),
      editedPaymentStatus: isPaid,
    );

    final updates = <String, dynamic>{
      "isPaid": isPaid,
      "paymentUpdates":
          FieldValue.arrayUnion([paymentUpdate.paymentUpdateToJson()]),
    };

    return await docRef.update(updates);
  }

  Future<void> updateAttendanceStatus(
      String documentId, bool isAttended, String editorEmail) async {
    final docRef = firestoreService.collection('participants').doc(documentId);
    final attendanceUpdate = AttendanceUpdate(
      editorEmail: editorEmail,
      editedDateTime: DateTime.now(),
      editedAttendanceStatus: isAttended,
    );

    final updates = <String, dynamic>{
      "isAttended": isAttended,
      "attendanceUpdates":
          FieldValue.arrayUnion([attendanceUpdate.attendanceUpdateToJson()]),
    };
    await docRef.update(updates);
  }

  Future<void> deleteParticipant(String documentId) async {
    final docRef = firestoreService.collection('participants').doc(documentId);
    await docRef.delete();
  }
}
