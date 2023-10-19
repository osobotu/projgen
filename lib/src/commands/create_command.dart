import 'package:args/command_runner.dart';
import 'package:projgen/projgen.dart' as projgen;

class CreateCommand extends Command {
  @override
  String get description => 'Creates an [app structure | feature]';

  @override
  String get name => 'create';

  CreateCommand() {
    argParser.addFlag(
      'structure',
      abbr: 's',
      help: 'Creates the app structure',
      negatable: false,
    );
    argParser.addOption(
      'feature',
      abbr: 'f',
      help: 'Creates a new feature with the given name',
    );
  }

  @override
  void run() async {
    final results = argResults;
    if (results != null) {
      if (results['structure']) {
        await projgen.createStructure();
      } else if (results['feature'] != null) {
        final featureName = results['feature'];
        print('creating new feature with $featureName');
        await projgen.createFeature(featureName);
      } else {
        print(argParser.usage);
      }
    }
  }
}
