List<String> copingMethods = [
  "Walking",
  "Call a Friend",
  "Listen to music",
  "Journalling",
  "Deep Breathing",
  "Meditation",
  "Activites",
  "Playing with a pet",
  "Splash water trick",
  "Hold a icecube",
  "Ask for help",
  "Self Talk",
];

Map<String, String> copingMethodsWithImages = {
  "Walking": 'assets/images/coping_skills/walking.png',
  "Call a Friend": 'assets/images/coping_skills/phonecall.png',
  "Listen to music": 'assets/images/coping_skills/headphones.png',
  "Journalling": 'assets/images/coping_skills/journal.png',
  "Deep Breathing": 'assets/images/coping_skills/breathing.png',
  "Meditation": 'assets/images/coping_skills/meditation.png',
  "Activites": 'assets/images/coping_skills/painting.png',
  "Playing with a pet": 'assets/images/coping_skills/pets.png',
  "Splash water trick": 'assets/images/coping_skills/splashwater.png',
  "Hold a icecube": 'assets/images/coping_skills/ice.png',
  "Ask for help": 'assets/images/coping_skills/help.png',
  "Self Talk": 'assets/images/coping_skills/selftalk.png',
};

//? ref 53
class CopingDescriptions {
  static String getDescription(String copingMethod) {
    switch (copingMethod) {
      case "Walking":
        return "When you feel overwhelmed or just need a break from the world, taking a walk can really help. You can do this before or after school, or anytime your grown-ups are free to walk with you.\n\n"
            "During your walk, pay attention to:\n"
            "\n"
            "• What you hear: Listen for birds singing, leaves crunching, or the movement of the wind.\n"
            "• What you see: Look around and notice the colors around you, the shapes of the clouds, the wildlife, etc.\n"
            "• What you smell: Take a big whiff of the air and see if you can smell any flowers, grass, or food being cooked nearby.\n\n"
            "How can walking help you?\n"
            "\n"
            "• Concentration Boost: Walking can help you focus better.\n"
            "• Stress relief: Walking is like a mini vacation for your brain, it helps you relax and take a break from environments when you are stressed.\n"
            "• Fun exercise: Walking is a fun way to move your body and stay healthy.\n"
            "• Emotion control: Walking can help focus on your senses, which helps you control your emotions better.";
      case "Call a Friend":
        return "Calling a friend when you're feeling down can be a great way to boost your mood. It gives you a chance to talk about what's bothering you and get support from someone you trust.\n\n"
            "When you call a friend:\n"
            "\n"
            "• Listen to what your friend has to say and offer support in return.\n";
      default:
        return "Description not available";
    }
  }
}
