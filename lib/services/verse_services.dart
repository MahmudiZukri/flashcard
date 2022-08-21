part of 'services.dart';

class VerseServices {
  static Future<Verse> getVerse(int chapterNum, int verseNum,
      {http.Client? client}) async {
    var url = 'http://api.alquran.cloud/v1/ayah/$chapterNum:$verseNum';

    client ??= http.Client();

    var response = await client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      return Verse('Not Found', 0, 0, 'Not Found');
    }
    Map<String, dynamic> jsonResponse = json.decode(response.body);

    //sekarang kita ambil 4 variabel yang kita butuhkan
    Map<String, dynamic> data = jsonResponse['data'];
    String verseText = data['text'];
    int verseNumber = data['numberInSurah'];

    Map<String, dynamic> surah = data['surah'];
    String chapterName = surah['englishName'];
    int chapterNumber = surah['number'];

    return Verse(chapterName, chapterNumber, verseNumber, verseText);
  }
}
