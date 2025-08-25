import 'package:feedback/presintation/feedback/widgets/suggetion_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  String _selectedFeedbackType = 'شيء ما ليس على ما يرام';
  final TextEditingController suggestionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final List<String> _feedbackTypes = [
    'شكوى',
    'شيء ما ليس على ما يرام',
    'اقتراح',
    'كل شئ على ما يرام',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[100], // Softer background for better contrast
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
                // Emoji Feedback with improved styling
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: EmojiFeedback(
                    initialRating: 3,
                    animDuration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    inactiveElementScale: .7,
                    onChanged: (value) {},
                    onChangeWaitForAnimation: true,
                  ),
                ),
                const SizedBox(height: 32),
                // Feedback Type Section
                const Text(
                  'يرجى اختيار فئة ملاحظاتك',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children:
                      _feedbackTypes.map((category) {
                        return ChoiceChip(
                          label: Text(category),
                          selected: _selectedFeedbackType == category,
                          selectedColor: Colors.orangeAccent,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          labelStyle: TextStyle(
                            color:
                                _selectedFeedbackType == category
                                    ? Colors.white
                                    : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color:
                                  _selectedFeedbackType == category
                                      ? Colors.orangeAccent
                                      : Colors.grey[300]!,
                            ),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _selectedFeedbackType = category;
                            });
                          },
                        );
                      }).toList(),
                ),
                const SizedBox(height: 32),
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
                // Submit Button with Gradient
                Center(
                  child: SizedBox(
                    height: 56,
                    width: 220,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() &&
                            suggestionController.text.isNotEmpty) {
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
                                      style: TextStyle(color: Colors.black),
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
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                      ).copyWith(
                        backgroundColor: WidgetStateProperty.resolveWith(
                          (states) => Colors.orangeAccent,
                        ),
                        overlayColor: WidgetStateProperty.resolveWith(
                          (states) => Colors.orange[700],
                        ),
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

// Custom RatingStars Widget (Improved)
class RatingStars extends StatefulWidget {
  final double rating;
  final Function(double) onRatingChanged;

  const RatingStars({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  _RatingStarsState createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return GestureDetector(
            onTap: () {
              widget.onRatingChanged(index + 1);
              _animationController.reset();
              _animationController.forward();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: ScaleTransition(
                scale: _animation,
                child: Icon(
                  index < widget.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber[600],
                  size: 40,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
