part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: edge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCard(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 3),
                  color: whiteColor,
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
                  color: whiteColor,
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
    );
  }
}
