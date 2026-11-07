import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const EasyPeezyApp());
}

enum AppLanguage { english, hindi, bengali }

class AppStrings {
  static const Map<AppLanguage, Map<String, String>> values = {
    AppLanguage.english: {
      'hello': 'Hello there! 👋',
      'question': 'What would you like to do today?',
      'food': 'Order Food',
      'foodSub': 'Delicious meals',
      'grocery': 'Order Groceries',
      'grocerySub': 'Daily essentials',
      'cab': 'Book a Cab',
      'cabSub': 'Go somewhere',
      'call': 'Call Someone',
      'callSub': 'Talk to family',
      'speak': 'Tap to Speak',
      'listening': 'Listening... Speak now',
      'searchHint': 'What are you looking for?',
      'search': 'Search',
      'chooseLanguage': 'Choose Language',
      'foodSubtitle': 'Choose where you would like to order from.',
      'grocerySubtitle': 'Choose your grocery delivery service.',
      'cabSubtitle': 'Choose your cab service.',
      'backHome': 'Back to Home',
      'family': 'Family ❤️',
      'tapCall': 'Tap a family member to call them.',
      'addPhone': 'Add from Phone Contacts',
      'addManual': 'Add Manually',
      'familyContacts': 'Family Contacts',
      'noContacts': 'No family contacts yet',
      'addStart': 'Add someone to get started!',
      'addMember': 'Add Family Member',
      'name': 'Name',
      'enterName': 'Enter their name',
      'phone': 'Phone Number',
      'enterPhone': 'Enter their number',
      'cancel': 'Cancel',
      'save': 'Save Contact',
      'remove': 'Remove',
      'removeTitle': 'Remove Contact?',
      'removeConfirm': 'Do you want to remove',
      'ambiguous': 'Do you mean {item} as a food item or as a grocery item?',
      'foodChoice': 'Food',
      'groceryChoice': 'Grocery',
      'noSpeech': 'Voice recognition is unavailable. Please try typing.',
      'notUnderstood': 'Try “Food biriyani” or “Grocery rice”.',
      'permission': 'Contacts permission is needed.',
      'noNumber': 'This contact does not have a phone number.',
      'duplicate': 'This phone number is already in your list.',
      'missingFields': 'Please enter both name and number.',
      'diallerError': 'Could not open the phone dialler.',
      'contactError': 'Could not open your phone contacts.',
      'removeContact': 'Remove contact',
      'callTooltip': 'Call',
    },

    AppLanguage.hindi: {
      'hello': 'नमस्ते! 👋',
      'question': 'आज आप क्या करना चाहेंगे?',
      'food': 'खाना ऑर्डर करें',
      'foodSub': 'स्वादिष्ट खाना',
      'grocery': 'किराना मंगाएँ',
      'grocerySub': 'रोज़मर्रा की ज़रूरतें',
      'cab': 'कैब बुक करें',
      'cabSub': 'कहीं जाना है?',
      'call': 'किसी को कॉल करें',
      'callSub': 'परिवार से बात करें',
      'speak': 'बोलने के लिए टैप करें',
      'listening': 'सुन रहे हैं... बोलिए',
      'searchHint': 'आप क्या ढूंढ रहे हैं?',
      'search': 'खोजें',
      'chooseLanguage': 'भाषा चुनें',
      'foodSubtitle': 'खाना ऑर्डर करने के लिए सेवा चुनें।',
      'grocerySubtitle': 'किराने की डिलीवरी सेवा चुनें।',
      'cabSubtitle': 'कैब सेवा चुनें।',
      'backHome': 'होम पर वापस जाएँ',
      'family': 'परिवार ❤️',
      'tapCall': 'कॉल करने के लिए परिवार के सदस्य पर टैप करें।',
      'addPhone': 'फ़ोन संपर्कों से जोड़ें',
      'addManual': 'खुद जोड़ें',
      'familyContacts': 'परिवार के संपर्क',
      'noContacts': 'अभी कोई पारिवारिक संपर्क नहीं है',
      'addStart': 'शुरू करने के लिए किसी को जोड़ें!',
      'addMember': 'परिवार के सदस्य को जोड़ें',
      'name': 'नाम',
      'enterName': 'नाम लिखें',
      'phone': 'फ़ोन नंबर',
      'enterPhone': 'नंबर लिखें',
      'cancel': 'रद्द करें',
      'save': 'संपर्क सेव करें',
      'remove': 'हटाएँ',
      'removeTitle': 'संपर्क हटाएँ?',
      'removeConfirm': 'क्या आप हटाना चाहते हैं',
      'ambiguous': 'क्या आप {item} को खाद्य पदार्थ के रूप में चाहते हैं या किराने के सामान के रूप में?',
      'foodChoice': 'खाना',
      'groceryChoice': 'किराना',
      'noSpeech': 'आवाज़ पहचान उपलब्ध नहीं है। कृपया टाइप करें।',
      'notUnderstood': '“Food biriyani” या “Grocery rice” कहें।',
      'permission': 'संपर्क चुनने के लिए अनुमति चाहिए।',
      'noNumber': 'इस संपर्क में फ़ोन नंबर नहीं है।',
      'duplicate': 'यह फ़ोन नंबर पहले से सूची में है।',
      'missingFields': 'कृपया नाम और नंबर दोनों लिखें।',
      'diallerError': 'फ़ोन डायलर नहीं खुल सका।',
      'contactError': 'फ़ोन संपर्क नहीं खुल सके।',
      'removeContact': 'संपर्क हटाएँ',
      'callTooltip': 'कॉल करें',
    },

    AppLanguage.bengali: {
      'hello': 'নমস্কার! 👋',
      'question': 'আজ আপনি কী করতে চান?',
      'food': 'খাবার অর্ডার করুন',
      'foodSub': 'সুস্বাদু খাবার',
      'grocery': 'মুদি জিনিস আনান',
      'grocerySub': 'প্রতিদিনের প্রয়োজন',
      'cab': 'ক্যাব বুক করুন',
      'cabSub': 'কোথাও যাবেন?',
      'call': 'কাউকে ফোন করুন',
      'callSub': 'পরিবারের সঙ্গে কথা বলুন',
      'speak': 'বলতে ট্যাপ করুন',
      'listening': 'শুনছি... বলুন',
      'searchHint': 'আপনি কী খুঁজছেন?',
      'search': 'খুঁজুন',
      'chooseLanguage': 'ভাষা বেছে নিন',
      'foodSubtitle': 'খাবার অর্ডারের জন্য পরিষেবা বেছে নিন।',
      'grocerySubtitle': 'মুদি ডেলিভারির পরিষেবা বেছে নিন।',
      'cabSubtitle': 'ক্যাব পরিষেবা বেছে নিন।',
      'backHome': 'হোমে ফিরে যান',
      'family': 'পরিবার ❤️',
      'tapCall': 'ফোন করতে পরিবারের সদস্যের নাম ট্যাপ করুন।',
      'addPhone': 'ফোনের পরিচিতি থেকে যোগ করুন',
      'addManual': 'নিজে যোগ করুন',
      'familyContacts': 'পরিবারের পরিচিতি',
      'noContacts': 'এখনও কোনো পারিবারিক পরিচিতি নেই',
      'addStart': 'শুরু করতে কাউকে যোগ করুন!',
      'addMember': 'পরিবারের সদস্য যোগ করুন',
      'name': 'নাম',
      'enterName': 'নাম লিখুন',
      'phone': 'ফোন নম্বর',
      'enterPhone': 'নম্বর লিখুন',
      'cancel': 'বাতিল',
      'save': 'পরিচিতি সংরক্ষণ',
      'remove': 'সরান',
      'removeTitle': 'পরিচিতি সরাবেন?',
      'removeConfirm': 'আপনি কি সরাতে চান',
      'ambiguous': 'আপনি কি {item} খাবার হিসেবে চান, নাকি মুদি পণ্য হিসেবে?',
      'foodChoice': 'খাবার',
      'groceryChoice': 'মুদি',
      'noSpeech': 'ভয়েস শনাক্ত করা যাচ্ছে না। অনুগ্রহ করে টাইপ করুন।',
      'notUnderstood': '“Food biriyani” বা “Grocery rice” বলুন।',
      'permission': 'পরিচিতি বাছতে অনুমতি প্রয়োজন।',
      'noNumber': 'এই পরিচিতিতে ফোন নম্বর নেই।',
      'duplicate': 'এই নম্বরটি ইতিমধ্যেই তালিকায় আছে।',
      'missingFields': 'অনুগ্রহ করে নাম ও নম্বর দুটোই লিখুন।',
      'diallerError': 'ফোন ডায়ালার খোলা যায়নি।',
      'contactError': 'ফোনের পরিচিতি খোলা যায়নি।',
      'removeContact': 'পরিচিতি সরান',
      'callTooltip': 'ফোন করুন',
    },
  };

