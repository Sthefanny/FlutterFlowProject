import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../common/configs/constants.dart';
import 'home_store.dart';
import 'widgets/basic_info_widget.dart';
import 'widgets/camera_widget.dart';
import 'widgets/dependents_widget.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<HomeStore>();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Form'),
        ),
        body: store.isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: ListView(
                    children: [
                      BasicInfoWidget(store: store),
                      DependentsWidget(),
                      CameraWidget(store: store),
                      ElevatedButton(
                        onPressed: () async {
                          store.setIsLoading(true);
                          var result = store.submitData();
                          if (result != null) {
                            await Modular.to.pushReplacementNamed(Constants.resultRoute, arguments: {'result': result});

                            store
                              ..setIsLoading(false)
                              ..clearAll();
                          }
                          store.setIsLoading(false);
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
