import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isDisable = true;
  bool _focus = false;
  final bool _isLogin = false;
  final TextEditingController _phone = TextEditingController();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: CircleAvatar(
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
              const ProfileItem(
                title: "Yeng",
                iconsLeading: Icons.person,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const ProfileItem(
                title: "channyeng@gmail.com",
                iconsLeading: Icons.email,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: TextFormField(
                  //maxLength: 15,
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    // for below version 2 use this
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    // for version 2 and greater youcan also use this
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  autofocus: _focus,
                  readOnly: _isDisable,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.phone),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isDisable = false;
                          _focus = true;
                        });
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      height: 2,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(_isLogin
                      ? easy_localization.tr(LocaleKeys.log_in)
                      : easy_localization.tr(LocaleKeys.sign_up)),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const Expanded(
                    child: Divider(
                      height: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: _isLogin
                    ? const SizedBox()
                    : Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              //AuthService.signInwithGoogle();
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
                child: Text(
                  _isLogin
                      ? easy_localization.tr(LocaleKeys.log_out)
                      : easy_localization.tr(LocaleKeys.log_in),
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.iconsLeading,
  });
  final String title;
  final IconData iconsLeading;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      tileColor: Colors.blue,
      title: Text(title),
      leading: Icon(
        iconsLeading,
      ),
    );
  }
}
