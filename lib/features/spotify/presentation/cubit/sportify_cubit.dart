import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotify_downloader/features/spotify/data/models/song_reponse.dart';
import 'package:spotify_downloader/features/spotify/domain/usecases/download_song_usecase.dart';

part 'sportify_state.dart';

class SportifyCubit extends Cubit<SportifyState> {
  final DownloadSongUsecase downloadSongUsecase;
  SportifyCubit({required this.downloadSongUsecase}) : super(SportifyInitial());

  Future<void> downloadSong({required String songId}) async {
    emit(SportifyLoading());
    final response = await downloadSongUsecase.call(songId);
    response.fold(
      (f) => emit(SportifyFailure(f.message)),
      (response) => emit(SportifySuccess(response)),
    );
  }
}
