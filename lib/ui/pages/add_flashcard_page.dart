part of 'pages.dart';

class AddFlashcardPage extends StatefulWidget {
  const AddFlashcardPage({Key? key}) : super(key: key);

  @override
  State<AddFlashcardPage> createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends State<AddFlashcardPage> {
  Verse? verse;
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _chapterNumberController =
      TextEditingController();
  final TextEditingController _verseNumberController = TextEditingController();

  bool addingFlashcard = false;
  bool verseExist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
          child: CustomBar(title: 'addCardTitle'.tr(), actions: [
            IconButton(
                icon: Icon(Icons.book_outlined),
                color: Colors.white,
                onPressed: () {
                  BlocProvider.of<PageBloc>(context).add(GotoStudyPage());
                }),
            SizedBox(width: 4)
          ]),
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
                          Text('userName',
                                  style: whiteTextFont.copyWith(fontSize: 16))
                              .tr(),
                          SizedBox(height: 10),
                          Flexible(
                            child: Text(user?.name ?? 'noName'.tr(),
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
                              text: 'home'.tr()),
                          CustomText(
                              onTap: () {
                                BlocProvider.of<PageBloc>(context)
                                    .add(GotoStudyPage());
                              },
                              icon: Icons.book_outlined,
                              text: 'study'.tr()),
                        ],
                      )),
                    ),
                    CustomText(
                        onTap: () async {
                          await AuthServices.signOut();
                          BlocProvider.of<UserBloc>(context).add(SignOut());
                        },
                        icon: Icons.logout,
                        text: 'signOut'.tr())
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
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                      height: 2.0, width: double.infinity, color: primaryColor),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:
                            ((MediaQuery.of(context).size.width / 2) - edge) -
                                10,
                        child: TextField(
                          controller: _chapterNumberController,
                          style: whiteTextFont,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: "chapterNumber".tr(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      SizedBox(
                        width:
                            ((MediaQuery.of(context).size.width / 2) - edge) -
                                10,
                        child: TextField(
                          controller: _verseNumberController,
                          style: whiteTextFont,
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: accentColor,
                              labelText: "verseNumber".tr(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0))),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.0),
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
                      onPressed: (_chapterNumberController.text.trim() != '' &&
                              _verseNumberController.text.trim() != '')
                          ? () async {
                              verse = await VerseServices.getVerse(
                                  int.parse(
                                      _chapterNumberController.text.trim()),
                                  int.parse(
                                      _verseNumberController.text.trim()));

                              if (verse?.chapterNumber != 0 ||
                                  verse?.verseNumber != 0 ||
                                  verse == null) {
                                verseExist = true;
                              } else {
                                verseExist = false;
                              }
                              if (verseExist) {
                                _questionController.text =
                                    // 'What is the content of Surah ${verse!.chapterName} [ ${verse!.chapterNumber} : ${verse!.verseNumber} ]  ?';
                                    'questionFlashcard'.tr(namedArgs: {
                                  'chapterName': verse!.chapterName,
                                  'chapterNumber':
                                      verse!.chapterNumber.toString(),
                                  'verseNumber': verse!.verseNumber.toString()
                                });
                                _answerController.text = verse!.verseText;
                              } else {
                                _questionController.text = 'notFound'.tr();
                                _answerController.text = 'notFound'.tr();
                              }

                              setState(() {});
                            }
                          : null,
                      child: Text(
                        "showCard",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ).tr(),
                    ),
                  ),
                  SizedBox(height: 28.0),
                  TextField(
                    controller: _questionController,
                    style: whiteTextFont,
                    maxLines: null,
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: accentColor,
                        labelText: "question".tr(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _answerController,
                    style: verseExist
                        ? whiteTextFont.copyWith(fontSize: 20)
                        : whiteTextFont,
                    maxLines: null,
                    readOnly: true,
                    textDirection:
                        verseExist ? TextDirection.rtl : TextDirection.ltr,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: accentColor,
                        labelText: "answer".tr(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0))),
                  ),
                  SizedBox(height: 28),
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
                        onPressed: !addingFlashcard && verseExist
                            ? () {
                                addingFlashcard = true;
                                BlocProvider.of<CardBloc>(context).add(AddCard(
                                    user?.id ?? '',
                                    CardModel(
                                        question:
                                            _questionController.text.trim(),
                                        answer: _answerController.text.trim(),
                                        reviewedDate: DateTime.now())));
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
                                        Text('successAdded',
                                            style: whiteTextFont.copyWith(
                                              fontSize: 14,
                                            )).tr()
                                      ],
                                    ));

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                addingFlashcard = false;
                              }
                            : null,
                        child: Text(
                          "addCard",
                          style: whiteTextFont.copyWith(fontSize: 16),
                        ).tr(),
                      ),
                    );
                  }),
                  SizedBox(height: 30.0)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
