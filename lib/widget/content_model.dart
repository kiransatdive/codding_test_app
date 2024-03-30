class UnboardingContent {
  String image;
  String title;
  String description;

  UnboardingContent({
    required this.description,
    required this.image,
    required this.title,
  });
}

List<UnboardingContent> contents = [
  UnboardingContent(
      description:
          "Instractions :\n1) How Test Timing Works Please make sure you can complete this test in one sitting, as the timer cannot be stopped once you begin. \n2)Clicking (Start) starts your running timer, even if you are not actively in the test.\n3)Importantly, the timer does not pause if you log out or get disconnected from the assessment.",
      image: "assets/images/screens.png",
      title: "Coding Test "),
];
