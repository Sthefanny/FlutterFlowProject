import 'package:flutter/material.dart';

import '../../../common/enums/user_gender_enum.dart';
import '../../../common/styles/text_styles.dart';
import '../../../common/widgets/fields.dart';

class BasicInfoWidget extends StatelessWidget {
  const BasicInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text('Basic Information', style: TextStyles.Heading),
          ),
          Text('Name:', style: TextStyles.Subheading),
          TextInput(hintText: 'Your Name'),
          Text('Age:', style: TextStyles.Subheading),
          TextInput(hintText: 'XX'),
          Text('Gender:', style: TextStyles.Subheading),
          GenderInput(
            onChanged: (UserGender? value) {},
          ),
        ],
      ),
    );
  }
}
