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
                SizedBox(height: 100),
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
                Spacer(),
                // SizedBox(
                //   width: 100.0,
                //   child: Transform.scale(
                //     scale: 2.0,
                //     child: Switch(
                //         trackColor: MaterialStateProperty.all(tealColor),
                //         activeThumbImage: AssetImage('assets/indonesia.png'),
                //         inactiveThumbImage:
                //             AssetImage('assets/united-states.png'),
                //         value: widget.languageIND,
                //         onChanged: (value) {
                //           setState(() {
                //             widget.languageIND = value;
                //             widget.languageIND
                //                 ? context.setLocale('id'.toLocale())
                //                 : context.setLocale('en_US'.toLocale());
                //           });
                //         }),
                //   ),
                // ),
                Text('chooseLang',
                        style: whiteTextFont.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white54))
                    .tr(),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        iconSize: 44.0,
                        onPressed: () {
                          context.setLocale('en_US'.toLocale());
                        },
                        icon: Image.asset('assets/united-states.png')),
                    SizedBox(width: 10.0),
                    IconButton(
                        iconSize: 44.0,
                        onPressed: () {
                          context.setLocale('id'.toLocale());
                        },
                        icon: Image.asset('assets/indonesia.png')),
                  ],
                ),

                Spacer(),
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
                            color: Colors.grey),
                        child: Text('landingButton',
                                style: blackTextFont.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87))
                            .tr())),
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
