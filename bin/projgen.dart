import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:projgen/src/commands/create_command.dart';

Future<void> main(List<String> args) async {
  await run(args);
}

Future<void> run(List<String> args) async {
  try {
    CommandRunner(
      'projgen',
      'A command-line tool for project structure and feature generation',
    )
      ..addCommand(CreateCommand())
      ..run(args);
  } on ArgParserException catch (e) {
    stderr.write(e);
    exit(1);
  }
}
