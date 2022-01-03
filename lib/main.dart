import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashcard/bloc/bloc.dart';
import 'package:flashcard/bloc/user_bloc.dart';
import 'package:flashcard/services/services.dart';
import 'package:flashcard/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PageBloc>(create: (_) => PageBloc()),
          BlocProvider<UserBloc>(create: (_) => UserBloc()),
          BlocProvider<CardBloc>(create: (_) => CardBloc()),
        ],
        child: StreamBuilder(
            stream: AuthServices.userStream,
            initialData: FirebaseAuth.instance.currentUser,
            builder: (context, AsyncSnapshot<User?> snapshot) {
              User? user = snapshot.data;
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flashcard',
                  theme: ThemeData(
                      brightness: Brightness.dark,
                      textTheme: GoogleFonts.poppinsTextTheme()),
                  home: Wrapper(
                    user: user,
                  ));
            }));
  }
}
