import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';


Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}


Future<String> networkImageToBase64(String imageUrl) async {
  Response? response = await  get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  return (base64Encode(bytes));
}