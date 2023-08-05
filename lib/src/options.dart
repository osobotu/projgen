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
    defaultsTo: false,
    help: "Generate project structure.",
  )
  final bool structure;

  Options(this.help, this.structure);
}
