import 'dart:io';

import 'package:projgen/projgen.dart' as projgen;
import 'package:projgen/src/options.dart';

Future<void> main(List<String> args) async {
  await run(args);
}

Future<void> run(List<String> args) async {
  try {
    var options = parseOptions(args);
    if (options.help) {
      _printUsage();
      return;
    }

    if (options.structure) {
      stdout.write('Generating project structure...\n');
      await projgen.createStructure();
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
