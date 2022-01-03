part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomBar(title: 'HOME'),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 4),
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
                        "Start Study",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
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
                        "Add Card",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
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
                      onPressed: () async {
                        await AuthServices.signOut();
                        BlocProvider.of<UserBloc>(context).add(SignOut());
                      },
                      child: Text(
                        "Sign Out",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
