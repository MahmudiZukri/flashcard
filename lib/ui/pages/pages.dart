import 'dart:async';

import 'package:flashcard/bloc/bloc.dart';
import 'package:flashcard/models/models.dart';
import 'package:flashcard/services/services.dart';
import 'package:flashcard/shared/shared.dart';
import 'package:flashcard/ui/widgets/widgets.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:sm2/sm.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:email_validator/email_validator.dart';

part 'wrapper.dart';
part 'loading_page.dart';
part 'splash_page.dart';
part 'sign_up_page.dart';
part 'sign_in_page.dart';
part 'home_page.dart';
part 'study_page.dart';
part 'add_flashcard_page.dart';
