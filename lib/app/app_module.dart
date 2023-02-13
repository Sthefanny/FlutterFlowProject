import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterflow_project/app/common/configs/constants.dart';

import 'modules/home/home_module.dart';
import 'modules/result/result_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
    ModuleRoute(Constants.resultRoute, module: ResultModule()),
  ];

}
