part of 'pages.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  // List<CardModel> cards = [
  //   CardModel(
  //       // id: 0,
  //       question: 'Kapan Flutter 2.0 rilis ?',
  //       answer: '3 Maret 2021'),
  //   CardModel(
  //       // id: 1,
  //       question: 'What is an Algorithm?',
  //       answer:
  //           'An algorithm is a set of instructions for solving a problem or accomplishing a task.'),
  //   CardModel(
  //       // id: 2,
  //       question: 'What does SDK stand for?',
  //       answer: 'Software Development Kit')
  // ];

  FlipCardController cardController = FlipCardController();
  int selectedCard = 0;
  int index = 0;
  bool flashcardHasData = false;
  final sm = Sm();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
      FlashcardUser? user =
          userState is! UserInitial ? (userState as UserLoaded).user : null;

      return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
              child: CustomBar(title: 'STUDY'),
              preferredSize: Size.fromHeight(50.0)),
          drawer: Drawer(
              backgroundColor: accentColor,
              child: SafeArea(
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
                                text: 'Home'),
                            CustomText(
                                onTap: () {
                                  BlocProvider.of<PageBloc>(context)
                                      .add(GotoAddFlashcardPage());
                                },
                                icon: Icons.add_box_outlined,
                                text: 'Add Card'),
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
              )),
          body: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: WebsafeSvg.asset("assets/bg.svg", fit: BoxFit.fill)),
              SafeArea(
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: edge),
                  child: StreamBuilder<List<CardModel>>(
                      stream: FlashcardServices.getStreamFlashcard(user!.id),
                      builder: (_, snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                              heightFactor: 5.0,
                              child: Container(
                                  padding: EdgeInsets.only(bottom: 100.0),
                                  child: (snapshot.connectionState ==
                                          ConnectionState.waiting)
                                      ? CircularProgressIndicator()
                                      : SizedBox(child: Text('kosong'))));
                        } else {
                          List<CardModel> cards = snapshot.data!;

                          return Column(
                            children: [
                              Container(
                                  height: 2.0,
                                  width: double.infinity,
                                  color: primaryColor),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 24),
                              (selectedCard < cards.length)
                                  ? CustomCard(
                                      cardModel: cards[selectedCard],
                                      controller: cardController)
                                  : CustomContainer(
                                      child: Center(
                                          child: Text(
                                        'You have done today, Great Job! :D',
                                        textAlign: TextAlign.center,
                                        style: whiteTextFont.copyWith(
                                            fontSize: 14),
                                      )),
                                      color: Colors.black54),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 20),
                              BlocBuilder<UserBloc, UserState>(
                                builder: (_, userState) {
                                  FlashcardUser user =
                                      (userState as UserLoaded).user;

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      customButton('0', 0, redGradient,
                                          cards[index], cards.length, user.id),
                                      customButton('1', 1, redGradient,
                                          cards[index], cards.length, user.id),
                                      customButton('2', 2, redGradient,
                                          cards[index], cards.length, user.id),
                                      customButton('3', 3, greenGradient,
                                          cards[index], cards.length, user.id),
                                      customButton('4', 4, greenGradient,
                                          cards[index], cards.length, user.id),
                                      customButton('5', 5, greenGradient,
                                          cards[index], cards.length, user.id)
                                    ],
                                  );
                                },
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 36),
                              Expanded(
                                child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    color: Colors.transparent,
                                    child: Table(
                                      columnWidths: const {
                                        0: FractionColumnWidth(0.040),
                                        1: FractionColumnWidth(0.030)
                                      },
                                      children: [
                                        TableRow(children: [
                                          Text('0', style: lightWhiteTextFont),
                                          Text(':', style: lightWhiteTextFont),
                                          Text('Complete blackout',
                                              style: lightWhiteTextFont,
                                              maxLines: 2)
                                        ]),
                                        TableRow(children: [
                                          Text('1', style: lightWhiteTextFont),
                                          Text(':', style: lightWhiteTextFont),
                                          Text(
                                              'Incorrect response, the correct one remembered',
                                              style: lightWhiteTextFont,
                                              maxLines: 2)
                                        ]),
                                        TableRow(children: [
                                          Text('2', style: lightWhiteTextFont),
                                          Text(':', style: lightWhiteTextFont),
                                          Text(
                                              'Incorrect response, where the correct one seemed easy to recall',
                                              style: lightWhiteTextFont,
                                              maxLines: 2)
                                        ]),
                                        TableRow(children: [
                                          Text('3', style: lightWhiteTextFont),
                                          Text(':', style: lightWhiteTextFont),
                                          Text(
                                              'Correct response, recalled with serious difficulty',
                                              style: lightWhiteTextFont,
                                              maxLines: 2)
                                        ]),
                                        TableRow(children: [
                                          Text('4', style: lightWhiteTextFont),
                                          Text(':', style: lightWhiteTextFont),
                                          Text(
                                              'Correct response, after a hesitation',
                                              style: lightWhiteTextFont,
                                              maxLines: 2)
                                        ]),
                                        TableRow(children: [
                                          Text('5', style: lightWhiteTextFont),
                                          Text(':', style: lightWhiteTextFont),
                                          Text('Perfect response',
                                              style: lightWhiteTextFont,
                                              maxLines: 2)
                                        ]),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 50),
                            ],
                          );
                        }
                      }),
                )),
              ),
            ],
          ));
    });
  }

  Widget customButton(String text, int quality, Gradient colorGradient,
      CardModel card, int cardsLength, String userID) {
    return Container(
        height: 30,
        width: ((MediaQuery.of(context).size.width - edge * 2 - 30) / 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), gradient: colorGradient),
        child: OutlinedButton(
            onPressed: () {
              if (selectedCard <= cardsLength) {
                if (cardController.state!.isFront == false) {
                  cardController.toggleCard();
                }
                Timer(Duration(milliseconds: 250), () {
                  selectedCard += 1;
                  if (selectedCard < cardsLength) {
                    index = selectedCard;
                  }
                  setState(() {});
                });
              }

              // SmResponse smResponse = sm.calc(
              //     quality: quality,
              //     repetitions: card.repetitions,
              //     previousInterval: card.intervals,
              //     previouseaseFactor: card.easeFactor);

              // card = updateCard(card, smResponse);

              BlocProvider.of<CardBloc>(context)
                  .add(ReviewCard(userID, card, quality));

              setState(() {});
            },
            child: Center(
              child: Text(text, style: whiteTextFont.copyWith(fontSize: 12.0)),
            )));
  }
}

// CardModel updateCard(CardModel card, SmResponse response) {
//   CardModel updatedCard = CardModel(
//       // id: card.id,
//       question: card.question,
//       answer: card.answer,
//       repetitions: response.repetitions,
//       easeFactor: response.easeFactor,
//       intervals: response.interval.toDouble());
//   return updatedCard;
// }
