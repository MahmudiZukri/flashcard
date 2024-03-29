part of 'pages.dart';

// ignore: must_be_immutable
class LandingPage extends StatefulWidget {
  LandingPage({Key? key, this.languageIND = true}) : super(key: key);
  bool languageIND;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: WebsafeSvg.asset("assets/bg.svg", fit: BoxFit.fill)),
          Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 46),
                Align(
                  alignment: Alignment.centerRight,
                  child: ChooseLanguage(),
                ),
                SizedBox(height: 54.0),
                Text("Al-Qur'an Flashcard",
                    textAlign: TextAlign.center,
                    style: tealTextFont.copyWith(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = textGradient)),
                Spacer(),
                Text(
                  "Penerapan Spaced Repetition dengan Menggunakan Algoritma SuperMemo 2 dalam Penghafalan Ayat Al-Qur'an",
                  style: whiteTextFont.copyWith(
                      letterSpacing: 1.8, wordSpacing: 5.2),
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 2),
                GestureDetector(
                    onTap: () {
                      context.read<PageBloc>().add(GotoSignUpPage());
                    },
                    child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(edge * 0.75),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          gradient: primaryGradient,
                        ),
                        child: Text('landingButton',
                                style: blackTextFont.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87))
                            .tr())),
                SizedBox(height: 11.0),
                GestureDetector(
                    onTap: () async {
                      SignInSignUpResult result =
                          await AuthServices.googleLogin();

                      if (result.user == null) {
                        final snackBar = SnackBar(
                            backgroundColor: Colors.red[400],
                            duration: Duration(milliseconds: 1500),
                            content: Row(
                              children: [
                                Icon(Icons.dangerous, color: whiteColor),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(result.message!,
                                      maxLines: 2,
                                      style: whiteTextFont.copyWith(
                                        fontSize: 14,
                                      )),
                                )
                              ],
                            ));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(edge * 0.75),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Color(0xFFDD4B39),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.google),
                            SizedBox(width: 10.0),
                            Text('signInGoogle',
                                    style: blackTextFont.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor))
                                .tr()
                          ],
                        ))),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('askToSignIn',
                          style: whiteTextFont.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white54))
                      .tr(),
                  GestureDetector(
                      onTap: () {
                        context.read<PageBloc>().add(GotoSignInPage());
                      },
                      child: Text(
                        "Sign In",
                        style: tealTextFont.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ))
                ]),
                SizedBox(height: 60)
              ],
            ),
          )
        ],
      ),
    );
  }
}
