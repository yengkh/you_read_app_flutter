// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/classes/google_account_login_service.dart';
import 'package:you_read_app_flutter/custome_widget/profile_page_widget/profile_page_item_widget.dart';
import 'package:you_read_app_flutter/database/phone_number_helper.dart';
import 'package:you_read_app_flutter/models/phone_number_model.dart';
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.phoneNumber});

  final PhoneNumberModel? phoneNumber;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  bool isDisable = true;
  bool focus = false;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _checkUser();
  }

  Future<void> _checkUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text(
          easy_localization.tr(LocaleKeys.profile),
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _user != null ? _LogInWithUser(_user!) : _buildSignInButton(),
    );
  }

  Widget _LogInWithUser(User user) {
    TextEditingController phoneController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: user.photoURL != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL!),
                      radius: 40,
                    )
                  : const CircleAvatar(
                      minRadius: 30,
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ProfileItem(
              title: user.displayName!,
              iconsLeading: Icons.person,
            ),
            const SizedBox(
              height: 10.0,
            ),
            ProfileItem(
              title: user.email!,
              iconsLeading: Icons.email,
              textSize: 14.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            FutureBuilder<List<PhoneNumberModel>?>(
              future: PhoneNumberHelper.getPhoneNumber(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    tileColor: Colors.blue,
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    title: Text(
                      easy_localization.tr(LocaleKeys.no_phone_number),
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            content: Text(
                              easy_localization
                                  .tr(LocaleKeys.please_input_phone_number),
                            ),
                            actions: <Widget>[
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                autofocus: true,
                                controller: phoneController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return easy_localization.tr(
                                        LocaleKeys.please_enter_phone_number);
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      easy_localization.tr(LocaleKeys.cancel),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        String newPhone = phoneController.text;
                                        final PhoneNumberModel data =
                                            PhoneNumberModel(
                                          phone: int.parse(newPhone),
                                          id: 1,
                                        );

                                        if (widget.phoneNumber == null) {
                                          await PhoneNumberHelper
                                              .addPhoneNumber(data);
                                        } else {
                                          await PhoneNumberHelper
                                              .updatePhoneNumber(data);
                                        }
                                        setState(() {});
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      easy_localization.tr(LocaleKeys.ok),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  final List<PhoneNumberModel> phoneNumber = snapshot.data!;
                  final data = phoneNumber[0];
                  return ListTile(
                    tileColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    title: Text(
                      "0${data.phone}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            content: Text(
                              easy_localization
                                  .tr(LocaleKeys.please_input_phone_number),
                            ),
                            actions: <Widget>[
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      keyboardType: TextInputType.phone,
                                      autofocus: true,
                                      controller: phoneController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return easy_localization.tr(
                                            LocaleKeys
                                                .please_enter_phone_number,
                                          );
                                        } else if (value.length < 8) {
                                          return easy_localization.tr(
                                            LocaleKeys
                                                .your_phone_number_is_to_short,
                                          );
                                        } else if (value.length > 12) {
                                          return easy_localization.tr(
                                            LocaleKeys
                                                .your_phone_number_is_too_long,
                                          );
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              String newPhone =
                                                  phoneController.text;
                                              final PhoneNumberModel data =
                                                  PhoneNumberModel(
                                                phone: int.parse(newPhone),
                                                id: 1,
                                              );

                                              if (widget.phoneNumber == null) {
                                                await PhoneNumberHelper
                                                    .addPhoneNumber(data);
                                              } else {
                                                await PhoneNumberHelper
                                                    .updatePhoneNumber(data);
                                              }
                                              setState(() {});
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: Text(
                                            easy_localization.tr(LocaleKeys.ok),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 100.0,
            ),
            Center(
              child: _user != null
                  ? const SizedBox()
                  : Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            AuthorService.signInWithGoogle();
                          },
                          icon: const Icon(
                            FontAwesomeIcons.google,
                            size: 40.0,
                          ),
                        ),
                        const Center(child: Text("Google")),
                      ],
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: _user != null
                  ? LogInLogOutText(
                      onTapEvent: () async {
                        await AuthorService.signOut();
                        await PhoneNumberHelper.deletePhoneById(1);
                        setState(() {
                          _user = null;
                        });
                      },
                      title: easy_localization.tr(LocaleKeys.log_out),
                    )
                  : LogInLogOutText(
                      title: easy_localization.tr(LocaleKeys.log_in),
                      onTapEvent: () {},
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            easy_localization.tr(LocaleKeys.you_dont_have_acco_yet),
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/images/Google_Icons-09-512.webp",
            height: 100,
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              minimumSize: const WidgetStatePropertyAll(
                Size(250.0, 40.0),
              ),
              backgroundColor: const WidgetStatePropertyAll(
                Colors.blue,
              ),
            ),
            onPressed: _handleSignIn,
            child: Text(
              easy_localization.tr(LocaleKeys.sign_in_with_google),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSignIn() async {
    UserCredential? userCredential = await AuthorService.signInWithGoogle();
    if (userCredential != null) {
      setState(() {
        _user = userCredential.user;
      });
    }
  }
}

class LogInLogOutText extends StatelessWidget {
  const LogInLogOutText({
    super.key,
    required this.title,
    required this.onTapEvent,
  });

  final String title;
  final Function() onTapEvent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapEvent,
      child: Text(
        title,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
