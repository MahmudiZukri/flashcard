import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flashcard/models/models.dart';
import 'package:flashcard/services/services.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState(const [])) {
    on<AddCard>((event, emit) async {
      await FlashcardServices.saveFlashcard(event.userID, event.card);

      List<CardModel> flashcards = state.cards + [event.card];

      emit(CardState(flashcards));
    });

    on<GetCard>((event, emit) async {
      List<CardModel> flashcards =
          await FlashcardServices.getFlashcard(event.userID);

      emit(CardState(flashcards));
    });

    on<ReviewCard>((event, emit) async {
      Sm2Response smResponse = Sm2.calc(
          quality: event.quality,
          repetitions: event.card.repetitions,
          previousInterval: event.card.intervals,
          previousEaseFactor: event.card.easeFactor);

      CardModel reviewedCard = event.card.copyWith(
          repetitions: smResponse.repetitions,
          intervals: smResponse.interval,
          easeFactor: smResponse.easeFactor,
          reviewedDate: DateTime.now());

      await FlashcardServices.saveFlashcard(event.userID, reviewedCard);

      List<CardModel> flashcards = state.cards + [reviewedCard];

      emit(CardState(flashcards));
    });
  }
}
