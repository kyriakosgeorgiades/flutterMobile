import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as htpp;
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_windows/path_provider_windows.dart';

class ImagesAPI {
  final PathProviderWindows provider = PathProviderWindows();
  Future<String> getStorageDirectory() async {
    if (Platform.isAndroid) {
      return (await getExternalStorageDirectory()).path;
    } else if (Platform.isIOS) {
      return (await getApplicationSupportDirectory()).path;
    } else if (Platform.isWindows) {
      return (await provider.getTemporaryPath());
    }
  }

  Future<String> getPicPath(image, String name) async {
    String dir = await getStorageDirectory();
    final decodedBytes = base64Decode(image);
    File directory = File(dir);
    bool directoryExists = await directory.exists();
    if (directoryExists != true) {
      Directory(dir);
    }
    final finalpath = dir + '/' + name;
    File file = File(finalpath);
    bool fileExists = await file.exists();
    if (fileExists != true) {
      await file.writeAsBytes(decodedBytes);
    }
    return dir + '/' + name;
  }
}
