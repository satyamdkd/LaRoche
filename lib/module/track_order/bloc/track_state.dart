part of 'track_bloc.dart';

abstract class TrackState extends Equatable {
  const TrackState();
}

class TrackInitial extends TrackState {
  @override
  List<Object> get props => [];
}
