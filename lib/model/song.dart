import 'package:equatable/equatable.dart';

// http://music.163.com/api/song/lyric?id=1914871808&lv=-1&tv=-1
// http://music.163.com/api/song/detail?ids=[1914871808]

class Song with EquatableMixin {
  final int id;
  final String name;
  final List<Artist> artists;
  final Album album;

  const Song({
    required this.id,
    required this.name,
    required this.artists,
    required this.album,
  });

  Song.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        artists = List<Artist>.from(
            json['artists'].map((artistJson) => Artist.fromJson(artistJson))),
        album = Album.fromJson(json['album']);

  @override
  get props => [id, name, artists, album];
}

class Artist with EquatableMixin {
  final int id;
  final String name;
  final String pictureUrl;

  const Artist({
    required this.id,
    required this.name,
    required this.pictureUrl,
  });

  Artist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        pictureUrl = json['picUrl'];

  @override
  get props => [id, name, pictureUrl];
}

class Album with EquatableMixin {
  final int id;
  final String name;
  final String pictureUrl;

  const Album({
    required this.id,
    required this.name,
    required this.pictureUrl,
  });

  Album.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        pictureUrl = json['picUrl'];

  @override
  get props => [id, name, pictureUrl];
}