  static String get(AppLanguage language, String key) {
    return values[language]?[key] ??
        values[AppLanguage.english]![key] ??
        key;
  }

  static String speechLocale(AppLanguage language) {
    switch (language) {
      case AppLanguage.hindi:
        return 'hi_IN';
      case AppLanguage.bengali:
        return 'bn_IN';
      case AppLanguage.english:
        return 'en_IN';
    }
  }
}

class EasyPeezyApp extends StatelessWidget {
  const EasyPeezyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Peezy',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: const Color(0xFFFFFCF5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE9B6A5),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppLanguage language = AppLanguage.english;

  final TextEditingController searchController = TextEditingController();
  final stt.SpeechToText speech = stt.SpeechToText();

  bool isListening = false;

  final Color peach = const Color(0xFFFFE0CC);
  final Color lavender = const Color(0xFFE8DDF8);
  final Color blue = const Color(0xFFDCEBFA);
  final Color mint = const Color(0xFFDDF2DF);

  String t(String key) => AppStrings.get(language, key);

  @override
  void dispose() {
    searchController.dispose();
    speech.stop();
    super.dispose();
  }

  void openService(
    String title,
    String subtitle,
    IconData icon,
    List<Map<String, String>> options, {
    String searchQuery = '',
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceScreen(
          title: title,
          subtitle: subtitle,
          icon: icon,
          options: options,
          language: language,
          searchQuery: searchQuery,
        ),
      ),
    );
  }

