import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:you_read_app_flutter/database/download_database_helper.dart';
import 'package:you_read_app_flutter/models/download_model.dart';
import 'package:easy_localization/easy_localization.dart' as easy_localization;
import 'package:you_read_app_flutter/translations/locale_key.g.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    // Get current theme mode
    final themeMode = AdaptiveTheme.of(context).mode;
    // // Determine active color based on theme mode
    final activeColor = themeMode == AdaptiveThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text(
          easy_localization.tr(LocaleKeys.books_downloaded),
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<DownloadModel>?>(
        future: DownloadHelper.getAll(),
        builder: (context, AsyncSnapshot<List<DownloadModel>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  snapshot.error.toString(),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final List<DownloadModel> datas = snapshot.data!;
            if (snapshot.data != null) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
                itemCount: datas.length,
                itemBuilder: (context, index) {
                  final data = datas[index];
                  // Assuming data.image is a base64-encoded string
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 200.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 200.0,
                              width: 110.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: activeColor
                                        ? Colors.blue
                                        : Colors.grey.withOpacity(0.5),
                                    spreadRadius: activeColor ? 0 : 5,
                                    blurRadius: activeColor ? 0 : 3,
                                    offset: activeColor
                                        ? const Offset(0, 0)
                                        : const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.memory(
                                  data.image,
                                  height: 200.0,
                                  width: 110.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: activeColor
                                          ? Colors.blue
                                          : Colors.grey.withOpacity(0.5),
                                      spreadRadius: activeColor ? 0 : 5,
                                      blurRadius: activeColor ? 0 : 3,
                                      offset: activeColor
                                          ? const Offset(0, 0)
                                          : const Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.blue,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          easy_localization.tr(LocaleKeys.name),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          easy_localization
                                              .tr(LocaleKeys.author),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.author,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          easy_localization.tr(LocaleKeys.type),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        Text(
                                          data.type,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            style: const ButtonStyle(
                                              minimumSize:
                                                  WidgetStatePropertyAll(
                                                      Size(200, 20)),
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.white,
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              easy_localization
                                                  .tr(LocaleKeys.read),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            style: const ButtonStyle(
                                              minimumSize:
                                                  WidgetStatePropertyAll(
                                                      Size(200, 20)),
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                Colors.white,
                                              ),
                                            ),
                                            onPressed: () async {
                                              await DownloadHelper
                                                  .deleteFromDownloadById(
                                                      data.id!);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    easy_localization.tr(LocaleKeys
                                                        .book_has_remove_from_download),
                                                  ),
                                                  duration: const Duration(
                                                    seconds: 2,
                                                  ),
                                                ),
                                              );
                                              setState(() {}); // Refresh UI
                                            },
                                            child: Text(
                                              easy_localization
                                                  .tr(LocaleKeys.delete),
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/Data_Not_Found_Drive_Full_Full_Storage_Drive-512.webp",
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(easy_localization.tr(LocaleKeys.no_book_has_downloaded)),
              ],
            ),
          );
        },
      ),
    );
  }
}
