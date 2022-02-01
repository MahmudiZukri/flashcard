part of 'pages.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 45,
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              context.setLocale('id'.toLocale());
                            },
                            child: Text(
                              'INDONESIA',
                            )),
                      ),
                      SizedBox(
                        height: 45,
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              context.setLocale('en_US'.toLocale());
                            },
                            child: Text(
                              'ENGLISH',
                            )),
                      ),
                    ]),
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