Future<void> openFood({String query = ''}) async {
  final item = query
      .replaceFirst(
        RegExp(
          r'^(food|खाना|খাবার)[\s,]+',
          caseSensitive: false,
        ),
        '',
      )
      .trim();

  final url = item.isEmpty
      ? 'https://www.swiggy.com/'
      : 'https://www.swiggy.com/search?query=${Uri.encodeQueryComponent(item)}';

  try {
    final launched = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t('diallerError'))),
      );
    }
  } catch (_) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t('diallerError'))),
      );
    }
  }
}

  Future<void> openGroceries({String query = ''}) async {
  final item = query
      .replaceFirst(
        RegExp(r'^(grocery|groceries|किराना|বাজার)\s*', caseSensitive: false),
        '',
      )
      .trim();

  final url = item.isEmpty
      ? 'https://blinkit.com/'
      : 'https://blinkit.com/s/?q=${Uri.encodeQueryComponent(item)}';

  try {
    final launched = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t('diallerError'))),
      );
    }
  } catch (_) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t('diallerError'))),
      );
    }
  }
}

 Future<void> openCab({String query = ''}) async {
  final uri = Uri.parse('uber://');

  try {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && mounted) {
      await launchUrl(
        Uri.parse('https://m.uber.com/'),
        mode: LaunchMode.externalApplication,
      );
    }
  } catch (_) {
    if (mounted) {
      await launchUrl(
        Uri.parse('https://m.uber.com/'),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
    Future<void> startListening() async {
    if (isListening) {
      await speech.stop();
      if (mounted) {
        setState(() => isListening = false);
      }
      return;
    }

    bool available = await speech.initialize(
      onStatus: (status) {
        if (status == 'notListening' || status == 'done') {
          if (mounted) {
            setState(() => isListening = false);
          }
        }
      },
      onError: (error) {
        if (mounted) {
          setState(() => isListening = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t('noSpeech'))),
          );
        }
      },
    );

    if (!available) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t('noSpeech'))),
        );
      }
      return;
    }

    if (mounted) {
      setState(() => isListening = true);
    }

    await speech.listen(
      localeId: AppStrings.speechLocale(language),
      listenFor: const Duration(seconds: 20),
      pauseFor: const Duration(seconds: 3),
      onResult: (result) {
        if (!mounted) return;

        setState(() {
          searchController.text = result.recognizedWords;
          searchController.selection = TextSelection.fromPosition(
            TextPosition(offset: searchController.text.length),
          );
        });

        if (result.finalResult) {
          setState(() => isListening = false);
          handleCommand(result.recognizedWords);
        }
      },
    );
  }

  void handleCommand(String rawCommand) {
    final command = rawCommand.trim().toLowerCase();

    if (command.isEmpty) return;


    final foodWords = [
  'biryani', 'pizza', 'burger', 'dosa', 'meal',
  'restaurant', 'খাবার', 'बिरयानी',
  'খিচুড়ি', 'চাউমিন',

];

final groceryWords = [
  'grocery', 'groceries', 'vegetable', 'vegetables',
  'dal', 'rice', 'milk', 'eggs', 'atta',
  'সবজি', 'ডাল', 'চাল', 'দুধ', 'গাজর', 'गाजर',
  'shobji', 'sabji', 'gajor', 'gazar',
  'doodh', 'dudh', 'chawal', 'chaal',
  'aloo', 'piyaz', 'dim', 'machh'
];
final ambiguousWords = [
  'rice', 'চাল', 'chawal', 'chaal',
  'carrot', 'গাজর', 'gajor', 'gazar',
  'baby corn', 'বেবি কর্ন',
  'potato', 'আলু', 'aloo',
  'onion', 'পেঁয়াজ', 'piyaz',
  'mushroom', 'মাশরুম',
  'paneer', 'পনির',
];
    final cabWords = [
      'cab', 'taxi', 'uber', 'ola', 'ride',
      'टैक्सी', 'गाड़ी', 'ক্যাব', 'ট্যাক্সি',
    ];

    final callWords = [
      'call', 'phone', 'contact', 'कॉल', 'फोन',
      'ফোন', 'কল',
    ];

    final hasFood = foodWords.any((word) => command.contains(word));
    final hasGrocery =
        groceryWords.any((word) => command.contains(word));
    final hasCab = cabWords.any((word) => command.contains(word));
    final hasCall = callWords.any((word) => command.contains(word));

    
final purchaseWords = [
  'buy', 'order', 'need', 'want',
  'kinbo', 'kinte', 'lagbe',
  'chahiye', 'khareedna', 'kharidna',
  'কিনব', 'কিনতে', 'লাগবে',
  'চাই', 'কিনে দাও',
  'खरीदना', 'चाहिए', 'लेना',
];

final hasPurchaseIntent =
    purchaseWords.any((word) => command.contains(word));

final words = command.split(RegExp(r'\s+'));

final actionWords = [
  'khabo', 'khaabo', 'eat', 'eating',
  'buy', 'order', 'need', 'want',
  'kinbo', 'kinte', 'lagbe',
  'chahiye', 'khareedna', 'kharidna',
  'food', 'grocery', 'groceries',
'খাবো', 'খাব', 'খেতে',
'खाओ', 'खाना',
];

final itemName = words
    .where((word) => !actionWords.contains(word))
    .join(' ')
    .trim();

    if (hasCab) {
      openCab(query: rawCommand);
      return;
    }

    if (hasCall) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CallSomeoneScreen(language: language),
        ),
      );
      return;
    }
    // Ask the user for every food or grocery search.
