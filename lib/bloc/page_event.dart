part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class GotoLandingPage extends PageEvent {}

class GotoSignUpPage extends PageEvent {}

class GotoSignInPage extends PageEvent {}

class GotoHomePage extends PageEvent {}

class GotoStudyPage extends PageEvent {}

class GotoAddFlashcardPage extends PageEvent {}
