# Product Requirements Document: Simple Blackjack

## 1. Overview

Build a single-player blackjack game against a dealer using the existing card and deck implementation.

The game must support:

- Starting from an empty state
- Starting a new game
- Placing a wager
- Initial dealing
- Player hit and stand actions
- Busts
- Dealer play
- Wins, losses, pushes, and blackjack payouts
- Bankroll management
- Multiple rounds
- Invalid actions and edge cases

The implementation should prioritize deterministic state management, clear transitions, and simple rules.

---

## 2. Scope

### Included

- One player
- One dealer
- One hand per player
- One wager per round
- Hit
- Stand
- Dealer resolution
- Blackjack detection
- Bust handling
- Payouts
- Bankroll minimum and maximum limits
- New game initialization

### Excluded

- Double down
- Splitting
- Insurance
- Surrender
- Side bets
- Multiple players
- Betting on ties
- Betting during an active round
- Card counting or shoe penetration logic
- Traditional card/deck implementation

---

## 3. Simplified Blackjack Rules

1. The player competes against the dealer.
2. Both player and dealer receive two cards.
3. The dealer's first card is hidden until dealer play begins.
4. Cards are valued using the existing card implementation.
5. Aces count as 1 or 11, whichever produces the highest valid hand value.
6. A hand is bust when its best possible value exceeds 21.
7. The player may repeatedly hit or stand.
8. The dealer must hit while their hand value is below 17.
9. The dealer must stand on 17 or higher, including soft 17.
10. A natural blackjack is exactly two cards totaling 21.
11. A player blackjack beats any non-blackjack dealer hand.
12. If both player and dealer have blackjack, the result is a push.
13. If the dealer has blackjack and the player does not, the player loses.
14. If the player busts, the player loses immediately and the dealer does not draw additional cards.
15. If neither hand busts, the higher total wins.
16. Equal totals result in a push.

---

## 4. Money Rules

### Bankroll

- Currency is represented internally in integer minor units, such as cents.
- Default starting balance: `$1,000.00`.
- Maximum balance: `$100,000.00`.
- Minimum balance: `$0.00`.
- Balance must never be negative.
- Any balance increase must be capped at `$100,000.00`.

### Wager

- Minimum wager: `$1.00`.
- Maximum wager: the lesser of:
  - The player's current balance
  - `$100,000.00`
- Wagers must be whole-dollar amounts.
- A wager cannot be placed when the balance is `$0.00`.
- A wager cannot be changed after the round begins.
- The wager is deducted from the bankroll when the round starts.

### Payouts

Payouts include returning the original wager:

| Result | Net Profit | Final Bankroll Change |
|---|---:|---:|
| Player blackjack | 3:2 of wager | `+1.5 × wager` |
| Player win | 1:1 of wager | `+1 × wager` |
| Push | 0 | `0`; original wager returned |
| Player loss | -1:1 of wager | `-1 × wager` |

Examples:

- `$10` blackjack: receive `$25` total; net profit is `$15`.
- `$10` regular win: receive `$20` total; net profit is `$10`.
- `$10` push: receive `$10`.
- `$10` loss: receive `$0`.

All payouts must be capped so the final bankroll does not exceed `$100,000.00`.

If a payout would exceed the cap, credit only the amount needed to reach the cap.

---

## 5. Game States

The game must use an explicit state machine.

### `EMPTY`

Initial state before a game has been started.

Properties:

- No active round
- No player hand
- No dealer hand
- No wager
- No bankroll, or bankroll is uninitialized

Allowed actions:

- `START_NEW_GAME`

---

### `BETTING`

A game exists and is waiting for the player to place a wager.

Properties:

- Bankroll is initialized
- No active round
- No cards have been dealt
- No wager has been placed

Allowed actions:

- `PLACE_BET`
- `START_NEW_GAME`, if restarting is supported

Transition:

```text
BETTING + PLACE\_BET -> PLAYER\_TURN or RESOLVED
