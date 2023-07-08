# projgen

This Dart command-line tool automates the generation of the project structure, folders, and files based on a YAML configuration. It simplifies project setup and ensures consistent organization across projects.

## Installation

To install `projgen`, ensure you have [Dart SDK](https://dart.dev/get-dart) installed. Then run the following command:

`pub global activate projgen`

## Usage

To generate the necessary folders and files, use the following command:

`projgen --config structure.yaml`

Replace `structure.yaml` with the path to your YAML configuration files.

## YAML Configuration

The YAML configuration file defines the project structure at a high level. Here is an example:

```
project: yamlToFolders
structure:
  - lib:
      - main.dart
      - config.dart
      - src:
          - core:
              - network
              - shared
              - routes
              - styles
          - features:
              - models
              - views
              - controllers
              - services
```

Modify the YAML configuration file to match your desired project structure. Define directories, files, and their hierarchy according to your project's requirements.

# Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please create a new issue or submit a pull request.

# License

This project is licensed under the [MIT License](https://opensource.org/license/mit/)
