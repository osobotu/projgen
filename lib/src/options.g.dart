// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// CliGenerator
// **************************************************************************

Options _$parseOptionsResult(ArgResults result) => Options(
      result['help'] as bool,
      result['structure'] as bool,
    );

ArgParser _$populateOptionsParser(ArgParser parser) => parser
  ..addFlag(
    'help',
    abbr: 'h',
    help: 'Prints usage information.',
    negatable: false,
  )
  ..addFlag(
    'structure',
    abbr: 's',
    help: 'Generate project structure.',
    negatable: false,
  );

final _$parserForOptions = _$populateOptionsParser(ArgParser());

Options parseOptions(List<String> args) {
  final result = _$parserForOptions.parse(args);
  return _$parseOptionsResult(result);
}
