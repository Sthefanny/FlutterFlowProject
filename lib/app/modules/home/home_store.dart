import 'dart:math';

import 'package:mobx/mobx.dart';

import '../../common/extensions/string_extension.dart';
import 'models/dependent_model.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final error = FormErrorState();
  late List<ReactionDisposer> _disposers;

  HomeStoreBase();

  @observable
  String? name;

  @observable
  String? age;

  @observable
  String? gender;

  @observable
  bool isLoading = false;

  @observable
  List<DependentModel> dependentList = <DependentModel>[];

  @computed
  bool get canSubmit => !error.hasErrors;

  @action
  void setIsLoading(bool value) => isLoading = value;

  @action
  void addDependent(DependentModel value) => dependentList.add(value);

  @action
  void removeDependent(int index) => dependentList.removeAt(index);

  @action
  void validateName(String? value) {
    error.name = value.isNullOrEmpty ? 'Cannot be blank' : null;
  }

  @action
  void validateAge(String? value) {
    error.age = value.isNullOrEmpty ? 'Cannot be blank' : null;
  }

  @action
  void validateGender(String? value) {
    error.gender = value.isNullOrEmpty ? 'Cannot be blank' : null;
  }

  void setupValidations() {
    _disposers = [
      reaction((_) => name, validateName),
      reaction((_) => age, validateAge),
      reaction((_) => gender, validateGender),
    ];
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateName(name);
    validateAge(age);
    validateGender(gender);
  }

  String? submitData() {
    validateAll();

    String? result;

    if (canSubmit) {
      var random = Random().nextInt(1000);
      result = random.toString();
    }

    return result;
  }

  @action
  void clearAll() {
    name = '';
    age = '';
    gender = '';
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String? name;

  @observable
  String? age;

  @observable
  String? gender;

  @computed
  bool get hasErrors => name != null || age != null || gender != null;
}
