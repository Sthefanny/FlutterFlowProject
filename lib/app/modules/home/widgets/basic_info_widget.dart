import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../common/enums/user_gender_enum.dart';
import '../../../common/styles/text_styles.dart';
import '../../../common/widgets/fields.dart';
import '../home_store.dart';

class BasicInfoWidget extends StatelessWidget {
  final HomeStore store;
  BasicInfoWidget({super.key, required this.store});
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text('Basic Information', style: TextStyles.Heading),
          ),
          Text('Name:', style: TextStyles.Subheading),
          TextInput(
            hintText: 'Your Name',
            errorText: store.error.name,
            onChanged: (value) {
              nameController.text = value;
              return store.name = value;
            },
            controller: nameController,
          ),
          Text('Age:', style: TextStyles.Subheading),
          TextInput(
            hintText: 'XX',
            errorText: store.error.age,
            inputFormatters: [
              services.FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            keyboardType: services.TextInputType.number,
            onChanged: (value) {
              ageController.text = value;
              return store.age = value;
            },
            controller: ageController,
          ),
          Text('Gender:', style: TextStyles.Subheading),
          GenderInput(
            errorText: store.error.gender,
            onChanged: (UserGender? value) => store.gender = value?.getString,
          ),
        ],
      ),
    );
  }
}
