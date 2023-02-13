import 'package:flutter_modular/flutter_modular.dart';
import '../result/result_page.dart';

class ResultModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ResultPage(result: args.data?['result'])),
  ];
}
