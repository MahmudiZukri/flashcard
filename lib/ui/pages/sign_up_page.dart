part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isSigningUp = false;
  // bool _isEmailValid = false;
  // bool _isPasswordValid = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PageBloc>(context).add(GotoSplashPage());
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: WebsafeSvg.asset("assets/bg.svg", fit: BoxFit.fill)),
            SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.symmetric(horizontal: edge),
                child: Stack(
                  children: [
                    SafeArea(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 16,
                        margin: EdgeInsets.only(top: edge),
                        decoration: BoxDecoration(
                          gradient: primaryGradient,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                            iconSize: 22.0,
                            onPressed: () {
                              context.read<PageBloc>().add(GotoSignInPage());
                            },
                            icon:
                                Icon(Icons.chevron_left, color: primaryColor)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 120),
                        Text("Sign Up",
                            style: tealTextFont.copyWith(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = textGradient)),
                        Text(
                          "Enter your information below",
                          style: whiteTextFont,
                        ),
                        SizedBox(height: 40),
                        TextField(
                          controller: _nameController,
                          style: whiteTextFont,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: "Full Name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _emailController,
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
                          style: whiteTextFont,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _confirmPasswordController,
                          style: whiteTextFont,
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: "Confirm Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: _isSigningUp
                              ? null
                              : () async {
                                  if (!(_nameController.text.trim() != '' &&
                                      _emailController.text.trim() != '' &&
                                      _passwordController.text.trim() != '' &&
                                      _confirmPasswordController.text.trim() !=
                                          '')) {
                                    final snackBar = SnackBar(
                                        backgroundColor: Colors.red[400],
                                        duration: Duration(milliseconds: 1500),
                                        content: Row(
                                          children: [
                                            Icon(Icons.dangerous,
                                                color: whiteColor),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                  'Please fill all the fields !',
                                                  maxLines: 2,
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    final snackBar = SnackBar(
                                        backgroundColor: Colors.red[400],
                                        duration: Duration(milliseconds: 1500),
                                        content: Row(
                                          children: [
                                            Icon(Icons.dangerous,
                                                color: whiteColor),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                  'Mismatch password and confirmed password !',
                                                  maxLines: 2,
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (_passwordController.text.length <
                                      6) {
                                    final snackBar = SnackBar(
                                        backgroundColor: Colors.red[400],
                                        duration: Duration(milliseconds: 1500),
                                        content: Row(
                                          children: [
                                            Icon(Icons.dangerous,
                                                color: whiteColor),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                  "Password's length min 6 character !",
                                                  maxLines: 2,
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (!EmailValidator.validate(
                                      _emailController.text)) {
                                    final snackBar = SnackBar(
                                        backgroundColor: Colors.red[400],
                                        duration: Duration(milliseconds: 1500),
                                        content: Row(
                                          children: [
                                            Icon(Icons.dangerous,
                                                color: whiteColor),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                  'Wrong formatted email address !',
                                                  maxLines: 2,
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            )
                                          ],
                                        ));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else {
                                    setState(() {
                                      _isSigningUp = true;
                                    });
                                    SignInSignUpResult result =
                                        await AuthServices.signUp(
                                            _emailController.text,
                                            _passwordController.text,
                                            _nameController.text);

                                    if (result.user == null) {
                                      setState(() {
                                        _isSigningUp = false;
                                      });

                                      final snackBar = SnackBar(
                                          backgroundColor: Colors.red[400],
                                          duration:
                                              Duration(milliseconds: 1500),
                                          content: Row(
                                            children: [
                                              Icon(Icons.dangerous,
                                                  color: whiteColor),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(result.message!,
                                                    maxLines: 2,
                                                    style:
                                                        whiteTextFont.copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              )
                                            ],
                                          ));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                    // _nameController.text = '';
                                    // _emailController.text = '';
                                    // _passwordController.text = '';
                                    // _confirmPasswordController.text = '';
                                  }

                                  //kita bikin showDialog nanti untuk konfirmasi YES / NO
                                },
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(edge * 0.75),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                gradient: primaryGradient,
                              ),
                              child: Text("Create Account",
                                  style: blackTextFont.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87))),
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already Have an Account? ",
                                  style: whiteTextFont.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.white60)),
                              GestureDetector(
                                  onTap: () {
                                    _nameController.text = '';
                                    _emailController.text = '';
                                    _passwordController.text = '';
                                    _confirmPasswordController.text = '';
                                    context
                                        .read<PageBloc>()
                                        .add(GotoSignInPage());
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
