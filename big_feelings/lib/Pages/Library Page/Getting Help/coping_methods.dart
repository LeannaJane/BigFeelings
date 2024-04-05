// ignore_for_file: library_private_types_in_public_api, use_super_parameters
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';
import 'package:big_feelings/Pages/Library%20Page/Getting%20Help/list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CopingMethods extends StatefulWidget {
  const CopingMethods({Key? key}) : super(key: key);

  @override
  _CopingMethodsState createState() => _CopingMethodsState();
}

class _CopingMethodsState extends State<CopingMethods> {
  bool _isPaused = false;

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  String _getCopingMethodDescription(String copingMethod) {
    return CopingDescriptions.getDescription(copingMethod);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      final getContainerColor =
          Provider.of<ThemeNotifier>(context).getContainerColor();
      Color iconColor = themeNotifier.getIconColor();
      final fontProvider = Provider.of<FontProvider>(context);

      final screenWidth = MediaQuery.of(context).size.width;
      final containerWidth = (screenWidth - 48) / 4;
      const containerHeight = 150.0;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Coping Mechanisms',
            style: fontProvider.getOtherTitleStyle(themeNotifier),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (rowIndex) => Column(
                    children: List.generate(
                      4,
                      (colIndex) {
                        int index = rowIndex * 4 + colIndex;
                        return GestureDetector(
                          onTap: () {
                            _showCopingMethodDialog(context, index,
                                fontProvider, themeNotifier, getContainerColor);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            width: containerWidth < containerHeight
                                ? containerWidth
                                : containerHeight,
                            height: containerWidth < containerHeight
                                ? containerWidth
                                : containerHeight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: getContainerColor,
                            ),
                            child: _isPaused
                                ? Center(
                                    child: Text(
                                      copingMethods[index],
                                      style: fontProvider
                                          .libarytext(themeNotifier),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : OverflowBox(
                                    child: Transform.scale(
                                      scale:
                                          0.5, // Adjust scale factor as needed
                                      child: Image.asset(
                                        copingMethodsWithImages[
                                                copingMethods[index]] ??
                                            '',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _togglePause,
          tooltip: _isPaused ? 'Play' : 'Pause',
          backgroundColor: getContainerColor,
          child: Icon(
            _isPaused ? Icons.play_arrow : Icons.pause,
            color: iconColor,
          ),
        ),
      );
    });
  }

  void _showCopingMethodDialog(
      BuildContext context,
      int index,
      FontProvider fontProvider,
      ThemeNotifier themeNotifier,
      getContainerColor) {
    String copingMethod = copingMethods[index];
    String imagePath = copingMethodsWithImages[copingMethod] ?? '';
    TextStyle textStyle = fontProvider.description(themeNotifier);
    TextStyle greenTextStyle =
        textStyle.copyWith(color: Colors.green, fontWeight: FontWeight.bold);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: getContainerColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 500.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Coping with $copingMethod',
                        style: textStyle.copyWith(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _getCopingMethodDescription(copingMethod),
                        style: textStyle,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Image.asset(
                      imagePath,
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Close',
                          style: greenTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
