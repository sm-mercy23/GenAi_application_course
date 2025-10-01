with entry quiz_bot {
    has topic: str;
    has question: str;
    has user_answer: str;
    has evaluation: str;
    has score: int = 0;

    topic = input("🎓 What topic would you like a quiz on? (e.g. history, science, tech): ");

    print(f"\nGreat! Let’s start a 5-question quiz on {topic}.\n");

    # Ask 5 questions
    for i = 1 to 5 {
        print(f"\nQuestion {i}:");

        # Generate a quiz question from the LLM
        question = llm.call(prompt=f"Give me one quiz question about {topic}. Only the question, no answer.");
        print(question);

        user_answer = input("Your answer: ");

        # Let LLM check and evaluate the answer
        evaluation = llm.call(
            prompt=f"Question: {question}\nUser’s Answer: {user_answer}\n"
                   f"Evaluate if this answer is correct or not. "
                   f"Reply with: Correct, Incorrect, or Partially Correct, and explain briefly."
        );

        print("Evaluation:");
        print(evaluation);

        # Update score if correct
        if "Correct" in evaluation:
            score += 1
    }

    # Final results
    print("\n🎉 Quiz Over!");
    print(f"Your final score: {score} out of 5");
    
    if score == 5:
        print("🏆 Perfect! You’re a genius!");
    elif score >= 3:
        print("👏 Well done! You passed the quiz.");
    else:
        print("💡 Keep practicing, you’ll get better!");
}
