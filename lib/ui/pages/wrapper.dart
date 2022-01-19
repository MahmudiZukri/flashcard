part of 'pages.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key, required this.user}) : super(key: key);

  final auth.User? user;

  @override
  Widget build(BuildContext context) {
    // User user = Provider.of<User>(context);
    // auth.FirebaseAuth.instance.authStateChanges().listen((auth.User? user) {
    if (user == null) {
      if (prevPageEvent is! GotoSplashPage) {
        prevPageEvent = GotoSplashPage();
        BlocProvider.of<PageBloc>(context).add(prevPageEvent!);
      }
    } else {
      if (prevPageEvent is! GotoHomePage) {
        BlocProvider.of<UserBloc>(context).add(LoadUser(user!.uid));
        BlocProvider.of<CardBloc>(context).add(GetCard(user!.uid));

        prevPageEvent = GotoHomePage();
        // context.read()<PageBloc>().add(prevPageEvent);
        BlocProvider.of<PageBloc>(context).add(prevPageEvent!);
      }
    }
    // });

    return BlocBuilder<PageBloc, PageState>(builder: (_, pageState) {
      if (pageState is OnSplashPage) {
        return SplashPage();
      } else if (pageState is OnSignUpPage) {
        return SignUpPage();
      } else if (pageState is OnSignInPage) {
        return SignInPage();
      } else if (pageState is OnHomePage) {
        return HomePage();
      } else if (pageState is OnStudyPage) {
        return StudyPage();
      } else if (pageState is OnAddFlashcardPage) {
        return AddFlashcardPage();
      } else {
        return (user == null) ? LoadingPage() : HomePage();
      }
    });
  }
}
