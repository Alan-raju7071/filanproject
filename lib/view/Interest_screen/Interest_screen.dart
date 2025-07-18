import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilits/constants/colorconstant.dart';
import 'package:flutter_application_1/Utilits/constants/text_constants.dart';
import 'package:flutter_application_1/view/verify_screen/Verify_screen.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/interest_categories.dart';


class InterestsCategoriesWidget extends StatefulWidget {
  const InterestsCategoriesWidget({Key? key}) : super(key: key);

  @override
  State<InterestsCategoriesWidget> createState() =>
      _InterestsCategoriesWidgetState();
}

class _InterestsCategoriesWidgetState extends State<InterestsCategoriesWidget> {
  final TextEditingController customInterestController = TextEditingController();
final List<String> customInterests = [];

final Set<String> selectedInterests = {};
  void _addCustomInterest() {
  final text = customInterestController.text.trim();
  if (text.isNotEmpty && !selectedInterests.contains(text)) {
    setState(() {
      selectedInterests.add(text);
      customInterests.add(text);
      customInterestController.clear();
    });
  }
}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(TextConstants.intcat)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
  controller: customInterestController,
  decoration: InputDecoration(
    labelText: 'Add Custom Interest',
    suffixIcon: IconButton(
      icon: const Icon(Icons.add),
      onPressed: _addCustomInterest,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
),
if (customInterests.isNotEmpty)
  Wrap(
    spacing: 12,
    runSpacing: 12,
    children: customInterests.map((item) {
      final isSelected = selectedInterests.contains(item);
      return ChoiceChip(
        label: Text(item),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              selectedInterests.add(item);
            } else {
              selectedInterests.remove(item);
            }
          });
        },
        selectedColor: Colorconstants.primarygrey,
        backgroundColor: Colorconstants.grey300,
        labelStyle: TextStyle(
          color: isSelected
              ? Colorconstants.primaryblue
              : Colorconstants.primaryblack,
        ),
      );
    }).toList(),
  ),
const SizedBox(height: 24),

const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: interestCategories.entries.map((entry) {
                  final category = entry.key;
                  final items = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '[$category]',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: items.map((item) {
                            final isSelected = selectedInterests.contains(item);
                            return ChoiceChip(
                              label: Text(
                                item,
                                style: const TextStyle(fontSize: 14),
                              ),
                              selected: isSelected,
                              onSelected: (bool selected) {
                                setState(() {
                                  if (category == 'Education') {
                                    selectedInterests
                                        .removeWhere((e) => interestCategories['Education']!.contains(e));
                                  }
                                  if (selected) {
                                    selectedInterests.add(item);
                                  } else {
                                    selectedInterests.remove(item);
                                  }
                                });
                              },
                              selectedColor: Colorconstants.primarygrey,
                              backgroundColor: Colorconstants.grey300,
                              labelStyle: TextStyle(
                                color: isSelected ? Colorconstants.primaryblue : Colorconstants.primaryblack,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
           Padding(
  padding: const EdgeInsets.symmetric(vertical: 16),
  child: GestureDetector(
    onTap: selectedInterests.length >= 5
        ? () {
            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VerifyScreen()), 
            );
          }
        : null, 
    child: Opacity(
      opacity: selectedInterests.length >= 5 ? 1.0 : 0.5, 
      child: CustomButton(
        text: TextConstants.continu,
        color: Colorconstants.primaryblue,
      ),
    ),
  ),
),
 ],
        ),
      ),
    );
  }
}
