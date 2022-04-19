import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mime/mime.dart';
import 'package:ndialog/ndialog.dart';
import 'package:nfcdemo/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/downloadModel.dart';
import '../utilities/constants.dart';

class DownloadWidget extends StatefulWidget {
  const DownloadWidget({Key? key, required this.fileUrl, this.isOnlyButton})
      : super(key: key);
  final String fileUrl;
  final bool? isOnlyButton;

  @override
  _DownloadWidgetState createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  ReceivePort receivePort = ReceivePort();
  late TaskInfo _taskInfo =
      new TaskInfo(name: "", link: "", filetypeInfo: new FiletypeInfo());
  late ProgressDialog dialog;
  int progress = 0;

  @override
  void initState() {
    dialog = ProgressDialog(
      context,
      blur: 2,
      dialogTransitionType: DialogTransitionType.Shrink,
      message: CustomText(content: "Please wait..."),
      dialogStyle: DialogStyle(
        elevation: 5,
      ),
      dismissable: false,
    );
    _prepareDownloadTask();
    super.initState();
  }

  // @override
  // void dispose() {
  //   _unbindBackgroundIsolate();
  //   super.dispose();
  // }

  FiletypeInfo getFileType(String oUrl) {
    var mimeType = lookupMimeType(oUrl) ?? "";
    FiletypeInfo _filetypeInfo = new FiletypeInfo();
    if (mimeType != "") {
      var lstMimeType = mimeType.split("/").toList();
      _filetypeInfo.fileType = lstMimeType.first;
      _filetypeInfo.fileExtension = lstMimeType.last;
    }
    return _filetypeInfo;
  }

  void _bind() {
    _unbindBackgroundIsolate();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        receivePort.sendPort, "downloadID");

