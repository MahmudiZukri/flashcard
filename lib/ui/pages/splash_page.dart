part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 136,
                  decoration: BoxDecoration(color: Colors.black
                      // image: DecorationImage(
                      //     image: AssetImage("assets/logo.png")),
                      ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 70, bottom: 16),
                    child: Text(
                      "Flashcard",
                      style: blackTextFont.copyWith(fontSize: 20),
                    )),
                Text(
                  "Tergantung judul yang acc",
                  style: greyTextFont.copyWith(
                      fontWeight: FontWeight.w300, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 45,
                  width: 250,
                  margin: EdgeInsets.only(top: 70, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(0),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                    ),
                    onPressed: () {
                      BlocProvider.of<PageBloc>(context).add(GotoSignInPage());
                    },
                    child: Text(
                      "Get Started",
                      style: whiteTextFont.copyWith(fontSize: 16),
                    ),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Already have an account? ",
                      style: greyTextFont.copyWith(
                          fontWeight: FontWeight.w400, fontSize: 14)),
                  GestureDetector(
                      onTap: () {
                        // context.bloc<PageBloc>().add(GotoSignInPage());
                      },
                      child: Text(
                        "Sign In",
                        style: greyTextFont.copyWith(fontSize: 14),
                      ))
                ])
              ],
            )));
  }
}
