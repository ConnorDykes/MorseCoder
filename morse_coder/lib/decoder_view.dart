import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DecoderView extends StatefulWidget {
  const DecoderView({super.key});

  @override
  State<DecoderView> createState() => _DecoderViewState();
}

class _DecoderViewState extends State<DecoderView> {
  Map morseCodeMap = {
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',
    '1': '.----',
    '2': '..---',
    '3': '...--',
    '4': '....-',
    '5': '.....',
    '6': '-....',
    '7': '--...',
    '8': '---..',
    '9': '----.',
    '0': '-----',
    ', ': '--..--',
    '.': '.-.-.-',
    '?': '..--..',
    '/': '-..-.',
    '-': '-....-',
    '(': '-.--.',
    ')': '-.--.-',
    "'": ".----.",
    '"': '.-..-.'
  };

  String decodedMessage = '';
  String code = '';
  List errorMessages = [];
  TextEditingController messageController = TextEditingController();

  decodeMorse() {
    errorMessages.clear();
    Map decodeMap = morseCodeMap.map((k, v) => MapEntry(v, k));
    String decodedMorse = "";
    List splitWords = code.split("   ");
    print(splitWords);
    splitWords.forEach((word) {
      List splitLetters = word.split(" ");
      String decodedWord = '';
      for (int i = 0; i < splitLetters.length; i++) {
        if (decodeMap.containsKey(splitLetters[i])) {
          decodedWord += decodeMap[splitLetters[i]];
        } else {
          if (splitLetters[i] != ' ') {
            errorMessages.add(splitLetters[i]);
          }
        }
      }
      decodedMorse += '${decodedWord} ';
    });

    return decodedMorse;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Decode'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Decoded Message',
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: Colors.green),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          decodedMessage,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: errorMessages.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'The following sequences are not recognised',
                    style: TextStyle(color: Colors.red),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: errorMessages.length,
                    itemBuilder: (context, index) => Text(
                      errorMessages[index],
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge!
                          .copyWith(color: Colors.red),
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: theme.disabledColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          code,
                          style: theme.textTheme.titleLarge,
                        )),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add three spaces between words and one space between letters',
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      code += '.';
                    });
                  },
                  child: Text(
                    'dot',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      code += '-';
                    });
                  },
                  child: Text(
                    'dash',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      code += ' ';
                    });
                  },
                  child: Icon(Icons.space_bar_rounded)),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (code.isNotEmpty)
                        code = code.substring(0, code.length - 1);
                    });
                  },
                  child: Icon(Icons.keyboard_backspace_rounded)),
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              clipBehavior: Clip.hardEdge,
              child: Material(
                elevation: 5,
                color: Colors.blue, // Button color
                child: InkWell(
                  // Splash color
                  onTap: () {
                    setState(() {
                      code += '.';
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      code += '-';
                    });
                  },
                  child: SizedBox(
                      width: 75,
                      height: 75,
                      child: Center(
                          child: Text(
                        'Manual\nInput',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tap for " . " , Tap and Hold for " - "',
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        setState(() {
                          decodedMessage = decodeMorse();
                        });
                      },
                      child: Text('Decode')),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
