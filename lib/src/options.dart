import 'package:build_cli_annotations/build_cli_annotations.dart';

part 'options.g.dart';

ArgParser get parser => _$populateOptionsParser(ArgParser(usageLineLength: 80));

@CliOptions()
class Options {
  @CliOption(abbr: 'h', negatable: false, help: 'Prints usage information.')
  final bool help;

  @CliOption(
    abbr: 's',
    negatable: false,
    defaultsTo: true,
    help: "Generate project structure.",
  )
  final bool structure;

  @CliOption(
    abbr: 'f',
    defaultsTo: null,
    help: "Create a new feature with [name] based on feature structure.",
  )
  final String? feature;

  Options(this.help, this.structure, this.feature);
}
