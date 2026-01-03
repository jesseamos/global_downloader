import 'package:dartz/dartz.dart';
import 'package:spotify_downloader/core/errors/failures.dart';
import 'package:spotify_downloader/features/spotify/data/models/song_reponse.dart';

abstract class SpotifyRepository {
  Future<Either<Failure, SongResponse>> downloadSong({required String song});
}
