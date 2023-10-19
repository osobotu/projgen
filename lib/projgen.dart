import 'dart:io';

import 'package:yaml/yaml.dart';

final projgenYamlPath = getFilePath('projgen.yaml');

Future<void> createStructure() async {
  stdout.write('Generating project structure...\n');
  final yaml = await readYamlFile(projgenYamlPath);

  final yamlContent = getYamlContent(yaml);

  final rootPath = Directory.current.path;

  final jsonConfig = yamlContent['structure'];

  createFolders(jsonConfig, rootPath);
}

Future<void> createFeature(String name) async {
  final yaml = await readYamlFile(projgenYamlPath);

  final yamlContent = getYamlContent(yaml);

  final jsonConfig = yamlContent['feature'];

  final featuresFolderPath = Directory.current.path;
  final featurePath = '$featuresFolderPath/$name';
  final featureDir = Directory(featurePath);
  featureDir.createSync();

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

Future<String> getVersion() async {
  final pubspecPath = getFilePath('pubspec.yaml');
  final yaml = await readYamlFile(pubspecPath);

  final yamlContent = getYamlContent(yaml);

  final version = yamlContent['version'];
  return 'projgen $version';
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

/// include file extension
String getFilePath(String filename) {
  Directory currentDir = Directory.current;

  while (!File('${currentDir.path}/$filename').existsSync()) {
    final parentDir = currentDir.parent;

    if (parentDir == currentDir) {
      stderr.write('$filename file not found');
    }

    currentDir = parentDir;
  }

  return '${currentDir.path}/$filename';
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
