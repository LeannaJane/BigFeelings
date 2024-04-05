List<String> copingMethods = [
  "Walking",
  "Social Interaction",
  "Music",
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
  "Social Interaction": 'assets/images/coping_skills/phonecall.png',
  "Music": 'assets/images/coping_skills/headphones.png',
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

//? Ref 53
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
      //? Ref 54
      case "Social Interaction":
        return "Connecting with others through social interaction can significantly improve your mood and reduce feelings of isolation. Engaging in meaningful conversations, sharing experiences, and enjoying each other's company can provide emotional support and a sense of belonging.\n\n"
            "Talking to someone:\n"
            "\n"
            "1. Find a Quiet Place: Choose a quiet and comfortable place.\n"
            "2. Start the Conversation: Say, 'I'd like to talk to you about something.'\n"
            "3. Use Simple Words: Explain how you're feeling simply, like 'I feel sad because...'\n"
            "4. Share Your Thoughts: Tell them what's bothering you or what you need help with.\n"
            "5. Listen to Their Response: Pay attention to what they say.\n"
            "6. Say Thank You: Thank them for listening, like 'Thank you for listening to me.'\n"
            "7. Ask for Help if Needed: If you need more help, ask politely.\n"
            "8. Stay Calm and Patient: Be calm and patient during the conversation.\n"
            "9. Know When to Stop: If it's too much, it's okay to stop.\n"
            "\n"
            "Benefits of social interaction:\n"
            "\n"
            "• Emotional support: Sharing your thoughts and feelings with others can provide comfort and validation, helping you cope with stress more effectively.\n"
            "• Enhanced empathy: Understanding others perspectives can help develop empathy and compassion.\n"
            "• Making memories: Spending time with others creates happy memories that you can cherish.\n"
            "• Building confidence: Sharing your thoughts and feelings with others helps you feel brave,confident and can release stress off your shoulders.\n";
      //? Ref 55
      case "Music":
        return "Listening to music can help boost your wellbeing, reduce your stress and improve your daily performance\n\n"
            "Different types of music:\n"
            "\n"
            "• Light Jazz: Smooth and gentle tunes that help you relax.\n"
            "• Classical Music: Beautiful melodies that calm your mind.\n"
            "• Nature Sounds: Soothing sounds like rain or birds that make you feel peaceful.\n"
            "• Upbeat tunes: Happy music can make you feel positive and hopeful about things.\n"
            "\n"
            "Benefits of listening to music:\n"
            "\n"
            "• Mood Booster: Music can make you feel happier and more positive.\n"
            "• Stress Reducer: Listening to music can help you relax and feel less stressed.\n"
            "3. Improved Focus: Certain types of music can help you concentrate better, making it easier to get things done.\n"
            "\n"
            "How to find music/calming videos?\n"
            "\n"
            "• Explore music apps: Use apps like Spotify, Apple Music, or YouTube Music to discover different genres and playlists.\n"
            "• Search: Create searches like Mental health calming music, rain sounds, nature noises etc. \n";
      default:
        return "Description not available";
    }
  }
}
