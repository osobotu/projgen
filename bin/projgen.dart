import 'dart:io';

import 'package:projgen/projgen.dart' as projgen;
import 'package:projgen/src/options.dart';

void main(List<String> args) {
  run(args);
}

void run(args) {
  try {
    var options = parseOptions(args);
    if (options.help) {
      _printUsage();
      return;
    }

    if (options.structure) {
      stdout.write('Generating project structure...\n');
      projgen.createStructure();
      stdout.write('Done!\n');
    } else if (options.feature.isNotEmpty) {
      stdout.write('Generating ${options.feature} feature...\n');
      projgen.createFeature(options.feature);
      stdout.write('Done!\n');
    } else {
      _printUsage();
      return;
    }
  } on FormatException {
    _printUsage();
    exit(-1);
  }
}

void _printUsage() {
  print('''
This is a command-line tool for project structure generation.

Usage: projgen [<args>]

Arguments:
${parser.usage}
''');
}
