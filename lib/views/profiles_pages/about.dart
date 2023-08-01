import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Grinda'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(children: [
          Text('Grinda is an innovative app that enables service employers to locate and hire qualified service providers quickly and easily. Whether you need a plumber, electrician, or house cleaner, Grinda connects you with skilled professionals who can provide the services you need in a timely manner. The app has become increasingly popular among service seekers because of its convenience and user-friendliness.'),
          SizedBox(height: 20,),
          Text("Grinda is designed to make the process of finding service providers online as seamless and hassle-free as possible. The app features a simple and intuitive interface that enables users to search for service providers based on their location, ratings, and availability. Service seekers can also view service provider profiles to learn more about their skills, experience, and qualifications."),
          SizedBox(height: 20,),
          Text("One of the key benefits of Grinda is that it provides users with access to a wide range of service providers. From handymen and cleaners to tutors and chefs, Grinda has an extensive database of service providers that can meet the diverse needs of its users. This makes it easy for service seekers to find the right service provider for their specific needs and budget."),
          SizedBox(height: 20,),
          Text('Grinda also has a number of features that are designed to ensure that service providers are reliable and trustworthy. The app requires service providers to undergo a thorough screening process that includes background checks and verification of their credentials. This gives service seekers peace of mind knowing that they are hiring a reputable service provider.'),
          SizedBox(height: 20,),
          Text("Overall, Grinda is a valuable tool for service seekers who need to locate and hire service providers online. The app's user-friendly interface, extensive database of service providers, and reliable screening process make it a top choice for anyone who needs to find skilled professionals quickly and efficiently. Whether you're looking for a one-time service or a long-term partnership, Grinda is the go-to app for finding the right service provider for your needs.")
        ]),
      ),
    );
  }
}