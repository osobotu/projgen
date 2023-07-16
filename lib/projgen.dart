import 'dart:io';

import 'package:yaml/yaml.dart';

const filePath = 'structure.yaml';

void createStructure() async {
  final yaml = await readYamlFile(filePath);

  final yamlContent = getYamlContent(yaml);

  final rootPath = yamlContent['root'];
  final jsonConfig = yamlContent['structure'];

  createFolders(jsonConfig, rootPath);
}

void createFeature(String name) async {
  final yaml = await readYamlFile(filePath);

  final yamlContent = getYamlContent(yaml);

  final featurePath = '${yamlContent['root']}/demo/src/features/$name';
  final featureDir = Directory(featurePath);
  featureDir.createSync();

  final jsonConfig = yamlContent['feature'];
  createFolders(jsonConfig, featurePath);
}

dynamic getYamlContent(String yaml) {
  try {
    final yamlContent = loadYaml(yaml, recover: true);
    return yamlContent;
  } catch (e) {
    stderr.write(e.toString());
    exit(-1);
  }
}

Future<String> readYamlFile(String filePath) async {
  try {
    final file = File(filePath);
    final content = await file.readAsString();
    return content;
  } catch (e) {
    stderr.write(e.toString());
    exit(-1);
  }
}

void createFolders(dynamic jsonConfig, String rootPath) {
  if (jsonConfig is Map) {
    jsonConfig.forEach((key, value) {
      final folderPath = Directory('$rootPath/$key');
      folderPath.createSync();

      if (value != null) {
        createFolders(value, folderPath.path);
      }
    });
  } else if (jsonConfig is List) {
    for (var item in jsonConfig) {
      createFolders(item, rootPath);
    }
  } else if (jsonConfig is String) {
    createFile(jsonConfig, rootPath);
  }
}

void createFile(String fileName, String rootPath) {
  final file = File('$rootPath/$fileName');
  file.createSync();
}
