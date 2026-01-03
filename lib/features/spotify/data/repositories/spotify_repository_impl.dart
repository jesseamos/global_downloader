import 'package:dartz/dartz.dart';
import 'package:spotify_downloader/core/errors/exceptions.dart';
import 'package:spotify_downloader/core/errors/failures.dart';
import 'package:spotify_downloader/core/network/connection_checker.dart';
import 'package:spotify_downloader/core/utils/constants.dart';
import 'package:spotify_downloader/features/spotify/data/datasources/spotify_remote_datasources.dart';
import 'package:spotify_downloader/features/spotify/data/models/song_reponse.dart';
import 'package:spotify_downloader/features/spotify/domain/repository/spotify_repository.dart';

class SpotifyRepositoryImpl implements SpotifyRepository {
  final ConnectionChecker connectionChecker;
  final SpotifyRemoteDatasources datasources;
  const SpotifyRepositoryImpl(this.connectionChecker, this.datasources);
  @override
  Future<Either<Failure, SongResponse>> downloadSong({
    required String song,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMessage));
      }
      final response = await datasources.downloadSong(song: song);

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
