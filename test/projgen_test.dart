import 'dart:io';
import 'dart:math';

import 'package:projgen/projgen.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Folder and File Creation:',
    () {
      final testRootDir = Directory.systemTemp;

      test(
        'createFolder should create the expected folders',
        () {
          final jsonConfig = {
            'dir1': {
              'dir2': [
                {'dir3': null},
                'file1.dart',
              ],
              'dir4': [
                {'dir5': null},
                {'dir6': null},
              ],
            }
          };

          createFolders(jsonConfig, testRootDir.path);
          expect(Directory('${testRootDir.path}/dir1/dir2/dir3').existsSync(),
              isTrue);
          expect(Directory('${testRootDir.path}/dir1/dir4/dir5').existsSync(),
              isTrue);
          expect(Directory('${testRootDir.path}/dir1/dir4/dir6').existsSync(),
              isTrue);
        },
      );

      test(
        'createFile should create the expected file',
        () {
          final fileName = 'test_file.txt';
          createFile(fileName, testRootDir.path);

          expect(File('${testRootDir.path}/$fileName').existsSync(), isTrue);
        },
      );
    },
  );

  group(
    'Read YAML file',
    () {
      test(
        'Read valid YAML file',
        () async {
          final filePath = 'test/data/test.yaml';
          final expectedContent = 'name: this is a test file\n';

          final content = await readYamlFile(filePath);

          expect(content, equals(expectedContent));
        },
      );

      test(
        'Read a non-existent yaml file',
        () {
          final filePath = 'test/data/test_non_existent.yaml';

          expect(
            () async => await readYamlFile(filePath),
            throwsA(isA<FileSystemException>()),
          );
        },
      );
    },
  );
}
