List<String> copingMethods = [
  "Walking",
  "Social Interaction",
  "Music",
  "Journalling",
  "Breathing",
  "Meditation",
  "Distractions",
  "Animals",
  "Water",
  "Hold a icecube",
  "Resources",
  "Help",
];

Map<String, String> copingMethodsWithImages = {
  "Walking": 'assets/images/coping_skills/walking.png',
  "Social Interaction": 'assets/images/coping_skills/phonecall.png',
  "Music": 'assets/images/coping_skills/headphones.png',
  "Journalling": 'assets/images/coping_skills/journal.png',
  "Breathing": 'assets/images/coping_skills/breathing.png',
  "Meditation": 'assets/images/coping_skills/meditation.png',
  "Distractions": 'assets/images/coping_skills/painting.png',
  "Animals": 'assets/images/coping_skills/pets.png',
  "Water": 'assets/images/coping_skills/splashwater.png',
  "Hold a icecube": 'assets/images/coping_skills/ice.png',
  "Resources": 'assets/icons/book.png',
  "Help": 'assets/images/coping_skills/help.png',
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
      //? Ref 56
      case "Journalling":
        return "\nJournaling is like writing down your thoughts and feelings in a book or even drawing them. It helps you understand your emotions better, feel less stressed, and make your mind feel calmer.\n"
            "How to journal:\n"
            "\n"
            "1. Find a quiet and comfortable place to write.\n"
            "2. Choose a journal or notebook that you like.\n"
            "3. Write about your thoughts, feelings, and how your day was etc.\n"
            "4. Be honest with yourself and don't worry about spelling or grammar.\n"
            "5. Try to write regularly, even if it's just a few sentences each day.\n"
            "\n"
            "Benefits of Journalling:\n"
            "\n"
            "• Helps you express your feelings and thoughts.\n"
            "• Allows you to understand yourself better.\n"
            "• Relieves stress and promotes emotional wellbeing.\n"
            "• Encourages self reflection and personal growth.\n"
            "• Allows you to track your moods and the triggers that cause this.\n"
            "\n"
            "The Big Feelings application offers a journalling tool, that allows you to write down your feelings, view and delete them. It also allows you to see when you have saved a journal.\n";
      //? Ref 57
      case "Breathing":
        return "Breathing is like taking big, deep breaths in and out. It helps you feel calm when you're feeling worried or scared.\n\n"
            "When you breathe in, you count to three in your head, and when you breathe out, you count to three again. \n"
            "\n"
            "How to practise your breathing:\n"
            "\n"
            "1. Find a quiet place where you feel comfortable.\n"
            "2. Sit or lie down in a relaxed position.\n"
            "3. Close your eyes if it helps you feel more peaceful.\n"
            "4. Take a slow, deep breath in through your nose, counting to three in your head.\n"
            "5. Then slowly breathe out through your mouth, counting to three again.\n"
            "6. Repeat this process several times."
            "\n"
            //? Ref 58
            "Example of a breathing technique: Yoga breathing\n"
            "\n"
            "Picture yourself as a bumblebee, softly buzzing as you breathe in and out. Feel your body becoming calm and peaceful.\n"
            "\n"
            "Or imagine you're blowing out birthday candles after a big tantrum. Take a deep breath, blow out slowly, and imagine collecting all your emotions like a big balloon.\n"
            "\n"
            "Or three-part breathing! Breathe in, fill up your belly, then your chest, then your throat. It's like giving your body a warm hug.\n"
            "\n"
            //? Ref 59
            "Benefits of practising breathing:\n"
            "\n"
            "• Relaxes the body.\n"
            "• Reduces stress and anxiety.\n"
            "• Calming effects caused by the increase of oxygen.\n"
            "• Improves your sleep quality.\n"
            "• Improves overall well being.\n"
            "\n"
            "The Big Feelings application offers a Breathing tool, that allows you to time your breathing with a breathing animation for 3 seconds in and 3 seconds out.\n";
      //? Ref 60
      case "Meditation":
        return "Meditation is like giving your mind a break from all the busyness and noise around you. It's a way to calm your thoughts and find peace within yourself.\n\n"
            //? Ref 61
            "How to meditate:\n"
            "\n"
            "1. Find a quiet and comfortable place to sit or lie down.\n"
            "2. Close your eyes gently or focus on a single point.\n"
            "3. Take slow, deep breaths, in through your nose and out through your mouth.\n"
            "4. Try to clear your mind of any distractions or worries, focusing only on your breath.\n"
            "5. If your mind wanders, gently bring your focus back to your breath without judgment.\n"
            "6. Continue for a few minutes or as long as you feel comfortable.\n"
            "\n"
            "Benefits of meditation:\n"
            "\n"
            "• Reduces stress and anxiety.\n"
            "• Improves focus and concentration.\n"
            "• Promotes emotional well being. \n"
            "• Enhances self-awareness.\n"
            "• Boosts overall health.\n"
            "• Relaxes the body.\n";
      //? Ref 62
      case "Distractions":
        return "Distractions are activities that help take your mind off negative thoughts or feelings, giving you a break from stress and anxiety. These activities capture your attention and bring enjoyment or relaxation.\n\n"
            "Examples of distraction activities:\n"
            "\n"
            "• Mindfulness Activities: Try deep breathing exercises \n"
            "• Painting  \n• Coloring.\n"
            "• Do things you enjoy.\n• Playing music. \n• Gardening. \n• Cooking. \n• Crafting.\n"
            "\n"
            "Benefits of distractions:\n"
            "\n"
            "• Gives temporary relief from stress and anxiety.\n"
            "• Takes your mind off negative thoughts.\n"
            "• Helps you relax and have fun.\n"
            "• Encourages doing things that make you feel good.\n"
            "\n"
            "The Big Feelings application offers a card mini emotion matching game, that allows you to distract yourself by having fun and focusing on the different emotions while learning about your emotions.\n";
      //? Ref 63
      case "Animals":
        return "Owning and caring for animals can be really helpful for your mental health. When you spend time with your pets, like playing with a dog or cuddling a cat, or watching a turtle swim around in a tank can help you feel happier and less stress.\n\n"
            "Benefits of caring for animals:\n"
            "\n"
            "• Increases physical activity.\n"
            "• Reduces anxiety.\n"
            "• Boosts your confidence.\n"
            "• Pets can make you feel like you have a friend when you feel alone.\n"
            "• Caring for a pet can introduce structure to your day and keep a daily routine.\n"
            "\n"
            "What if I do not own or can't have a pet?\n"
            "\n"
            "• Spend time with your friends/family's pets.\n"
            "• Visit zoos or animal sanctuaries to see and learn about different animnals.\n";
      case "Water":
        return "Water can have a soothing and calming effect on your mental well being. Whether it's splashing cold water on your face or having a warm bath, water based activities can help you relax and reduce stress.\n\n"
            "What water activites does this include?:\n"
            "\n"
            //? Ref 64
            "• Splashing cold water on your face\n"
            "• Taking a warm bath\n"
            "• Swimming in a pool\n"
            "• Relaxing by a waterfall or fountain or by the sea\n"
            "\n"
            //? Ref 65
            "Benefits of water based activities:\n"
            "• Refreshing\n"
            "• Allows you to stop and think and reset when splashing water in your face.\n"
            "• Decreases stress\n"
            "• Relaxes you, it could make you feel sleepy.\n"
            "• Improves mood\n"
            "• Provides sensory stimulation\n";
      //? Ref 66
      case "Hold a icecube":
        return "Holding an ice cube can be a simple yet effective way to manage overwhelming emotions and sensations. The sensation of cold can help ground you in the present moment and provide relief from intense feelings.\n\n"
            "How to hold an ice cube:\n"
            "\n"
            "1. Get an ice cube from the freezer.\n"
            "2. Hold it gently in your hand or fingers.\n"
            "3. Pay attention to the sensation of coldness on your skin.\n"
            "4. Focus on your breathing while holding the ice cube.\n"
            "5. Notice any changes in how you feel as you hold the ice cube.\n"
            "\n"
            "Benefits of holding an ice cube:\n"
            "\n"
            "• Immediate distraction: The icecube coldness distracts you from your feelings.\n"
            "• Calming effect: The cold sensation can help your body relax and feel calmer.\n"
            "• Sensory stimulation: Touching the ice cube can be interesting and calming for your senses.\n";
      //? Ref 67
      case "Help":
        return "If you're feeling sad or scared and need someone to talk to, it's important to talk to a grown-up you trust, like a parent, teacher, or school counselor. They can help you find the right kind of help.\n\n"
            "Here's what you can do if you need help:\n"
            "\n"
            "1. Talk to a Grown-up: Share how you're feeling with a grown-up you trust, like a parent or teacher. They can listen to you and help you figure out what to do next.\n"
            "\n"
            "2. Use Helplines: If you can't talk to a grown-up or need more help, there are special phone numbers you can call or text for help. \n• You can text SHOUT to 85258 \n• Call Childline on 0800 1111 \n• Call the Mix on 0808 808 4994.\n"
            "\n"
            "3. Talk to Your School Teachers: If you're at school, you can talk to your school teacher you feel comfortable with. They're trained to help kids like you and can find you the support you need.\n"
            "\n"
            "Remember, it's okay to ask for help when you need it, and there are people who care about you and want to support you through tough times.";

      default:
        return "Description not available";
    }
  }
}
