part of 'pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static final TextEditingController _emailController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();

  bool isSigningIn = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = '';
    _passwordController.text = '';
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Text("Sign In",
                    style: tealTextFont.copyWith(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()..shader = textGradient)),
                SizedBox(height: 4),
                Text(
                  "Login to start memorizing verses of Al-Qur'an",
                  style: whiteTextFont.copyWith(color: Colors.white70),
                ),
                Spacer(),
                TextField(
                  controller: _emailController,
                  onChanged: (text) {
                    setState(() {
                      isEmailValid = EmailValidator.validate(text);
                    });
                  },
                  style: whiteTextFont,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: accentColor,
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  onChanged: (text) {
                    setState(() {
                      isPasswordValid = text.length >= 6;
                    });
                  },
                  style: whiteTextFont,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: accentColor,
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                ),
                Spacer(flex: 2),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isSigningIn = true;
                    });
                    SignInSignUpResult result = await AuthServices.signIn(
                        _emailController.text, _passwordController.text);

                    if (result.user == null) {
                      setState(() {
                        isSigningIn = false;
                      });
                      // ignore: avoid_print
                      print(result.message);

                      final snackBar = SnackBar(
                          backgroundColor: Colors.red[400],
                          duration: Duration(milliseconds: 1500),
                          content: Row(
                            children: [
                              Icon(Icons.dangerous, color: whiteColor),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                    (_emailController.text.trim() == '' ||
                                            _passwordController.text.trim() ==
                                                '')
                                        ? 'Please fill all the fields !'
                                        : result.message!,
                                    maxLines: 2,
                                    style: whiteTextFont.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ));

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: isSigningIn == false
                      ? Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(edge * 0.75),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            gradient: primaryGradient,
                            color: !isEmailValid && !isEmailValid
                                ? Colors.grey
                                : null,
                          ),
                          child: Text("Login",
                              style: blackTextFont.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)))
                      : Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator()),
                ),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Start fresh now? ",
                      style: whiteTextFont.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white54)),
                  GestureDetector(
                      onTap: () {
                        _emailController.text = '';
                        _passwordController.text = '';
                        context.read<PageBloc>().add(GotoSignUpPage());
                      },
                      child: Text(
                        "Sign Up",
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
