part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoggedIn extends UserState {
  final UserModel user;
  UserLoggedIn(this.user);
}

class UserProfileUpdated extends UserState {
  final UserModel updatedUser;
  UserProfileUpdated(this.updatedUser);
}

class UserLoggedOut extends UserState {}

class UserLoginRequired extends UserState {}

class UserError extends UserState {
  final String message;
  UserError(this.message);
}
