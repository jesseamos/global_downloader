import 'package:dartz/dartz.dart';
import 'package:spotify_downloader/core/errors/failures.dart';
import 'package:spotify_downloader/core/network/usecase.dart';
import 'package:spotify_downloader/features/spotify/data/models/song_reponse.dart';
import 'package:spotify_downloader/features/spotify/domain/repository/spotify_repository.dart';

class DownloadSongUsecase implements UseCase<SongResponse, String> {
  final SpotifyRepository spotifyRepository;
  const DownloadSongUsecase(this.spotifyRepository);
  @override
  Future<Either<Failure, SongResponse>> call(String params) async {
    return await spotifyRepository.downloadSong(song: params);
  }
}
