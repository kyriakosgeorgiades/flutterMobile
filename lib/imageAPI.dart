import 'dart:convert';
// import 'dart:io';
import 'dart:typed_data';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:path_provider_windows/path_provider_windows.dart';

class ImagesAPI {
  // Future<String> getStorageDirectory() async {
  //   print("HELLO!");
  //   if (defaultTargetPlatform == TargetPlatform.android) {
  //     return (await getExternalStorageDirectory()).path;
  //   } else if (defaultTargetPlatform == TargetPlatform.iOS) {
  //     return (await getApplicationSupportDirectory()).path;
  //   } else {
  //     print("I am windows");
  //     print(await PathProviderWindows().getTemporaryPath());
  //     return (await PathProviderWindows().getTemporaryPath());
  //   }
  //   print('Name platform');
  //   print(Platform.localeName);
  // }

  // Future<String> getPicPath(image, String name) async {
  //   String dir = await getStorageDirectory();
  //   final decodedBytes = base64Decode(image);
  //   File directory = File(dir);
  //   bool directoryExists = await directory.exists();
  //   if (directoryExists != true) {
  //     Directory(dir);
  //   }
  //   final finalpath = dir + '/' + name;
  //   File file = File(finalpath);
  //   bool fileExists = await file.exists();
  //   if (fileExists != true) {
  //     await file.writeAsBytes(decodedBytes);
  //   }
  //   return dir + '/' + name;
  // }

  Uint8List getBytes(image) {
    final decodedByte = base64Decode(image);
    return decodedByte;
  }
}