    receivePort.listen((message) {
      _taskInfo.taskId = message[0];
      setState(() {
        _taskInfo.taskStatus = message[1];
        _taskInfo.progress = message[2];
        dialog.message != CustomText(content: "Please wait...${message[1]}");
      });
      if (_taskInfo.taskStatus == DownloadTaskStatus.complete) {
        dialog.dismiss();
        _openDownloadedFile(_taskInfo);
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping("downloadID");
  }

  static downloadCallback(id, status, progress) {
    final SendPort? _sendPort =
        IsolateNameServer.lookupPortByName("downloadID");
    _sendPort?.send([id, status, progress]);
  }

  Future _prepareDownloadTask() async {
    var oFilename = widget.fileUrl.split("/");
    var oFiletypeInfo = getFileType(widget.fileUrl);
    _taskInfo = new TaskInfo(
        name: oFilename.last,
        link: widget.fileUrl,
        filetypeInfo: oFiletypeInfo);
  }

  void _requestDownload(TaskInfo taskInfo) async {
    bool status = await _checkPermission();
    if (status) {
      dialog.show();
      _bind();
      String baseStorage = await _prepareSaveDir(
          taskInfo.filetypeInfo.fileType); // Storage base Path
      taskInfo.taskId = await FlutterDownloader.enqueue(
            url: imageFileHostedPath + taskInfo.link,
            savedDir: baseStorage,
            fileName: taskInfo.name,
          ) ??
          "";
    } else {
      print("No permission");
    }
  }

  void _cancelDownload(TaskInfo taskInfo) async {
    await FlutterDownloader.cancel(taskId: taskInfo.taskId);
  }

  void _pauseDownload(TaskInfo taskInfo) async {
    await FlutterDownloader.pause(taskId: taskInfo.taskId);
  }

  void _resumeDownload(TaskInfo taskInfo) async {
    String newTaskId =
        await FlutterDownloader.resume(taskId: taskInfo.taskId) ?? "";
    taskInfo.taskId = newTaskId;
  }

  void _retryDownload(TaskInfo taskInfo) async {
    String newTaskId =
        await FlutterDownloader.retry(taskId: taskInfo.taskId) ?? "";
    taskInfo.taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(TaskInfo taskInfo) {
    if (taskInfo.taskId != "") {
      return FlutterDownloader.open(taskId: taskInfo.taskId);
    } else {
      return Future.value(false);
    }
  }

  void _delete(TaskInfo taskInfo) async {
    await FlutterDownloader.remove(
        taskId: taskInfo.taskId, shouldDeleteContent: true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return widget.isOnlyButton == true
        ? Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: theme.colorScheme.primaryVariant,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: _buildActionForTask(_taskInfo),
          )
        : Card(
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            elevation: 0.5,
            child: Container(
                child: ListTile(
              minLeadingWidth: 25,
              horizontalTitleGap: 8,
              dense: true,
              leading: _buildViewTask(_taskInfo),
              title: CustomText(
                content: _taskInfo.name.split("_").last,
                style: GoogleFonts.lato(fontSize: 13),
              ),
              trailing: _buildActionForTask(_taskInfo),
            )),
          );
  }

  Widget _buildViewTask(TaskInfo taskInfo) {
    if (taskInfo.filetypeInfo.fileType == "application") {
      return InkWell(
        enableFeedback: true,
        onTap: () => Navigator.pushNamed(context, "pdfviewer",
            arguments: taskInfo.link + "###" + taskInfo.name.split("_").last),
        child: Icon(Icons.picture_as_pdf),
      );
    } else if (taskInfo.filetypeInfo.fileType == "image") {
      return InkWell(
        onTap: () {
          swipeImage(
              context,
              [
                Image(
                  image: NetworkImage(imageFileHostedPath + taskInfo.link),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return ImageWithAsset(
                      path: 'images/imgNotAvailable.png',
                    );
                  },
                ),
              ],
              0,
              false);
        },
        child: Icon(Icons.image),
      );
    } else if (taskInfo.filetypeInfo.fileType == "text") {
      return InkWell(
        child: Icon(Icons.text_snippet),
      );
    } else if (taskInfo.filetypeInfo.fileType == "video") {
      return InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoViewer(videoUrl:imageFileHostedPath+_taskInfo.link)));
        },
        child: Icon(Icons.ondemand_video_outlined),
      );
    } else if (taskInfo.filetypeInfo.fileType == "audio") {
      return InkWell(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> VideoViewer(videoUrl:imageFileHostedPath+_taskInfo.link)));
        },
        child: Icon(Icons.audiotrack),
      );
    } else {
      return InkWell(
        child: Icon(Icons.picture_as_pdf),
      );
    }
  }

  Widget _buildActionForTask(TaskInfo oTaskInfo) {
    var theme = Theme.of(context);
    if (oTaskInfo.taskStatus == DownloadTaskStatus.undefined) {
      return InkWell(
        onTap: () => _requestDownload(oTaskInfo),
        child: Icon(
          Icons.file_download,
          color: theme.colorScheme.primary,
        ),
      );
    } else if (oTaskInfo.taskStatus == DownloadTaskStatus.complete) {
      return InkWell(
        child: Icon(
          Icons.remove_red_eye_sharp,
          color: theme.colorScheme.secondary,
        ),
        onTap: () => _openDownloadedFile(oTaskInfo),
      );
    } else {
      return InkWell(
        onTap: () => _requestDownload(oTaskInfo),
        child: Icon(
          Icons.file_download,
        ),
      );
    }
  }

  Future<bool> _checkPermission() async {
    final platform = Theme.of(context).platform;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt! > 29) {
        final status = await Permission.manageExternalStorage.status;
        if (status != PermissionStatus.granted) {
          final result = await Permission.manageExternalStorage.request();
          if (result == PermissionStatus.granted) {
            return true;
          }
        } else {
          return true;
        }
      } else {
        final status = await Permission.storage.status;
        if (status != PermissionStatus.granted) {
          final result = await Permission.storage.request();
          if (result == PermissionStatus.granted) {
            return true;
          }
        } else {
          return true;
        }
      }
    } else {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    }
    return false;
  }

  Future<String> _prepareSaveDir(String fileTypeName) async {
    String _localPath = (await _findLocalPath(fileTypeName));
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.createSync(recursive: true);
    }
    return _localPath;
  }

  Future<String> _findLocalPath(String fileTypeName) async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        //Create File Type Wise Directory
        externalStorageDirPath = "/storage/emulated/0/Download/EdusprintNew/" +
            uID +
            "/" +
            fileTypeName;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }

    print("StoragePath:-${externalStorageDirPath}");
    return externalStorageDirPath;
  }
}
