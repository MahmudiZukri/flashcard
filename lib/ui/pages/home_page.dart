part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        WebsafeSvg.asset("assets/bg.svg"),
        Padding(
          padding: const EdgeInsets.all(edge),
          child: Container(
            decoration: BoxDecoration(
              gradient: primaryGradient,
              shape: BoxShape.circle,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomePage()));
                },
                icon: Icon(Icons.chevron_left, color: blackColor)),
          ),
        ),
        SafeArea(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: edge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCard(
                  question: "Kapan Flutter 2.0 rilis ?",
                  answer: "3 Maret 2021",
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.red[500],
                      ),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.chevron_left, color: blackColor),
                            SizedBox(width: 10),
                            Text(
                              'Prev',
                              style: greyTextFont.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.green[500],
                      ),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Text(
                              'Next',
                              style: greyTextFont.copyWith(fontSize: 14),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.chevron_right, color: blackColor),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ],
    ));
  }
}
