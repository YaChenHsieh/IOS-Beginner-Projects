# Project 3 - *Trivia*

Submitted by: **YaChen Hsieh (Angel)**

**Trivia** is a simple quiz app where users answer multiple-choice questions, track their progress, and see their final score. It allows users to restart the game, and ensures a smooth question navigation experience.

Time spent: **10** hours spent in total

## Required Features

The following **required** functionality is completed:

- [v] User can view the current question and 4 different answers
- [v] User can view the next question after tapping an answer
- [v] User can answer at least 3 different questions


The following **optional** features are implemented:

- [ ] User can use the vertical orientation of the app on any device
- [v] User can track the question they are on and how many questions are left
- [v] User can see how many questions they got correct after answering all questions
- [v] User should be able to restart the game after they've finished answering all questions

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here is a reminder on how to embed Loom videos on GitHub. Feel free to remove this reminder once you upload your README. 

(https://youtu.be/HmkOmSCxIks) .

## Notes

1. UI set up, I followed the guide from (https://courses.codepath.org/courses/ios101/unit/3#!labs)

2. Adding a Button Using UIButton and IBAction
You can add a button to your storyboard using **UIButton** and connect it to your code with **IBAction**. Here’s how:

1. **Drag and Drop UIButton**  
   - Open **Main.storyboard** and find **UIButton** in the object library (`+` button).
   - Drag the **UIButton** to the desired location in your View Controller.

2. **Create an IBAction for the Button**  
   - (`⌥ + Click + TriviaViewController.swift`) so you can see both **Main.storyboard** and your Swift file (e.g., `TriviaViewController.swift`).
   - **Right-click (or control + click) the button**, then **drag it into your Swift file** inside the `TriviaViewController` class.
   - Select **"connection"** to pick if you want it to be a botton or Action
   - Choose **"Action"** and name it (e.g., `didTapButton`).
   - Set the **Type** to `UIButton`.

3. **Handle Button Tap in Code**  
   Once the connection is made, you can modify what happens when the button is tapped:
   ```swift
   @IBAction func didTapButton(_ sender: UIButton) {
       print("Button tapped: \(sender.currentTitle ?? "Unknown")")
   }
   ```
   Now, every time the button is tapped, it will print its title to the console.

---

### **3. Connecting Multiple Buttons to a Single IBAction**
Instead of creating separate actions for each button, you can **connect all four buttons to a single IBAction**. This reduces redundant code and makes it easier to manage.

**How to do it:**
1. **Create One IBAction for All Buttons**
   ```swift
   @IBAction func didTapAnswerButton(_ sender: UIButton) {
       guard let selectedAnswer = sender.currentTitle else { return }
       print("Selected answer: \(selectedAnswer)")
   }
   ```
2. **Connect All Buttons to This IBAction**
   - Open **Main.storyboard**.
   - **Control + drag** each button to the same `didTapAnswerButton(_:)` function.
   - This means **all buttons will trigger the same function when tapped**.

3. **Handle Different Button Presses**
   Inside the function, use `sender.currentTitle` to determine which button was tapped:
   ```swift
   let isCorrect = selectedAnswer == correctAnswer
   if isCorrect {
       print("Correct answer!")
   } else {
       print("Wrong answer.")
   }
   ```

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