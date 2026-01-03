class SongResponse {
  final bool success;
  final SongData data;
  final int generatedTimeStamp;

  SongResponse({
    required this.success,
    required this.data,
    required this.generatedTimeStamp,
  });

  factory SongResponse.fromJson(Map<String, dynamic> json) {
    return SongResponse(
      success: json['success'] as bool,
      data: SongData.fromJson(json['data']),
      generatedTimeStamp: json['generatedTimeStamp'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'generatedTimeStamp': generatedTimeStamp,
    };
  }
}

class SongData {
  final String id;
  final String artist;
  final String title;
  final String album;
  final String cover;
  final String releaseDate;
  final String downloadLink;

  SongData({
    required this.id,
    required this.artist,
    required this.title,
    required this.album,
    required this.cover,
    required this.releaseDate,
    required this.downloadLink,
  });

  factory SongData.fromJson(Map<String, dynamic> json) {
    return SongData(
      id: json['id'] as String,
      artist: json['artist'] as String,
      title: json['title'] as String,
      album: json['album'] as String,
      cover: json['cover'] as String,
      releaseDate: json['releaseDate'] as String,
      downloadLink: json['downloadLink'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artist': artist,
      'title': title,
      'album': album,
      'cover': cover,
      'releaseDate': releaseDate,
      'downloadLink': downloadLink,
    };
  }
}
