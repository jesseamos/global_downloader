part of 'sportify_cubit.dart';

sealed class SportifyState extends Equatable {
  const SportifyState();

  @override
  List<Object> get props => [];
}

final class SportifyInitial extends SportifyState {}

final class SportifySuccess extends SportifyState {
  final SongResponse data;
  const SportifySuccess(this.data);
  @override
  List<Object> get props => [data];
}

final class SportifyFailure extends SportifyState {
  final String message;
  const SportifyFailure(this.message);
  @override
  List<Object> get props => [message];
}

final class SportifyLoading extends SportifyState {}