if (rawCommand.trim().isNotEmpty) {
  showChoiceDialog(
    rawCommand,
    item: itemName.isEmpty ? rawCommand.trim() : itemName,
  );
  return;
}

  }
   void showChoiceDialog(String command, {String? item}) {
  final displayItem = item ?? command.trim();

  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        title: Text(
          t('ambiguous').replaceAll('{item}', displayItem),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              openFood(query: command);
            },
            child: Text(t('foodChoice')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              openGroceries(query: command);
            },
            child: Text(t('groceryChoice')),
          ),
        ],
      );
    },
  );
}
  void chooseLanguage() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(t('chooseLanguage')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  setState(() => language = AppLanguage.english);
                  Navigator.pop(dialogContext);
                },
              ),
              ListTile(
                title: const Text('हिन्दी'),
                onTap: () {
                  setState(() => language = AppLanguage.hindi);
                  Navigator.pop(dialogContext);
                },
              ),
              ListTile(
                title: const Text('বাংলা'),
                onTap: () {
                  setState(() => language = AppLanguage.bengali);
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget serviceCard({
    required String title,
    required String subtitle,
    required String emoji,
    required Color color,
    required VoidCallback onTap,
    required double emojiSize,
    required double titleSize,
    required double subtitleSize,
  }) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                emoji,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: emojiSize),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF343044),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: subtitleSize,
                  color: const Color(0xFF625D70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      body: Stack(
  fit: StackFit.expand,
  children: [
  Positioned(
  top: 0,
  left: 0,
  right: 0,
  bottom: 0,
  child: Image.asset(
    'assets/images/easy_peezy_background.png',
    fit: BoxFit.fill,
  ),
),
    SafeArea(
      child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final availableHeight = height.floorToDouble();
            final keyboardOpen = height < 600;

            final compact = availableHeight < 760;
            final veryCompact = availableHeight < 680;

            final horizontalPadding = compact ? 14.0 : 18.0;
            final brandSize = veryCompact ? 23.0 : 27.0;
            final greetingSize = veryCompact ? 19.0 : 22.0;
            final questionSize = veryCompact ? 13.0 : 15.0;

            final micCircleSize = veryCompact ? 46.0 : 54.0;
            final micIconSize = veryCompact ? 27.0 : 32.0;
            final micTextSize = veryCompact ? 14.0 : 16.0;

            final emojiSize = veryCompact ? 34.0 : 39.0;
            final cardTitleSize = veryCompact ? 14.0 : 16.0;
            final cardSubtitleSize = veryCompact ? 10.0 : 12.0;
debugPrint('HOME HEIGHT: ${constraints.maxHeight}');
debugPrint('KEYBOARD HEIGHT: ${MediaQuery.of(context).viewInsets.bottom}');
            return Padding(
  padding: EdgeInsets.symmetric(
    horizontal: horizontalPadding,
    vertical: keyboardOpen ? 2 : (veryCompact ? 4 : 7),
  ),
  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App branding
 // App branding
Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      'EASY PEEZY',
      style: TextStyle(
  fontFamily: 'Nunito',
  fontSize: brandSize,
  fontWeight: FontWeight.w800,
  color: const Color(0xFF6D4C91),
),
),
    const SizedBox(height: 0),
    Text(
      'ESSENTIALS',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: veryCompact ? 17 : 19,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF6D4C91),
      ),
    ),
    Text(
      'everyday essentials made simple',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Nunito',
        fontSize: veryCompact ? 10 : 11,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        shadows: const [
          Shadow(
            color: Color(0x66000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
    ),
  ],
),

                  SizedBox(height: veryCompact ? 4 : 7),

                  // Greeting
                  Text(
  'hello there! 👋',
  textAlign: TextAlign.center,
  maxLines: 1,
  style: TextStyle(
    fontFamily: 'Nunito',
    fontSize: greetingSize - 2,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF383044),
                    ),
                  ),

                  SizedBox(height: veryCompact ? 2 : 4),

                  Text(
                    t('question'),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: questionSize,
                      color: const Color(0xFF746D7D),
                    ),
                  ),

                  SizedBox(height: veryCompact ? 7 : 10),

                  // Compact voice command panel
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: veryCompact ? 7 : 9,
                    ),
                    decoration: BoxDecoration(
                      color: lavender,
                      borderRadius: BorderRadius.circular(23),
                      border: Border.all(
                       color: Colors.white,
                       width: 3,
  ),
),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: const Color(0xFF7952A5),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: startListening,
                            child: SizedBox(
                              width: micCircleSize,
                              height: micCircleSize,
                              child: Icon(
                                isListening
                                    ? Icons.mic
                                    : Icons.mic_none,
                                size: micIconSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isListening ? t('listening') : t('speak'),
                          style: TextStyle(
                            fontSize: micTextSize,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF503875),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: veryCompact ? 7 : 9),

                  // Typed search
                  SizedBox(
                    height: veryCompact ? 45 : 49,
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: handleCommand,
                      style: TextStyle(
                        fontSize: veryCompact ? 13 : 15,
                      ),
                      decoration: InputDecoration(
                        hintText: t('searchHint'),
                        hintStyle: TextStyle(
                          fontSize: veryCompact ? 12 : 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 21,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {
                            handleCommand(searchController.text);
                          },
                        ),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  // Language selection
                  SizedBox(
                    height: veryCompact ? 35 : 39,
                    child: Center(
                      child: TextButton.icon(
                        onPressed: chooseLanguage,
                        icon: Icon(
                          Icons.language,
                          size: veryCompact ? 17 : 19,
                          color: const Color(0xFF8B5948),
                        ),
                        label: Text(
                        t('chooseLanguage'),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: veryCompact ? 12 : 14,
                            color: const Color(0xFF8B5948),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: veryCompact ? 3 : 5),

                  // Four service cards share the remaining screen space.
                  Expanded(
                      child: Padding(
                      padding: EdgeInsets.only(
                      top: keyboardOpen ? 45 : 0,
                         ),
                      child: GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.35,
                      children: [
                        serviceCard(
                          title: t('food'),
                          subtitle: t('foodSub'),
                          emoji: '🍜',
                          color: peach,
                          emojiSize: emojiSize,
                          titleSize: cardTitleSize,
                          subtitleSize: cardSubtitleSize,
                          onTap: () => openFood(),
                        ),
                        serviceCard(
                          title: t('grocery'),
                          subtitle: t('grocerySub'),
                          emoji: '🥕🥦',
                          color: mint,
                          emojiSize: emojiSize,
                          titleSize: cardTitleSize,
                          subtitleSize: cardSubtitleSize,
                          onTap: () => openGroceries(),
                        ),
                        serviceCard(
                          title: t('cab'),
                          subtitle: t('cabSub'),
                          emoji: '🚕',
                          color: blue,
                          emojiSize: emojiSize,
                          titleSize: cardTitleSize,
                          subtitleSize: cardSubtitleSize,
                          onTap: () => openCab(),
                        ),
                        serviceCard(
                          title: t('call'),
                          subtitle: t('callSub'),
                          emoji: '📞',
                          color: lavender,
                          emojiSize: emojiSize,
                          titleSize: cardTitleSize,
                          subtitleSize: cardSubtitleSize,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CallSomeoneScreen(
                                  language: language,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                                         ), // GridView.count
                  ), // Padding
                ), // Expanded
                if (!keyboardOpen) const SizedBox(height: 8),
if (!keyboardOpen)
  Align(
    alignment: Alignment.centerRight,
    child: Transform.translate(
      offset: const Offset(0, 24),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AboutScreen(),
            ),
          );
        },
        child: const Text(
          '❤️',
          style: TextStyle(
            color: Color(0xFF6D4C91),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  ),
                ],
              ),
            );
          },
        ),
      ),
        ], // children
  ), // Stack
);
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEAF4),
      appBar: AppBar(
        title: const Text('About the App'),
        backgroundColor: const Color.fromARGB(255, 237, 176, 206),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Easy Peezy Essentials',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6D4C91),
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'About the App',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6D4C91),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '♥  Version 1.0.0\n\n'
                '♥  Developed by Mihika Bakshi\n\n'
                '♥  © 2026 Mihika Bakshi. All rights reserved.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF604879),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodResultsScreen extends StatelessWidget {
  final String query;
  final AppLanguage language;

  const FoodResultsScreen({
    super.key,
    required this.query,
    required this.language,
  });

  static const List<Map<String, String>> sampleFoods = [
    {
      'name': 'Chicken Biriyani',
      'restaurant': "Maa's Kitchen (Sample)",
      'price': '₹220',
      'description': 'Aromatic rice with chicken',
    },
    {
      'name': 'Veg Biriyani',
      'restaurant': 'Spice Garden (Sample)',
      'price': '₹180',
      'description': 'Flavourful vegetable biriyani',
    },
    {
      'name': 'Mutton Biriyani',
      'restaurant': 'Royal Feast (Sample)',
      'price': '₹280',
      'description': 'Traditional-style mutton biriyani',
    },
    {
      'name': 'Masala Dosa',
      'restaurant': 'South Corner (Sample)',
      'price': '₹120',
      'description': 'Crispy dosa with potato filling',
    },
    {
      'name': 'Veg Fried Rice',
      'restaurant': 'Wok House (Sample)',
      'price': '₹160',
      'description': 'Fried rice with fresh vegetables',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final searchTerm = query
    .toLowerCase()
    .trim()
    .replaceAll('biriyani', 'biriyani');

    final results = searchTerm.isEmpty
        ? sampleFoods
        : sampleFoods.where((food) {
            return food.values.any(
   (value) => value
    .toLowerCase()
    .replaceAll('biryani', 'biriyani')
    .contains(searchTerm),
            );
          }).toList();

    final isHindi = language == AppLanguage.hindi;
    final isBengali = language == AppLanguage.bengali;

    final heading = isHindi
        ? 'आपके खाने के विकल्प'
        : isBengali
            ? 'আপনার খাবারের বিকল্প'
            : 'Your Food Options';

    final demoNotice = isHindi
        ? 'डेमो परिणाम — ये Swiggy के लाइव परिणाम नहीं हैं।'
        : isBengali
            ? 'ডেমো ফলাফল — এগুলি Swiggy-এর লাইভ ফলাফল নয়।'
            : 'DEMO RESULTS — These are not live Swiggy results.';

    final noResults = isHindi
        ? 'कोई नमूना परिणाम नहीं मिला।'
        : isBengali
            ? 'কোনও নমুনা ফলাফল পাওয়া যায়নি।'
            : 'No sample results found.';

    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        title: Text(
          isHindi
              ? 'खाना खोजें'
              : isBengali
                  ? 'খাবার খুঁজুন'
                  : 'Find Food',
        ),
        backgroundColor: const Color(0xFFFFFAF4),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF49365F),
                ),
              ),

              const SizedBox(height: 8),

              if (query.isNotEmpty)
                Text(
                  'Search: $query',
                  style: const TextStyle(fontSize: 17),
                ),

              const SizedBox(height: 14),

              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0CC),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  demoNotice,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF704A3B),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Expanded(
                child: results.isEmpty
                    ? Center(
                        child: Text(
                          noResults,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          final food = results[index];

                          return Card(
                            color: Colors.white,
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food['name']!,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF49365F),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    food['restaurant']!,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    food['description']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    food['price']!,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF7952A5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 10),

              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: Text(
                  isHindi
                      ? 'होम पर वापस जाएँ'
                      : isBengali
                          ? 'হোমে ফিরে যান'
                          : 'Back to Home',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF7952A5),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ServiceScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Map<String, String>> options;
  final AppLanguage language;
  final String searchQuery;

  const ServiceScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.options,
    required this.language,
    this.searchQuery = '',
  });

  String t(String key) => AppStrings.get(language, key);

  Future<void> openProvider(
    BuildContext context,
    String url,
  ) async {
    final uri = Uri.parse(url);

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t('diallerError'))),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t('diallerError'))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFFFFFAF4),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              Icon(
                icon,
                size: 70,
                color: const Color(0xFF7952A5),
              ),

              const SizedBox(height: 16),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 17,
                  color: Color(0xFF625D70),
                ),
              ),

              if (searchQuery.trim().isNotEmpty) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8DDF8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${t('search')}: $searchQuery',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 30),

              ...options.map((option) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () => openProvider(
                        context,
                        option['url']!,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8DDF8),
                        foregroundColor: const Color(0xFF49365F),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        option['name']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),

              const Spacer(),

              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: Text(t('backHome')),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF7952A5),
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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

