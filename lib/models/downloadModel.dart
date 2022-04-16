import 'package:flutter_downloader/flutter_downloader.dart';

class FiletypeInfo {
  String fileType = "";
  String fileExtension = "";
}

class TaskInfo {
  final String name;
  final String link;
  final FiletypeInfo filetypeInfo;

  String taskId = "";
  int progress = 0;
  DownloadTaskStatus taskStatus = DownloadTaskStatus.undefined;

  TaskInfo(
      {required this.name, required this.link, required this.filetypeInfo});
}
