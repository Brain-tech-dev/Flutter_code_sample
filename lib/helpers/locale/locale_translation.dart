import 'package:get/get.dart';

class LocaleTranslation extends Translations {
  Map<String, Map<String, String>>? init;
  LocaleTranslation({required this.init});

  @override
  Map<String, Map<String, String>> get keys => init!;
}
