import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticketz/models/attendance_update.dart';
import 'package:ticketz/models/payment_update.dart';

class Participant {
  String? id;
  String englishName;
  String? chineseName;
  String icNumber;
  String phoneNumber;
  String emailAddress;
  bool isHalal;
  bool isVegetarian;
  String? allergic;
  String studentStatus;
  String? secondarySchool;
  String? unit;
  DateTime datetimeCreated;
  bool isPaid = false;
  bool isAttended = false;
  List<PaymentUpdate>? paymentUpdates;
  List<AttendanceUpdate>? attendanceUpdates;

  Participant({
    this.id,
    required this.englishName,
    required this.icNumber,
    required this.phoneNumber,
    required this.emailAddress,
    required this.isHalal,
    required this.isVegetarian,
    required this.studentStatus,
    required this.datetimeCreated,
    this.chineseName,
    this.allergic,
    this.secondarySchool,
    this.unit,
    this.isPaid = false,
    this.isAttended = false,
    this.paymentUpdates,
    this.attendanceUpdates,
  });

  Map<String, dynamic> toJson() => _participantToFirebase(this);

  factory Participant.fromFirebase(QueryDocumentSnapshot snapshot) =>
      _participantFromFirebase(snapshot);

  Map<String, dynamic> _participantToFirebase(Participant participant) =>
      <String, dynamic>{
        'id': participant.id,
        'englishName': participant.englishName,
        'icNumber': participant.icNumber,
        'phoneNumber': participant.phoneNumber,
        'emailAddress': participant.emailAddress,
        'isHalal': participant.isHalal,
        'isVegetarian': participant.isVegetarian,
        'studentStatus': participant.studentStatus,
        'chineseName': participant.chineseName,
        'allergic': participant.allergic,
        'secondarySchool': participant.secondarySchool,
        'unit': participant.unit,
        'datetimeCreated': participant.datetimeCreated,
        'isPaid': participant.isPaid,
        'isAttended': participant.isAttended,
        'paymentUpdates': participant.paymentUpdates
            ?.map((update) => update.paymentUpdateToJson())
            .toList(),
        'attendanceUpdates': participant.attendanceUpdates
            ?.map((update) => update.attendanceUpdateToJson())
            .toList(),
      };
}

Participant _participantFromFirebase(QueryDocumentSnapshot snapshot) {
  // return Participant(
  //   englishName: snapshot['englishName'] as String,
  //   icNumber: snapshot['icNumber'] as String,
  //   phoneNumber: snapshot['phoneNumber'] as String,
  //   emailAddress: snapshot['emailAddress'] as String,
  //   isHalal: snapshot['isHalal'] as bool,
  //   isVegetarian: snapshot['isVegetarian'] as bool,
  //   studentStatus: snapshot['studentStatus'] as String,
  //   chineseName: snapshot['chineseName'] as String?,
  //   allergic: snapshot['allergic'] as String?,
  //   secondarySchool: snapshot['secondarySchool'] as String?,
  //   unit: snapshot['unit'] as String?,
  //   datetimeCreated: DateTime.fromMillisecondsSinceEpoch(
  //       snapshot['datetimeCreated'].millisecondsSinceEpoch),
  //   isPaid: snapshot['isPaid'] as bool,
  //   paymentUpdates: snapshot['paymentUpdates'] ??
  //       snapshot['paymentUpdates']
  //           .map((data) => PaymentUpdate.fromJson(data))
  //           .toList() as List<PaymentUpdate>?,
  // );
  return Participant(
    id: snapshot.reference.id,
    englishName: snapshot.data().toString().contains('englishName')
        ? snapshot.get('englishName')
        : '',
    icNumber: snapshot.data().toString().contains('icNumber')
        ? snapshot.get('icNumber')
        : '',
    phoneNumber: snapshot.data().toString().contains('phoneNumber')
        ? snapshot.get('phoneNumber')
        : '',
    emailAddress: snapshot.data().toString().contains('emailAddress')
        ? snapshot.get('emailAddress')
        : '',
    isHalal: snapshot.data().toString().contains('isHalal')
        ? snapshot.get('isHalal')
        : true,
    isVegetarian: snapshot.data().toString().contains('isVegetarian')
        ? snapshot.get('isVegetarian')
        : true,
    studentStatus: snapshot.data().toString().contains('studentStatus')
        ? snapshot.get('studentStatus')
        : '',
    chineseName: snapshot.data().toString().contains('chineseName')
        ? snapshot.get('chineseName')
        : null,
    allergic: snapshot.data().toString().contains('allergic')
        ? snapshot.get('allergic')
        : null,
    secondarySchool: snapshot.data().toString().contains('secondarySchool')
        ? snapshot.get('secondarySchool')
        : null,
    unit: snapshot.data().toString().contains('unit')
        ? snapshot.get('unit')
        : null,
    datetimeCreated: snapshot.data().toString().contains('datetimeCreated')
        ? DateTime.fromMillisecondsSinceEpoch(
            snapshot.get('datetimeCreated').millisecondsSinceEpoch)
        : DateTime.fromMicrosecondsSinceEpoch(0),
    isPaid: snapshot.data().toString().contains('isPaid')
        ? snapshot.get('isPaid')
        : false,
    paymentUpdates: snapshot.data().toString().contains('paymentUpdates') &&
            snapshot.get('paymentUpdates') != null
        ? snapshot
            .get('paymentUpdates')
            .map<PaymentUpdate>((data) => PaymentUpdate.fromJson(data))
            .toList() as List<PaymentUpdate>?
        : null,
    isAttended: snapshot.data().toString().contains('isAttended')
        ? snapshot.get('isAttended')
        : false,
    attendanceUpdates: snapshot
                .data()
                .toString()
                .contains('attendanceUpdates') &&
            snapshot.get('attendanceUpdates') != null
        ? snapshot
            .get('attendanceUpdates')
            .map<AttendanceUpdate>((data) => AttendanceUpdate.fromJson(data))
            .toList() as List<AttendanceUpdate>?
        : null,
  );
}
