import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/errors/exceptions.dart';
import 'package:spotify_downloader/core/errors/remote_error_handler.dart';
import 'package:spotify_downloader/core/network/dio_client.dart';
import 'package:spotify_downloader/core/utils/endpoints.dart';
import 'package:spotify_downloader/features/spotify/data/models/song_reponse.dart';

abstract class SpotifyRemoteDatasources {
  Future<SongResponse> downloadSong({required String song});
}

class SpotifyRemoteDatasourcesImpl implements SpotifyRemoteDatasources {
  final DioClient dioClient;
  const SpotifyRemoteDatasourcesImpl(this.dioClient);
  @override
  Future<SongResponse> downloadSong({required String song}) async {
    try {
      print('Test ${song}');
      final response = await dioClient.get(
        Endpoints.downloadSong,
        queryParameters: {"songId": song},
        options: Options(
          headers: {
            'x-rapidapi-host': 'spotify-downloader9.p.rapidapi.com',
            'x-rapidapi-key':
                ' e5067dc6bamsh8d2b7c842fd530dp103b7ejsn4542ff994181',
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        if (data == null) {
          throw const ServerException('Response is null!');
        }
        return SongResponse.fromJson(data);
      } else if ((response.statusCode ?? 0) >= 400) {
        throw ServerException('${response.data['message']}');
      } else {
        throw ServerException('${response.data['message']}');
      }
    } on DioException catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw handleError(e);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      throw ServerException(e.toString());
    }
  }
}