// Family contact model
class FamilyContact {
  final String name;
  final String phone;

  FamilyContact({
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  factory FamilyContact.fromJson(Map<String, dynamic> json) {
    return FamilyContact(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class CallSomeoneScreen extends StatefulWidget {
  final AppLanguage language;

  const CallSomeoneScreen({
    super.key,
    required this.language,
  });

  @override
  State<CallSomeoneScreen> createState() => _CallSomeoneScreenState();
}

class _CallSomeoneScreenState extends State<CallSomeoneScreen> {
  List<FamilyContact> contacts = [];
  bool isLoading = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String t(String key) => AppStrings.get(widget.language, key);

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final savedContacts = prefs.getString('family_contacts');

    if (savedContacts != null) {
      try {
        final List<dynamic> decoded = jsonDecode(savedContacts);

        contacts = decoded
            .map(
              (item) => FamilyContact.fromJson(
                Map<String, dynamic>.from(item),
              ),
            )
            .toList();
      } catch (_) {
        contacts = [];
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveContacts() async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = jsonEncode(
      contacts.map((contact) => contact.toJson()).toList(),
    );

    await prefs.setString('family_contacts', encoded);
  }

  Future<void> addFromPhoneContacts() async {
    try {
      final permission = await FlutterContacts.permissions.request(
        PermissionType.read,
      );

      if (permission != PermissionStatus.granted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t('permission'))),
          );
        }
        return;
      }

      final contact = await FlutterContacts.native.showPicker(
        properties: {ContactProperty.phone},
      );

      if (contact == null) return;

      final phoneNumbers = contact.phones;

      if (phoneNumbers.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t('noNumber'))),
          );
        }
        return;
      }

