import 'dart:ui' as ui;
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuccessPage extends StatefulWidget {
  final String? url;
  const SuccessPage({Key? key, this.url}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {

  @override
  void initState() {
    ui.platformViewRegistry.registerViewFactory('openstreetmap', (int viewId) {
      return IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..src = widget.url!
        ..style.border = 'none';
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const fontSize = 30.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Theme.of(context).iconTheme.color,
              size: 35,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Your video has been",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: Theme.of(context).textTheme.headline6!.color,
                    ),
                children: [
                  TextSpan(
                    text: " successfully ",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5271ff),
                          height: 1,
                        ),
                  ),
                  TextSpan(
                    text: "generated!",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.headline6!.color,
                          height: 1,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 500,
              width: 500 ,
              child: HtmlElementView(viewType: 'openstreetmap'
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    // copy to clipboard
                    Clipboard.setData(ClipboardData(text: widget.url));
                  },
                  icon: Icon(
                    Icons.copy,
                    color: Theme.of(context).iconTheme.color,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(
                    Icons.share,
                    color: Theme.of(context).iconTheme.color,
                    size: 35,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        color: const Color(0xFF5271ff),
        child: const Center(
          child: Text(
            'Created by Carl Duncan for the 2022 AssemblyAI Hackathon. ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  //
}
