import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lyricify/model/song.dart';
import 'package:rxdart/rxdart.dart';

const jsonString =
    '{"name":"Sister","id":1914871808,"position":0,"alias":[],"status":0,"fee":8,"copyrightId":1416336,"disc":"01","no":1,"artists":[{"name":"Eve","id":1075075,"picId":0,"img1v1Id":0,"briefDesc":"","picUrl":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","img1v1Url":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","albumSize":0,"alias":[],"trans":"","musicSize":0,"topicPerson":0},{"name":"初音ミク","id":159692,"picId":0,"img1v1Id":0,"briefDesc":"","picUrl":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","img1v1Url":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","albumSize":0,"alias":[],"trans":"","musicSize":0,"topicPerson":0}],"album":{"name":"Eve Vocaloid 01","id":139397181,"type":"专辑","size":12,"picId":109951166977188651,"blurPicUrl":"http://p2.music.126.net/zo2GuoPjwhfBOuCCAhWRrw==/109951166977188651.jpg","companyId":0,"pic":109951166977188651,"picUrl":"http://p2.music.126.net/zo2GuoPjwhfBOuCCAhWRrw==/109951166977188651.jpg","publishTime":1644336000000,"description":"","tags":"","company":"TOY\'S FACTORY","briefDesc":"","artist":{"name":"","id":0,"picId":0,"img1v1Id":0,"briefDesc":"","picUrl":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","img1v1Url":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","albumSize":0,"alias":[],"trans":"","musicSize":0,"topicPerson":0},"songs":[],"alias":[],"status":1,"copyrightId":1416336,"commentThreadId":"R_AL_3_139397181","artists":[{"name":"Eve","id":1075075,"picId":0,"img1v1Id":0,"briefDesc":"","picUrl":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","img1v1Url":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","albumSize":0,"alias":[],"trans":"","musicSize":0,"topicPerson":0},{"name":"初音ミク","id":159692,"picId":0,"img1v1Id":0,"briefDesc":"","picUrl":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","img1v1Url":"http://p2.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg","albumSize":0,"alias":[],"trans":"","musicSize":0,"topicPerson":0}],"subType":"录音室版","transName":null,"onSale":false,"mark":0,"gapless":0,"dolbyMark":0,"picId_str":"109951166977188651"},"starred":false,"popularity":40.0,"score":40,"starredNum":0,"duration":243000,"playedNum":0,"dayPlays":0,"hearTime":0,"sqMusic":{"name":null,"id":7071587707,"size":33107403,"extension":"flac","sr":44100,"dfsId":0,"bitrate":1089955,"playTime":243000,"volumeDelta":-70807.0},"hrMusic":null,"ringtone":"","crbt":null,"audition":null,"copyFrom":"","commentThreadId":"R_SO_4_1914871808","rtUrl":null,"ftype":0,"rtUrls":[],"copyright":1,"transName":null,"sign":null,"mark":0,"originCoverType":0,"originSongSimpleData":null,"single":0,"noCopyrightRcmd":null,"rtype":0,"rurl":null,"mvid":0,"hMusic":{"name":null,"id":7071587708,"size":9722819,"extension":"mp3","sr":44100,"dfsId":0,"bitrate":320001,"playTime":243000,"volumeDelta":-70781.0},"mMusic":{"name":null,"id":7071587710,"size":5833709,"extension":"mp3","sr":44100,"dfsId":0,"bitrate":192002,"playTime":243000,"volumeDelta":-68222.0},"lMusic":{"name":null,"id":7071587712,"size":3889154,"extension":"mp3","sr":44100,"dfsId":0,"bitrate":128002,"playTime":243000,"volumeDelta":-66736.0},"bMusic":{"name":null,"id":7071587712,"size":3889154,"extension":"mp3","sr":44100,"dfsId":0,"bitrate":128002,"playTime":243000,"volumeDelta":-66736.0},"mp3Url":null}';

void main() {
  test('parse json', () {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    print(Song.fromJson(jsonMap));
  });

  test('subject', () {
    BehaviorSubject<int> subject = BehaviorSubject();
    subject.listen((value) {
      print(value);
    });
    subject.add(1);
  });
}
