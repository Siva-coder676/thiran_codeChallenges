import 'package:equatable/equatable.dart';
import 'package:thiran_task/models/repository.dart';


abstract class RepoState extends Equatable {
  const RepoState();

  @override
  List<Object> get props => [];
}

class RepoLoading extends RepoState {}

class RepoLoaded extends RepoState {
  final List<Repository> repos;

  const RepoLoaded(this.repos);

  @override
  List<Object> get props => [repos];
}

class RepoError extends RepoState {
  final String message;

  const RepoError(this.message);

  @override
  List<Object> get props => [message];
}
