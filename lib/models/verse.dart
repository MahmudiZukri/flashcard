part of 'models.dart';

class Verse extends Equatable {
  final String chapterName;
  final int chapterNumber;
  final int verseNumber;
  final String verseText;

  const Verse(
      this.chapterName, this.chapterNumber, this.verseNumber, this.verseText);

  @override
  List<Object?> get props =>
      [chapterName, chapterNumber, verseNumber, verseText];
}
