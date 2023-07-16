import 'package:projgen/projgen.dart' as projgen;
import 'package:projgen/src/options.dart';

void main(List<String> args) {
  var options = parseOptions(args);

  if (options.help) {
    _printUsage();
    return;
  }

  if (options.feature != null) {
    projgen.createFeature(options.feature as String);
  }

  if (options.structure) {
    projgen.createStructure();
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
