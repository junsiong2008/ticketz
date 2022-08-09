import 'package:better_open_file/better_open_file.dart';
import 'package:ticketz/services/excel.dart';
import 'package:flutter/cupertino.dart';

import '../models/participant.dart';

class ExcelProvider extends ChangeNotifier {
  final ExcelService excelService = ExcelService();

  bool isError = false;
  String? filePath;
  String? errorMessage;

  Future<void> exportToExcel(List<Participant> participants) async {
    try {
      filePath = await excelService.exportToExcel(participants);
      openFile();
    } on Exception {
      isError = true;
      errorMessage = 'Error while exporting the file.';
    }

    notifyListeners();
  }

  Future<void> openFile() async {
    final OpenResult openResult = await excelService.openFile(filePath!);
    switch (openResult.type) {
      case ResultType.done:
        isError = false;
        errorMessage = null;
        break;

      case ResultType.error:
        isError = true;
        errorMessage = 'Error occurred while opening file.';
        break;

      case ResultType.fileNotFound:
        isError = true;
        errorMessage = 'File in $filePath not found.';
        break;

      case ResultType.noAppToOpen:
        isError = true;
        errorMessage = 'Please install an app that can open Excel file.';
        break;

      case ResultType.permissionDenied:
        isError = true;
        errorMessage = 'Permission denied';
        break;
    }
    notifyListeners();
  }

  void resetState() {
    isError = false;
    filePath = null;
    errorMessage = null;
  }
}
