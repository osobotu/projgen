import 'dart:io';

import 'package:yaml/yaml.dart';

final projgenYamlPath = getProjgenYamlPath();

Future<void> createStructure() async {
  final yaml = await readYamlFile(projgenYamlPath);

  final yamlContent = getYamlContent(yaml);

  final rootPath = Directory.current.path;

  final jsonConfig = yamlContent['structure'];

  createFolders(jsonConfig, rootPath);
}

// todo: check this
Future<void> createFeature(String name) async {
  final yaml = await readYamlFile(projgenYamlPath);

  final yamlContent = getYamlContent(yaml);

  // final featuresFolderPath = getFolderPath('features');
  final featuresFolderPath = Directory.current.path;
  final featurePath = '$featuresFolderPath/$name';
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

String getProjgenYamlPath() {
  Directory currentDir = Directory.current;

  while (!File('${currentDir.path}/projgen.yaml').existsSync()) {
    final parentDir = currentDir.parent;

    if (parentDir == currentDir) {
      stderr.write('projgen.yaml file not found');
    }

    currentDir = parentDir;
  }

  return '${currentDir.path}/projgen.yaml';
}

String getFolderPath(String folderName) {
  final currentDir = Directory.current;
  final folder = Directory('${currentDir.path}/$folderName');

  if (folder.existsSync()) {
    return folder.path;
  } else {
    stderr.write('Folder not found: $folderName\n');
    stderr.write(
        'Have you generated a project structure?\nGenerate a project before adding features\n');
    exit(-1);
  }
}
