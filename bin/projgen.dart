import 'dart:io';

import 'package:projgen/projgen.dart' as projgen;
import 'package:yaml/yaml.dart';

void main(List<String> arguments) async {
  const filePath = '/Users/obotu/development/projgen/structure.yaml';
  final result = await projgen.readYAMLFile(filePath);
  final yamlContent = loadYaml(result);
  final dirPath = '${yamlContent['root']}/tool';
  createDirectory(dirPath);
  print(dirPath);
}

void createDirectory(String directoryPath) {
  final directory = Directory(directoryPath);
  directory.createSync();
}
