import 'dart:io';
import 'package:better_open_file/better_open_file.dart';
import 'package:ticketz/models/participant.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelService {
  Future<String> exportToExcel(List<Participant> participants) async {
    debugPrint('Excel function called');
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName('A1').setText('Participant Id');
    sheet.getRangeByName('B1').setText('English Name');
    sheet.getRangeByName('C1').setText('Chinese Name');
    sheet.getRangeByName('D1').setText('IC Number');
    sheet.getRangeByName('E1').setText('Phone Number');
    sheet.getRangeByName('F1').setText('Email Address');
    sheet.getRangeByName('G1').setText('Halal');
    sheet.getRangeByName('H1').setText('Vegetarian');
    sheet.getRangeByName('I1').setText('Allergic');
    sheet.getRangeByName('J1').setText('Student Status');
    sheet.getRangeByName('K1').setText('Secondary School');
    sheet.getRangeByName('L1').setText('Unit');
    sheet.getRangeByName('M1').setText('Datetime Registered');
    sheet.getRangeByName('N1').setText('Paid');
    sheet.getRangeByName('O1').setText('Attended');

    for (int i = 0; i < participants.length; i++) {
      sheet.getRangeByIndex(i + 2, 1).setText(participants[i].id);
      sheet.getRangeByIndex(i + 2, 2).setText(participants[i].englishName);
      sheet.getRangeByIndex(i + 2, 3).setText(participants[i].chineseName);
      sheet.getRangeByIndex(i + 2, 4).setText(participants[i].icNumber);
      sheet.getRangeByIndex(i + 2, 5).setText(participants[i].phoneNumber);
      sheet.getRangeByIndex(i + 2, 6).setText(participants[i].emailAddress);
      sheet.getRangeByIndex(i + 2, 7).setText(
            participants[i].isHalal ? 'Halal' : 'Non-Halal',
          );
      sheet.getRangeByIndex(i + 2, 8).setText(
            participants[i].isVegetarian ? 'Vegetarian' : 'Non-Vegetarian',
          );

      sheet.getRangeByIndex(i + 2, 9).setText(participants[i].allergic);
      sheet.getRangeByIndex(i + 2, 10).setText(participants[i].studentStatus);
      sheet.getRangeByIndex(i + 2, 11).setText(participants[i].secondarySchool);
      sheet.getRangeByIndex(i + 2, 12).setText(participants[i].unit);
      sheet.getRangeByIndex(i + 2, 13).setText(
            participants[i].datetimeCreated.toIso8601String(),
          );
      sheet.getRangeByIndex(i + 2, 14).setText(
            participants[i].isPaid ? 'Paid' : 'Not Paid',
          );
      sheet.getRangeByIndex(i + 2, 15).setText(
            participants[i].isAttended ? 'Present' : 'Absent',
          );
    }

    final Range range = sheet.getRangeByIndex(
      1,
      1,
      participants.length + 2,
      15,
    );

    range.autoFitColumns();

    final List<int> bytes = workbook.saveAsStream();

    workbook.dispose();

    await Permission.storage.request();

    final directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    final String fileName = '$path/Participants.xlsx';
    final File file = File(fileName);
    final File output = await file.writeAsBytes(bytes, flush: true);

    debugPrint(output.path);
    return output.path;
  }

  Future<OpenResult> openFile(String fileName) {
    return OpenFile.open(fileName);
  }
}
