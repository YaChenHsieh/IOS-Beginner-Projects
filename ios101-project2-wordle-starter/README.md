# Project 2 - *Wordle Pt. 2*

Submitted by: **YaChen Hsieh (Angel)**

**Wordle Pt. 2** 
The goal of this assignment is to implement a functional settings feature where users can modify four game settings through a Settings button and add a button on the left-hand side of the navigation bar to reset the game with the current settings.

Time spent: **10** hours spent in total

## Required Features

The following **required** functionality is completed:

- [v] User can change the number of letters per row (the length of the goal word)
- [v] User can change the numbers of rows on the board (how many guesses allowed)
- [v] User can select a new themed set to pull the goal word from
- [v] User can select "alien wordle", causing the goal word to change after each guess


The following **optional** features are implemented:

- [v] App displays a reset button on the top left to reset the game (but make no changes to the settings)

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough 
(https://youtu.be/a87fYBjbBG8) .

## Notes

| **Question** | **Explanation** |
|-------------|---------------|
| **Why use `as? String`?** | `settings[kWordThemeKey]` may be `nil` or not a `String`, so we need to safely check and unwrap it. |
| **Why use `WordTheme(rawValue:)`?** | The `settings` dictionary stores the theme as a `String`, but `WordTheme` is an `enum`. We use `rawValue` to convert the string into the corresponding `enum` case. |
| **Why use `if let`?** | If the conversion to `WordTheme` fails, the code inside the block won’t execute, preventing errors. |
| **Why use `self.goalWord = WordGenerator.generateGoalWord(with: theme)`?** | This ensures that a new goal word is generated based on the selected theme. |
| **Why print `"Failed to get theme from settings"` in `else`?** | To help with debugging and ensure that the settings dictionary contains the expected values. |

## License

    Copyright [2025] [YaChen Hsieh]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.