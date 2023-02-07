import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterflow_project/app/modules/models/dependent_model.dart';

import '../../../common/styles/text_styles.dart';
import '../../../common/widgets/fields.dart';

class DependentsWidget extends StatefulWidget {
  DependentsWidget({super.key});

  @override
  State<DependentsWidget> createState() => _DependentsWidgetState();
}

class _DependentsWidgetState extends State<DependentsWidget> {
  var dependentList = <DependentModel>[];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(child: Text('Dependents', style: TextStyles.Heading)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      dependentList.add(DependentModel(name: '', controller: TextEditingController()));
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Observer(
            builder: (_) => ListView.builder(
              shrinkWrap: true,
              itemCount: dependentList.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextInput(
                        margin: const EdgeInsets.all(0),
                        controller: dependentList[index].controller,
                        hintText: 'Dependent Name',
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 20),
                      onPressed: () {
                        setState(() {
                          dependentList.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
