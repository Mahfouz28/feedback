import 'package:feedback/presintation/feedback/widgets/suggetion_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController suggestionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  int _selectedEmoji = 3; // ⭐️ لتخزين التقييم الافتراضي
  final Color mainColor = const Color(0xFFCD9300); // اللون الرئيسي الجديد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'كيف كانت تجربتك؟',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                // Emoji Feedback
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: EmojiFeedback(
                    initialRating: _selectedEmoji,
                    animDuration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    inactiveElementScale: .7,
                    onChanged: (value) {
                      setState(() {
                        _selectedEmoji = value!;
                      });
                    },
                    onChangeWaitForAnimation: true,
                    customLabels: const [
                      "سيئ جداً",
                      "سيئ",
                      "عادي",
                      "جيد",
                      "ممتاز",
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const SizedBox(height: 100),
                // Suggestions Text Area
                const Text(
                  'ملاحظاتك / اقتراحاتك',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Form(
                  key: formKey,
                  child: CustomTextFormField(
                    controller: suggestionController,
                    hintText: 'اكتب ملاحظاتك هنا...',
                    maxLines: 5,
                  ),
                ),
                const SizedBox(height: 40),
                // Submit Button
                Center(
                  child: SizedBox(
                    height: 56,
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            suggestionController.text.isNotEmpty) {
                          print("التقييم: $_selectedEmoji");
                          print("الملاحظات: ${suggestionController.text}");

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Column(
                                  children: [
                                    const Text('تم الإرسال بنجاح'),
                                    SizedBox(
                                      height: 160,
                                      child: Image.asset(
                                        'assets/images/sent-mail.gif',
                                      ),
                                    ),
                                  ],
                                ),
                                content: const Text(
                                  'تم إرسال ملاحظاتك بنجاح! شكراً لك',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'حسناً',
                                      style: TextStyle(
                                        color: Color(0xFFCD9300),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          suggestionController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.9),
                        backgroundColor: mainColor, // اللون الرئيسي هنا
                        foregroundColor: Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          'إرسال الملاحظات',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
