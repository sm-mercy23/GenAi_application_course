with entry {
    let user_score = 0;
    let computer_score = 0;
    let round_num = 1;

    while round_num <= 3 {
        let choices = ["rock", "paper", "scissors"];
        let user_choice = input("Round {round_num} - Choose rock, paper, or scissors: ");
        let computer_choice = choices[rand.int(0, 2)];

        print("You chose: {user_choice}");
        print("Computer chose: {computer_choice}");

        if user_choice == computer_choice {
            print("It's a tie this round!");
        } elif (user_choice == "rock" and computer_choice == "scissors") or (user_choice == "paper" and computer_choice == "rock") or (user_choice == "scissors" and computer_choice == "paper") {
            print("You win this round!");
            user_score += 1;
        } else {
            print("Computer wins this round!");
            computer_score += 1;
        }

        print("---");
        round_num += 1;
    }

    print("\nFinal Score:");
    print("You: {user_score}");
    print("Computer: {computer_score}");

    if user_score > computer_score {
        print("You win the game!");
    } elif user_score < computer_score {
        print("Computer wins the game!");
    } else {
        print("It's a tie overall!");
    }
}
