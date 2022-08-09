import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentUpdate {
  final String editorEmail;
  final DateTime editedDateTime;
  final bool editedPaymentStatus;

  PaymentUpdate({
    required this.editorEmail,
    required this.editedDateTime,
    required this.editedPaymentStatus,
  });

  Map<String, dynamic> paymentUpdateToJson() => _paymentUpdateToJson(this);

  Map<String, dynamic> _paymentUpdateToJson(PaymentUpdate paymentUpdate) {
    return <String, dynamic>{
      'editorEmail': paymentUpdate.editorEmail,
      'editedDateTime': paymentUpdate.editedDateTime,
      'editedPaymentStatus': paymentUpdate.editedPaymentStatus,
    };
  }

  factory PaymentUpdate.fromJson(Map<String, dynamic> json) =>
      _paymentUpdateFromJson(json);
}

PaymentUpdate _paymentUpdateFromJson(Map<String, dynamic> json) {
  return PaymentUpdate(
    editorEmail: json['editorEmail'] as String,
    editedDateTime: (json['editedDateTime'] as Timestamp).toDate(),
    editedPaymentStatus: json['editedPaymentStatus'] as bool,
  );
}
