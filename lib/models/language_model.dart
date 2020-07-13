import 'package:flag/flag.dart';

class LanguageModel {
  final int id;
  final Flag flag;
  final String name;
  final String languageCode;

  LanguageModel(this.id, this.flag, this.name, this.languageCode);

  static List<LanguageModel> languageList() {
    return <LanguageModel>[
      LanguageModel(
          1,
          Flag(
            'gb',
            width: 30,
            height: 30,
          ),
          'English',
          'en'),
      LanguageModel(
          2,
          Flag(
            'es',
            width: 30,
            height: 30,
          ),
          'Español',
          'es')
    ];
  }
}
