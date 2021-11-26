part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CardModel> cards = [
    CardModel(
        id: 0, question: 'Kapan Flutter 2.0 rilis ?', answer: '3 Maret 2021'),
    CardModel(
        id: 1,
        question: 'What is an Algorithm?',
        answer:
            'An algorithm is a set of instructions for solving a problem or accomplishing a task.'),
    CardModel(
        id: 2,
        question: 'What does SDK stand for?',
        answer: 'Software Development Kit')
  ];

  FlipCardController cardController = FlipCardController();
  int selectedCard = 0;
  int index = 0;
  final sm = Sm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(child: WebsafeSvg.asset("assets/bg.svg")),
        Padding(
          padding: const EdgeInsets.all(edge),
          child: Container(
            height: MediaQuery.of(context).size.height / 16,
            decoration: BoxDecoration(
              gradient: primaryGradient,
              shape: BoxShape.circle,
            ),
            child: IconButton(
                iconSize: 22.0,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                },
                icon: Icon(Icons.chevron_left, color: primaryColor)),
          ),
        ),
        SafeArea(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 6.8),
                (selectedCard < cards.length)
                    ? CustomCard(
                        cardModel: cards[selectedCard],
                        controller: cardController)
                    : CustomContainer(
                        child: Center(
                            child: Text(
                          'You have done today :D',
                          textAlign: TextAlign.center,
                          style: whiteTextFont.copyWith(fontSize: 14),
                        )),
                        color: Colors.black54),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customButton('0', 0, redGradient, cards[index]),
                    customButton('1', 1, redGradient, cards[index]),
                    customButton('2', 2, redGradient, cards[index]),
                    customButton('3', 3, greenGradient, cards[index]),
                    customButton('4', 4, greenGradient, cards[index]),
                    customButton('5', 5, greenGradient, cards[index])
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 36),
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
                                style: lightWhiteTextFont, maxLines: 2)
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
                            Text('Correct response, after a hesitation',
                                style: lightWhiteTextFont, maxLines: 2)
                          ]),
                          TableRow(children: [
                            Text('5', style: lightWhiteTextFont),
                            Text(':', style: lightWhiteTextFont),
                            Text('Perfect response',
                                style: lightWhiteTextFont, maxLines: 2)
                          ]),
                        ],
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
              ],
            ),
          )),
        ),
      ],
    ));
  }

  Widget customButton(
      String text, int quality, Gradient colorGradient, CardModel card) {
    return Container(
        height: 30,
        width: ((MediaQuery.of(context).size.width - edge * 2 - 30) / 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), gradient: colorGradient),
        child: OutlinedButton(
            onPressed: () {
              if (selectedCard <= cards.length) {
                if (cardController.state!.isFront == false) {
                  cardController.toggleCard();
                }
                Timer(Duration(milliseconds: 250), () {
                  selectedCard += 1;
                  if (selectedCard < cards.length) {
                    index = selectedCard;
                  }
                  setState(() {});
                });
              }

              // SmResponse smResponse = sm.calc(
              //     quality: quality,
              //     repetitions: card.repetitions,
              //     previousInterval: card.intervals,
              //     previousEaseFactor: card.easefactor);

              // card = updateCard(card, smResponse);

              setState(() {});
            },
            child: Center(
              child: Text(text, style: whiteTextFont.copyWith(fontSize: 12.0)),
            )));
  }
}

CardModel updateCard(CardModel card, SmResponse response) {
  CardModel updatedCard = CardModel(
      id: card.id,
      question: card.question,
      answer: card.answer,
      repetitions: response.repetitions,
      easefactor: response.easeFactor,
      intervals: response.interval.toDouble());
  return updatedCard;
}