      final newContact = FamilyContact(
        name: contact.displayName ?? 'Contact',
        phone: phoneNumbers.first.number,
      );

      if (contacts.any((c) => c.phone == newContact.phone)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(t('duplicate'))),
          );
        }
        return;
      }

      setState(() {
        contacts.add(newContact);
      });

      await saveContacts();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t('contactError'))),
        );
      }
    }
  }
    Future<void> addContact() async {
    nameController.clear();
    phoneController.clear();

    await showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(t('addMember')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: t('name'),
                  hintText: t('enterName'),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: t('phone'),
                  hintText: t('enterPhone'),
                  prefixIcon: const Icon(Icons.phone),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(t('cancel')),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final phone = phoneController.text.trim();

                if (name.isEmpty || phone.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t('missingFields'))),
                  );
                  return;
                }

                if (contacts.any((c) => c.phone == phone)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t('duplicate'))),
                  );
                  return;
                }

                setState(() {
                  contacts.add(
                    FamilyContact(
                      name: name,
                      phone: phone,
                    ),
                  );
                });

                await saveContacts();

                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                }
              },
              child: Text(t('save')),
            ),
          ],
        );
      },
    );
  }

  Future<void> callContact(FamilyContact contact) async {
    final phone = contact.phone.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t('noNumber'))),
      );
      return;
    }

    final uri = Uri(
      scheme: 'tel',
      path: phone,
    );

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t('diallerError'))),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t('diallerError'))),
        );
      }
    }
  }

  Future<void> removeContact(int index) async {
    final contact = contacts[index];

    final shouldRemove = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(t('removeTitle')),
          content: Text(
            '${t('removeConfirm')} ${contact.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(t('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(t('remove')),
            ),
          ],
        );
      },
    );

    if (shouldRemove == true) {
      setState(() {
        contacts.removeAt(index);
      });

      await saveContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF4),
      appBar: AppBar(
        title: Text(t('family')),
        backgroundColor: const Color(0xFFFFFAF4),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              const Text(
                '❤️',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 48),
              ),

              const SizedBox(height: 8),

              Text(
                t('familyContacts'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF49365F),
                ),
              ),

              const SizedBox(height: 22),

              ElevatedButton.icon(
                onPressed: addFromPhoneContacts,
                icon: const Icon(Icons.contacts),
                label: Text(t('tapCall')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8DDF8),
                  foregroundColor: const Color(0xFF49365F),
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: addContact,
                icon: const Icon(Icons.person_add_alt_1),
                label: Text(t('addManual')),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF7952A5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                t('familyContacts'),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF49365F),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : contacts.isEmpty
                        ? Center(
                            child: Text(
                              t('noContacts'),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF746D7D),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              final contact = contacts[index];

                              return Card(
                                color: Colors.white,
                                elevation: 1,
                                margin: const EdgeInsets.only(bottom: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  leading: const CircleAvatar(
                                    backgroundColor: Color(0xFFE8DDF8),
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xFF7952A5),
                                    ),
                                  ),
                                  title: Text(
                                    contact.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(contact.phone),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        tooltip: t('callTooltip'),
                                        onPressed: () => callContact(contact),
                                        icon: const Icon(
                                          Icons.call,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        tooltip: t('removeContact'),
                                        onPressed: () => removeContact(index),
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: Text(t('backHome')),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF7952A5),
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
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
