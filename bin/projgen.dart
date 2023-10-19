import 'dart:io';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:projgen/src/commands/commands.dart';
import 'package:projgen/projgen.dart' as projgen;

Future<void> main(List<String> args) async {
  await run(args);
}

Future<void> run(List<String> args) async {
  try {
    final projgenRunner = ProjgenRunner();

    projgenRunner.argParser.addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Prints the currently installed version',
    );

    projgenRunner.addCommand(CreateCommand());

    await projgenRunner.run(args);
  } on ArgParserException catch (e) {
    stderr.write(e);
    exit(1);
  } on UsageException catch (e) {
    stderr.write(e);
    exit(1);
  }
}

class ProjgenRunner extends CommandRunner {
  ProjgenRunner()
      : super(
          'projgen',
          'A command-line tool for project structure and feature generation',
        );

  @override
  Future runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version']) {
      final version = await projgen.getVersion();
      stdout.write('$version\n');
      return null;
    }
    return super.runCommand(topLevelResults);
  }
}
