part of 'pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

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
                SizedBox(height: 120),
                Text("Al-Qur'an Flashcard",
                    // textAlign: TextAlign.center,
                    style: tealTextFont.copyWith(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = textGradient)),
                SizedBox(height: 80),
                Text(
                  "Penerapan Spaced Repetition dengan Menggunakan Algoritma SuperMemo 2 dalam Penghafalan Ayat Al-Qur'an",
                  style: whiteTextFont.copyWith(letterSpacing: 2.0),
                  textAlign: TextAlign.center,
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
                        child: Text("Get Started",
                            style: blackTextFont.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87)))),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Already Have an Account? ",
                      style: whiteTextFont.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white60)),
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
