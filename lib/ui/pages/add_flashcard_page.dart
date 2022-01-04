part of 'pages.dart';

class AddFlashcardPage extends StatefulWidget {
  const AddFlashcardPage({Key? key}) : super(key: key);

  @override
  State<AddFlashcardPage> createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends State<AddFlashcardPage> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  bool addingFlashcard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomBar(title: 'ADD CARD'),
          preferredSize: Size.fromHeight(50.0)),
      drawer: Drawer(
          backgroundColor: accentColor,
          child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            FlashcardUser? user = userState is! UserInitial
                ? (userState as UserLoaded).user
                : null;

            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama Pengguna :',
                              style: whiteTextFont.copyWith(fontSize: 16)),
                          Flexible(
                            child: Text(user?.name ?? 'No Name',
                                maxLines: 2,
                                style: whiteTextFont.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(height: 30),
                          Container(
                              height: 2.0,
                              width: double.infinity,
                              color: primaryColor),
                          SizedBox(height: 30),
                          CustomText(
                              onTap: () {
                                BlocProvider.of<PageBloc>(context)
                                    .add(GotoHomePage());
                              },
                              icon: Icons.home_outlined,
                              text: 'Home'),
                          CustomText(
                              onTap: () {
                                BlocProvider.of<PageBloc>(context)
                                    .add(GotoStudyPage());
                              },
                              icon: Icons.book_outlined,
                              text: 'Study'),
                        ],
                      )),
                    ),
                    CustomText(
                        onTap: () async {
                          await AuthServices.signOut();
                          BlocProvider.of<UserBloc>(context).add(SignOut());
                        },
                        icon: Icons.logout,
                        text: 'Sign Out')
                  ],
                ),
              ),
            );
          })),
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
                  SizedBox(height: 30.0),
                  TextField(
                    controller: _questionController,
                    style: whiteTextFont,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: accentColor,
                        labelText: "Question",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _answerController,
                    style: whiteTextFont,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: accentColor,
                        labelText: "Answer",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                  ),
                  SizedBox(height: 30.0),
                  BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                    FlashcardUser? user = userState is! UserInitial
                        ? (userState as UserLoaded).user
                        : null;

                    return Container(
                      height: 45,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(0),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                        ),
                        onPressed: !addingFlashcard
                            ? () {
                                addingFlashcard = true;
                                BlocProvider.of<CardBloc>(context).add(AddCard(
                                    user?.id ?? '',
                                    CardModel(
                                        question:
                                            _questionController.text.trim(),
                                        answer:
                                            _answerController.text.trim())));
                                _questionController.text = '';
                                _answerController.text = '';
                                final snackBar = SnackBar(
                                    backgroundColor: Colors.green[400],
                                    duration: Duration(milliseconds: 1500),
                                    content: Row(
                                      children: [
                                        Icon(Icons.check_box,
                                            color: whiteColor),
                                        SizedBox(width: 8),
                                        Text('Flashcard added successfully!',
                                            style: whiteTextFont.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                addingFlashcard = false;
                              }
                            : null,
                        child: Text(
                          "Add Card",
                          style: whiteTextFont.copyWith(fontSize: 16),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
