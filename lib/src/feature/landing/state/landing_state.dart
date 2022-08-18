// ignore_for_file: sort_constructors_first

abstract class LandingState {}

class ValidateVersion extends LandingState {}

class OutdatedVersion extends LandingState {}

class ValidateAccount extends LandingState {}

class NoConnection extends LandingState {}
