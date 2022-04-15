part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomBar(title: 'homeTitle'.tr()),
          preferredSize: Size.fromHeight(50.0)),
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: WebsafeSvg.asset("assets/bg.svg", fit: BoxFit.fill)),
          SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: edge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 2.0, width: double.infinity, color: primaryColor),
                  SizedBox(height: 16),
                  Align(
                      alignment: Alignment.centerRight,
                      child: ChooseLanguage()),
                  SizedBox(height: MediaQuery.of(context).size.height / 5.6),
                  Container(
                    height: 45,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      onPressed: () {
                        BlocProvider.of<PageBloc>(context).add(GotoStudyPage());
                      },
                      child: Text(
                        "startStudy",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ).tr(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 45,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      onPressed: () {
                        BlocProvider.of<PageBloc>(context)
                            .add(GotoAddFlashcardPage());
                      },
                      child: Text(
                        "addCard",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ).tr(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 45,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                      ),
                      onPressed: () {
                        AuthServices.signOut();
                        BlocProvider.of<UserBloc>(context).add(SignOut());
                      },
                      child: Text(
                        "signOut".tr(),
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
