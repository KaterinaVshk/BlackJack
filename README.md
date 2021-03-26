# BlackJack
This is an implementation of Blackjack in Ruby with the following house rules:

User and computer get 2 cards each.The value of cards two through ten is their pip value (2 through 10). Face cards (Jack, Queen, and King) are all worth ten.The ace is worth 11. A points is the sum of the card values. Players are allowed to draw additional cards to improve their score. When user stop taking new cards and his score is less than 21, computer takes cards one by one (max is 17).

The detailed outcome of the hand follows:

* If the player is dealt an Ace and a ten-value card (called a "blackjack" ), and the computer does not, the player wins and usually receives a bonus.
* If the player exceeds a sum of 21, the player loses, even if the computer also exceeds 21.
* If the computer exceeds 21 and the player does not, the player wins.
* If the player attains a final sum higher than the dealer and does not bust, the player wins.
* If both dealer and player receive a blackjack or any other hands with the same sum, no one wins.
