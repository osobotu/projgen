import 'dart:io';

Future<String> readYAMLFile(String filePath) async {
  try {
    final file = File(filePath);
    final content = await file.readAsString();
    return content;
  } catch (e) {
    throw Exception('Error reading YAML file: $e');
  }
}
