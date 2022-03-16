part of 'pages.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  FlipCardController cardController = FlipCardController();
  int selectedCard = 0;
  int index = 0;
  bool flashcardExist = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
      FlashcardUser? user =
          userState is! UserInitial ? (userState as UserLoaded).user : null;

      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
              child: CustomBar(title: 'studyTitle'.tr(), actions: [
                IconButton(
                    icon: Icon(Icons.add_box_outlined),
                    color: Colors.white,
                    onPressed: () {
                      BlocProvider.of<PageBloc>(context)
                          .add(GotoAddFlashcardPage());
                    }),
                SizedBox(width: 4)
              ]),
              preferredSize: Size.fromHeight(50.0)),
          drawer: Drawer(
              backgroundColor: accentColor,
              child: SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
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
                                      .add(GotoAddFlashcardPage());
                                },
                                icon: Icons.add_box_outlined,
                                text: 'addCard'.tr()),
                            Container(
                                height: 2.0,
                                width: double.infinity,
                                color: primaryColor),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Text('chooseLang',
                                        style: whiteTextFont.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.white54))
                                    .tr(),
                                Spacer(),
                                ChooseLanguage(
                                  heightCard: 40.0,
                                  widthCard: 80.0,
                                )
                              ],
                            ),
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
              )),
          body: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: WebsafeSvg.asset("assets/bg.svg", fit: BoxFit.fill)),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: edge),
                  child: user == null
                      ? SizedBox()
                      : StreamBuilder<List<CardModel>>(
                          stream: FlashcardServices.getStreamFlashcard(user.id),
                          builder: (_, snapshot) {
                            List<CardModel>? notFilteredCards;
                            List<CardModel>? cards;

                            (snapshot.data == null || snapshot.data!.isEmpty)
                                ? flashcardExist = false
                                : flashcardExist = true;

                            notFilteredCards = snapshot.data;

                            int daysBetween(DateTime from, DateTime to) {
                              from = DateTime(from.year, from.month, from.day);
                              to = DateTime(to.year, to.month, to.day);

                              return ((to.difference(from).inHours / 24))
                                  .round();
                            }

                            if (flashcardExist) {
                              DateTime dateRightNow = DateTime.now();
                              cards = (notFilteredCards!.where((card) =>
                                  daysBetween(
                                      card.reviewedDate, dateRightNow) >=
                                  card.intervals)).toList();
                            }

                            return SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 2.0,
                                      width: double.infinity,
                                      color: primaryColor),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              24),
                                  Expanded(
                                    child: flashcardExist
                                        ? (selectedCard < cards!.length)
                                            ? CustomCard(
                                                cardModel: cards[selectedCard],
                                                controller: cardController)
                                            : CustomContainer(
                                                child: Center(
                                                    child: Text(
                                                  'doneToday',
                                                  textAlign: TextAlign.center,
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 14),
                                                ).tr()),
                                                color: Colors.black54)
                                        : (snapshot.connectionState ==
                                                ConnectionState.waiting)
                                            ? CustomContainer(
                                                child: Center(
                                                    child: Text(
                                                  "Loading Flashcard...",
                                                  textAlign: TextAlign.center,
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 14),
                                                )),
                                                color: Colors.black54)
                                            : CustomContainer(
                                                child: Center(
                                                    child: Text(
                                                  "emptyFlashcard",
                                                  textAlign: TextAlign.center,
                                                  style: whiteTextFont.copyWith(
                                                      fontSize: 14),
                                                ).tr()),
                                                color: Colors.black54),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              36),
                                  BlocBuilder<UserBloc, UserState>(
                                    builder: (_, userState) {
                                      userState is! UserInitial
                                          ? (userState as UserLoaded).user
                                          : null;

                                      return (flashcardExist == true &&
                                              selectedCard < cards!.length &&
                                              snapshot.connectionState !=
                                                  ConnectionState.waiting)
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                customButton(
                                                    '0',
                                                    0,
                                                    redGradient,
                                                    cards[index],
                                                    cards.length,
                                                    user.id,
                                                    false),
                                                customButton(
                                                    '1',
                                                    1,
                                                    redGradient,
                                                    cards[index],
                                                    cards.length,
                                                    user.id,
                                                    false),
                                                customButton(
                                                    '2',
                                                    2,
                                                    redGradient,
                                                    cards[index],
                                                    cards.length,
                                                    user.id,
                                                    false),
                                                customButton(
                                                    '3',
                                                    3,
                                                    greenGradient,
                                                    cards[index],
                                                    cards.length,
                                                    user.id,
                                                    false),
                                                customButton(
                                                    '4',
                                                    4,
                                                    greenGradient,
                                                    cards[index],
                                                    cards.length,
                                                    user.id,
                                                    false),
                                                customButton(
                                                    '5',
                                                    5,
                                                    greenGradient,
                                                    cards[index],
                                                    cards.length,
                                                    user.id,
                                                    false)
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                customButton("0", 0, null, null,
                                                    0, null, true),
                                                customButton("1", 0, null, null,
                                                    0, null, true),
                                                customButton("2", 0, null, null,
                                                    0, null, true),
                                                customButton("3", 0, null, null,
                                                    0, null, true),
                                                customButton("4", 0, null, null,
                                                    0, null, true),
                                                customButton("5", 0, null, null,
                                                    0, null, true)
                                              ],
                                            );
                                    },
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              36),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Table(
                                        columnWidths: const {
                                          0: FractionColumnWidth(0.040),
                                          1: FractionColumnWidth(0.030)
                                        },
                                        children: [
                                          TableRow(children: [
                                            Text('0',
                                                style: lightWhiteTextFont),
                                            Text(':',
                                                style: lightWhiteTextFont),
                                            Text('quality0',
                                                    style: lightWhiteTextFont,
                                                    maxLines: 2)
                                                .tr()
                                          ]),
                                          TableRow(children: [
                                            Text('1',
                                                style: lightWhiteTextFont),
                                            Text(':',
                                                style: lightWhiteTextFont),
                                            Text('quality1',
                                                    style: lightWhiteTextFont,
                                                    maxLines: 2)
                                                .tr()
                                          ]),
                                          TableRow(children: [
                                            Text('2',
                                                style: lightWhiteTextFont),
                                            Text(':',
                                                style: lightWhiteTextFont),
                                            Text('quality2',
                                                    style: lightWhiteTextFont,
                                                    maxLines: 2)
                                                .tr()
                                          ]),
                                          TableRow(children: [
                                            Text('3',
                                                style: lightWhiteTextFont),
                                            Text(':',
                                                style: lightWhiteTextFont),
                                            Text('quality3',
                                                    style: lightWhiteTextFont,
                                                    maxLines: 2)
                                                .tr()
                                          ]),
                                          TableRow(children: [
                                            Text('4',
                                                style: lightWhiteTextFont),
                                            Text(':',
                                                style: lightWhiteTextFont),
                                            Text('quality4',
                                                    style: lightWhiteTextFont,
                                                    maxLines: 2)
                                                .tr()
                                          ]),
                                          TableRow(children: [
                                            Text('5',
                                                style: lightWhiteTextFont),
                                            Text(':',
                                                style: lightWhiteTextFont),
                                            Text('quality5',
                                                    style: lightWhiteTextFont,
                                                    maxLines: 2)
                                                .tr()
                                          ]),
                                        ],
                                      )),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              36),
                                ],
                              ),
                            );
                          }),
                ),
              ),
            ],
          ));
    });
  }

  Widget customButton(String text, int quality, Gradient? colorGradient,
      CardModel? card, int cardsLength, String? userID, bool notAvailable) {
    return Container(
        height: 30,
        width: ((MediaQuery.of(context).size.width - edge * 2 - 30) / 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), gradient: colorGradient),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0))),
            onPressed: notAvailable
                ? null
                : () {
                    if (selectedCard <= cardsLength) {
                      if (cardController.state!.isFront == false) {
                        cardController.toggleCard();
                      }
                      Timer(Duration(milliseconds: 250), () {
                        // karna stream membuat variabel cards kita jadi null
                        // jadi gaperlu menambahkan index
                        // selectedCard += 1;
                        if (selectedCard < cardsLength) {
                          index = selectedCard;
                        }
                        setState(() {});
                      });
                    }

                    BlocProvider.of<CardBloc>(context)
                        .add(ReviewCard(userID!, card!, quality));

                    setState(() {});
                  },
            child: Center(
              child: Text(text, style: whiteTextFont.copyWith(fontSize: 12.0)),
            )));
  }
}
