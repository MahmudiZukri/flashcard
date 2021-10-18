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
                          style: whiteTextFont.copyWith(fontSize: 14),
                        )),
                        color: Colors.black54),
                SizedBox(height: MediaQuery.of(context).size.height / 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customButton('0', redGradient),
                    customButton('1', redGradient),
                    customButton('2', redGradient),
                    customButton('3', greenGradient),
                    customButton('4', greenGradient),
                    customButton('5', greenGradient)
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

  Widget customButton(String text, Gradient colorGradient) {
    return Container(
        height: 30,
        width: ((MediaQuery.of(context).size.width - edge * 2 - 30) / 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), gradient: colorGradient),
        child: OutlinedButton(
            onPressed: () {
              if (selectedCard <= cards.length) {
                selectedCard += 1;
                if (cardController.state!.isFront == false) {
                  cardController.toggleCard();
                }
              }
              setState(() {});
            },
            child: Center(
              child: Text(text, style: whiteTextFont.copyWith(fontSize: 12.0)),
            )));
  }
}
