import 'package:flutter/material.dart';

import 'globalWidgets/textWidget.dart';

class ContactFormScreen extends StatelessWidget {
  ContactFormScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.grey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 600;
            double padding = constraints.maxWidth * (isWide ? 0.3 : 0.05);
            double formHeight = constraints.maxHeight * 0.7; // Adjust height dynamically
            return Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width:  constraints.maxWidth * 1,
                  height: formHeight, // Set height dynamically
                  child: Padding(
                    padding:  EdgeInsets.only(left:  padding, right: padding),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReusableTextWidget(
                            text: 'Contact with me to sizzle your project',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          ReusableTextWidget(
                            text: "Feel free to contact me if you have any questions. "
                                "I'm available for new projects or just for chatting.",
                            textAlign: TextAlign.center,
                            fontSize: 16,
                            maxLines: 3,

                          ),
                          const SizedBox(height: 20),

                          // Responsive Name & Email Fields
                          isWide
                              ? Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Name",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) =>
                                  value!.isEmpty ? "Enter your name" : null,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) =>
                                  value!.isEmpty ? "Enter a valid email" : null,
                                ),
                              ),
                            ],
                          )
                              : Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Name",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) =>
                                value!.isEmpty ? "Enter your name" : null,
                              ),
                              const SizedBox(height: 15),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Email",
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) =>
                                value!.isEmpty ? "Enter a valid email" : null,
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Description...",
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 4,
                            validator: (value) =>
                            value!.isEmpty ? "Enter work details" : null,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Handle form submission
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Form Submitted")),
                                  );
                                }
                              },
                              child: const Text("Submit"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}