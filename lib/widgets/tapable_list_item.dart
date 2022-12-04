import 'package:flutter/material.dart';

class TapableListItem extends StatelessWidget {
  const TapableListItem({Key? key, this.action, this.imageAdress, this.title})
      : super(key: key);

  final String? imageAdress;
  final String? title;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: action,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xFF0291F7).withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                  color: Color(0xFF0291F7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ImageIcon(
                  AssetImage(imageAdress!),
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              title!,
              style: const TextStyle(fontSize: 17.5),
            ),
            for (int i = 0; i < 8; i++) Container(),
          ]),
        ),
      ),
    );
  }
}

class TapableModifiedListItem extends StatelessWidget {
  const TapableModifiedListItem(
      {Key? key,
      this.buttonAction,
      this.imageAdress,
      this.title,
      this.subtitle,
      this.buttonTitle})
      : super(key: key);

  final String? imageAdress;
  final String? title;
  final String? subtitle;
  final Function()? buttonAction;
  final String? buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: GestureDetector(
        onTap: buttonAction,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xFF0291F7).withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                  color: Color(0xFF0291F7),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ImageIcon(
                  AssetImage(imageAdress!),
                  color: Colors.white,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  subtitle!,
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.6)),
                ),
              ],
            ),
            for (int i = 0; i < 2; i++) Container(),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                onPressed: buttonAction,
                child: Text(
                  buttonTitle!,
                  style: TextStyle(
                      color: (buttonTitle! == 'paired')
                          ? Colors.green
                          : Colors.white),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
