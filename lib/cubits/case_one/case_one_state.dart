import 'package:equatable/equatable.dart';

class EmailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmailInitialState extends EmailState {}

class EmailLoadingState extends EmailState {}

class EmailSuccessState extends EmailState {}

class EmailErrorState extends EmailState {}