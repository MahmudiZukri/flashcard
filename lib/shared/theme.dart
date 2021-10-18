part of 'shared.dart';

const Color primaryColor = Color(0xFF4B6587);
const Color secondaryColor = Color(0xFF8B94BC);
const Color lightGreyColor = Color(0xFFC8C6C6);
const Color lightColor = Color(0xFFF0E5CF);

const Color backgroundColor = Color(0xFFF9F3DF);
const Color backgroundWhite = Colors.white;
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;

const primaryGradient = LinearGradient(
    colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight);
var redGradient = LinearGradient(
    colors: [primaryColor, Colors.red[500]!],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);
var greenGradient = LinearGradient(
    colors: [primaryColor, Colors.green[500]!],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);

TextStyle blackTextFont = GoogleFonts.poppins(
    color: blackColor, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle greyTextFont = GoogleFonts.poppins(
    color: primaryColor, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle whiteTextFont = GoogleFonts.poppins(
    color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle lightWhiteTextFont = GoogleFonts.poppins(
    color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w300);
