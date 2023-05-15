import '../profile_model.dart';

abstract class ProfileStates {}

class ProfileInitialStates extends ProfileStates {}

class ProfileLoadingUserDataState extends ProfileStates{}

class ProfileSuccessUserDataState extends ProfileStates{

  final ProfileModel profileModel;

  ProfileSuccessUserDataState(this.profileModel);
}

class ProfileUserDataErrorState extends ProfileStates {}

class ProfileUpdateLoadingState extends ProfileStates{}

class ProfileUpdateSuccessState extends ProfileStates{

  final ProfileModel profileModel;

  ProfileUpdateSuccessState(this.profileModel);
}

class ProfileUpdateErrorState extends ProfileStates {}

class ProfilePickedSuccessState extends ProfileStates {}
class ProfilePickedErrorState extends ProfileStates {}