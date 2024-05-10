// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:big_feelings/Classes/font_provider.dart';
import 'package:big_feelings/Classes/theme_notifier.dart';

// ignore: use_key_in_widget_constructors
class TermsAndPrivacyDialog extends StatefulWidget {
  @override
  _TermsAndPrivacyDialogState createState() => _TermsAndPrivacyDialogState();
}

class _TermsAndPrivacyDialogState extends State<TermsAndPrivacyDialog> {
  bool showTerms = true;

  @override
  Widget build(BuildContext context) {
    return Consumer2<FontProvider, ThemeNotifier>(
      builder: (context, fontProvider, themeNotifier, child) {
        Color getContainerColor =
            Provider.of<ThemeNotifier>(context).getContainerColor();
        return AlertDialog(
          backgroundColor: getContainerColor,
          title: Stack(
            children: [
              Text(
                'Terms and Privacy Policy',
                style: fontProvider
                    .description(themeNotifier)
                    .copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: showTerms
                ? _buildTermsContent(fontProvider, themeNotifier)
                : _buildPrivacyContent(fontProvider, themeNotifier),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: fontProvider.description(themeNotifier),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      showTerms = !showTerms;
                    });
                  },
                  child: Text(
                    showTerms ? 'Privacy' : 'Terms',
                    style: fontProvider.description(themeNotifier),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTermsContent(
      FontProvider fontProvider, ThemeNotifier themeNotifier) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1. Acceptance of Terms and conditions',
            style: fontProvider
                .description(themeNotifier)
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(''' Last updated 06/04/2024

These terms and conditions ("Terms") govern your use of the Big Feelings web app ("App") operated by Big Feelings ("us", "we", or "our").

Please read these Terms carefully before using the App.

By accessing or using the App, you agree to be bound by these Terms. If you disagree with any part of the terms, then you may not access the App.

TABLE OF CONTENTS

1. Use License
2. Age Requirement
3. Parental Consent
4. Compliance with GDPR and Children's Privacy Laws
5. User Responsibilities
6. Modifications
7. Governing Law
8. Contact Us

1. Use License

Permission is granted to temporarily download one copy of the materials (information or software) on the App for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license, you may not:

• Modify or copy the materials;
• Use the materials for any commercial purpose or for any public display (commercial or non-commercial);
• Attempt to decompile or reverse engineer any software contained in the App;
• Remove any copyright or other proprietary notations from the materials or
• Transfer the materials to another person or "mirror" the materials on any other server.

This license shall automatically terminate if you violate any of these restrictions and may be terminated by us at any time. Upon terminating your viewing of these materials or upon the termination of this license, you must destroy any downloaded materials in your possession, whether in electronic or printed format.

2. Age Requirement

The App is intended for use by individuals aged 6 to 11 years old. However, anyone can access the App. It is the responsibility of adults, particularly parents or legal guardians, to ensure that children under the age of 13 have parental consent to use the App.

3. Parental Consent

By allowing a child under the age of 13 to use the App, you represent and warrant that you are the parent or legal guardian of that child and you consent to the collection and use of the child's information as described in our Privacy Policy.

4. Compliance with GDPR and Children's Privacy Laws

We are committed to compliance with the General Data Protection Regulation (GDPR) and other applicable laws concerning the privacy of children. Our Privacy Policy outlines how we collect, use, and disclose personal information, particularly regarding children. Parents or legal guardians have the right to review, update, or delete their child's information as outlined in the Privacy Policy.

5. User Responsibilities

By accessing or using the Big Feelings web app, you agree to adhere to the following user responsibilities:

a. Responsible Conduct: Users are expected to engage with the App in a responsible and respectful manner. This includes refraining from posting or sharing any content that is unlawful, defamatory, obscene, harmful, or otherwise objectionable.

b. Respect for Privacy: Users must respect the privacy of others, including refraining from sharing personal information about other users without their explicit consent.

c. Compliance with Community Guidelines: Users are required to comply with the community guidelines outlined by Big Feelings. These guidelines are designed to ensure a safe and supportive environment for all users. Violation of these guidelines may result in the termination of your account or access to the App.

d. Reporting of Concerns: Users are encouraged to report any concerns or inappropriate behaviour observed within the App. This helps us maintain a positive and secure environment for all users.

e. Parental Supervision: Parents or legal guardians are responsible for supervising their children's use of the App, particularly for users under the age of 13. It is important for parents to monitor their children's activities and ensure compliance with these Terms and any applicable laws or regulations.

f. Feedback and Suggestions: We welcome feedback and suggestions from users to improve the App's functionality and user experience. However, any feedback or suggestions provided must not infringe upon the intellectual property rights of others.

By using the App, you acknowledge and agree to abide by these user responsibilities. Failure to comply with these responsibilities may result in the termination of your account or access to the App.

6. Modifications

We may revise these terms of service for the App at any time without notice. By using the App you are agreeing to be bound by the then current version of these terms of service.

7. Governing Law

These terms and conditions are governed by and construed in accordance with the laws of the United Kingdom, and you irrevocably submit to the exclusive jurisdiction of the courts in that location.

8. Contact Us

If you have any questions about these Terms, please contact us at leannaalt@gmail.com.

We would like to acknowledge that Termly.io assisted us in crafting this Terms and Conditions notice to ensure compliance with best practices and legal requirements. Your trust is paramount to us, and with the support of Termly.io, we are dedicated to addressing any inquiries or issues you may have promptly and courteously. Thank you for entrusting us with your privacy.

''', style: fontProvider.description(themeNotifier)),
        ],
      ),
    );
  }

  Widget _buildPrivacyContent(
      FontProvider fontProvider, ThemeNotifier themeNotifier) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2. Acceptance of Privacy Policy',
            style: fontProvider
                .description(themeNotifier)
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            '''Last updated 06/04/2024

This privacy notice for the Big Feelings web app ('we', 'us', or 'our'), describes how and why we might collect, store, use, and/or share ('process') your information when you use our services ('Services'), such as when you:

•	Register an account on the Big Feelings web app
•	Save journal entries
•	Save mood entries
•	Complete quiz forms
•	Engage with our interactive features or applications

Questions or concerns?

Reading this privacy notice will help you understand your privacy rights and choices. If you have any questions or concerns, please contact us at leannaalt@gmail.com.

SUMMARY OF KEY POINTS
This summary provides key points from our privacy notice, but you can find out more details about any of these topics by reviewing the privacy notice in full.

TABLE OF CONTENTS

WHAT INFORMATION DO WE COLLECT?
HOW DO WE PROCESS YOUR INFORMATION?
WHAT LEGAL BASES DO WE RELY ON TO PROCESS YOUR PERSONAL INFORMATION?
WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?
HOW LONG DO WE KEEP YOUR INFORMATION?
HOW DO WE KEEP YOUR INFORMATION SAFE?
WHAT ARE YOUR PRIVACY RIGHTS?
HOW CAN YOU CONTACT US ABOUT THIS NOTICE?
HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?

WHAT INFORMATION DO WE COLLECT?

Data Collection:
When you register an account on the Big Feelings web app, we collect the following personal information:

Email address
Password (securely hashed)
Verification of email address through email verification process

Journal Entries, Mood Entries, and Quiz Results:
When you use our Services, such as saving journal entries, mood entries, or completing quiz forms, we may collect and store the following types of data:

Content of journal entries
Mood data entered by users
Results of completed quizzes
Data Management and Deletion:
We provide users with full control over their data within the app. You can freely delete journal entries, mood entries, or quiz results at any time, and once deleted, this information is permanently removed from our systems. Additionally, users have the option to delete their account entirely within the app, which will result in the deletion of all associated data.

HOW DO WE PROCESS YOUR INFORMATION?

How do you use the collected information to improve user experience or provide personalized features?

We do not use the collected information for any purposes other than essential app functionality. We do not utilise user data to improve user experience or provide personalized features.

Do you use any third-party services or tools (such as analytics services or advertising networks) that may collect user data?

No, we do not use any third-party services or tools that may collect user data.

How do you ensure the protection of user data when using third-party services?

As we do not utilise any third-party services, there is no risk of user data exposure to external parties.

Cookies and Tracking Technologies:
We do not use cookies or similar tracking technologies to collect information about user interactions with the app. Therefore, users do not need to manage cookie preferences, and they are not informed about the use of cookies as they are not utilized within the app.


WHAT LEGAL BASES DO WE RELY ON TO PROCESS YOUR PERSONAL INFORMATION?

Our legal basis for processing your personal information depends on the specific context in which we collect it. Generally, we rely on the following legal bases:

Contractual Necessity: The processing of your personal information is necessary for the performance of a contract to which you are a party, or to take steps at your request prior to entering into such a contract. For example, we need your email address to create and manage your account.

Legitimate Interests: We may process your personal information for our legitimate interests, such as improving our services, providing customer support, and ensuring the security of our systems. We always balance our interests against your rights and freedoms.


HOW LONG DO WE KEEP YOUR INFORMATION?

We retain your personal information only for as long as necessary to fulfill the purposes outlined in this privacy policy, unless a longer retention period is required or permitted by law. Specifically, we keep your information until you decide to delete your account. Once you delete your account, we promptly remove all associated personal data from our systems.

HOW DO WE KEEP YOUR INFORMATION SAFE?

We take the security of your personal information seriously and implement appropriate technical and organizational measures to ensure its protection. Our systems are hosted on secure platforms such as Firebase, which employ industry-standard security protocols to safeguard your data against unauthorized access, disclosure, alteration, or destruction. Additionally, we regularly review and update our security practices to mitigate potential risks and vulnerabilities.

WHAT ARE YOUR PRIVACY RIGHTS?

1. Right to Access: You have the right to access and review the personal data we hold about you. You can do this by logging into your account and accessing your profile settings, where you can view and manage your personal information.

2. Right to Rectification: If you believe that any personal information we hold about you is inaccurate, incomplete, or outdated, you have the right to correct or update your information directly through your account settings.

3. Right to Erasure: You have the right to delete your personal data from our systems at any time. You can exercise this right by accessing your account settings and selecting the option to delete your account, which will permanently remove all associated personal data.

4. Right to Restriction of Processing: You have the ability to restrict the processing of your personal data by adjusting your account settings or by deleting specific information as desired.

5. Right to Object: You have the right to object to the processing of your personal data for certain purposes. You can manage your preferences and opt-out of specific data processing activities within your account settings.

6. Right to Data Portability: You have the right to request a copy of your personal data in a commonly used and machine-readable format. You can export your data from your account settings.

HOW CAN YOU CONTACT US ABOUT THIS NOTICE?

If you have any questions, concerns, or feedback about this privacy notice or our data practices, please feel free to contact us using the following information:

Email: leannaalt@gmail.com

We value your privacy and are committed to addressing any inquiries or issues promptly and effectively. Your feedback helps us ensure that our privacy practices remain transparent and aligned with your expectations.

HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?

We understand the importance of maintaining control over your personal data. To review, update, or delete the information we collect from you, please follow these steps:

Reviewing Data:

You can review the data collected from you within the app by accessing the relevant sections, such as journal entries, mood entries, or quiz results.
Updating Data:

To update your information, such as your email address or password, navigate to the settings or account management section within the app. From there, you can make the necessary changes.
Deleting Data:

If you wish to delete specific data, such as journal entries, mood entries, or quiz results, you can do so directly within the app. Simply locate the data you want to delete and use the provided delete option.
Deleting Your Account:

Should you decide to delete your account entirely, including all associated data, you can initiate the account deletion process within the app's settings or account management section. Follow the prompts to confirm the deletion, and your account, along with all related data, will be permanently removed from our systems.

At Big Feelings, we prioritis the protection of your privacy and the security of your personal information. We are committed to ensuring transparency regarding our data practices and providing you with the necessary tools to manage your data effectively. If you have any further questions, concerns, or feedback regarding our privacy notice or data handling procedures, please do not hesitate to reach out to us at leannaalt@gmail.com. Your trust is paramount to us, and we are dedicated to addressing any inquiries or issues you may have promptly and courteously. Thank you for entrusting us with your privacy.

We would like to acknowledge that Termly.io assisted us in crafting this privacy notice to ensure compliance with best practices and legal requirements. Your trust is paramount to us, and with the support of Termly.io, we are dedicated to addressing any inquiries or issues you may have promptly and courteously. Thank you for entrusting us with your privacy.


''',
            style: fontProvider.description(themeNotifier),
          ),
        ],
      ),
    );
  }
}
