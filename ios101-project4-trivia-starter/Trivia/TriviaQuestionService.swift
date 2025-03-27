//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Ya-chen Hsieh on 3/26/25.
//

//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Ya-chen Hsieh on 3/26/25.
//

import Foundation

// MARK: - API Response Models

/// Represents the entire JSON response from the API.
struct TriviaResponse: Decodable {
    let response_code: Int
    let results: [TriviaResult]
}

/// Represents one trivia question from the API.
struct TriviaResult: Decodable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

// MARK: - TriviaQuestionService

/// A service that fetches and parses trivia questions from the Open Trivia Database API.
class TriviaQuestionService {
    
    /// Fetches trivia questions from the API.
    /// - Parameters:
    ///   - amount: Number of questions to fetch (default is 10).
    ///   - completion: Closure that returns an array of `TriviaQuestion` or an error.
    func fetchQuestions(amount: Int = 10, completion: @escaping ([TriviaQuestion]?, Error?) -> Void) {
        // Build the API URL with query parameters.
        let urlString = "https://opentdb.com/api.php?amount=\(amount)&category=9&difficulty=easy&type=multiple"
//            "https://opentdb.com/api.php?amount=\(amount)&category=12&difficulty=easy&type=boolean"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: -1, userInfo: nil))
            return
        }
        
        // Create a data task to download data.
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Return error if one occurs.
            if let error = error {
                completion(nil, error)
                return
            }
            // Ensure data is received.
            guard let data = data else {
                completion(nil, NSError(domain: "No data", code: -1, userInfo: nil))
                return
            }
            
            do {
                // Decode the JSON into a TriviaResponse object.
                let decoder = JSONDecoder()
                let triviaResponse = try decoder.decode(TriviaResponse.self, from: data)
                
                // Map API questions to our TriviaQuestion model.
                let questions: [TriviaQuestion] = triviaResponse.results.map { result in
                    return TriviaQuestion(
                        category: result.category,
                        question: self.decodeHTMLEntities(result.question),
                        correctAnswer: self.decodeHTMLEntities(result.correct_answer),
                        incorrectAnswers: result.incorrect_answers.map { self.decodeHTMLEntities($0) }
                    )
                }
                
                // Return the parsed questions.
                completion(questions, nil)
            } catch {
                // Return a decoding error.
                completion(nil, error)
            }
        }
        task.resume() // Start the network request.
    }
    
    /// Decodes HTML entities in a string (e.g., &quot; or &#039;) to proper characters.
    /// - Parameter text: The string with HTML entities.
    /// - Returns: The decoded string.
    private func decodeHTMLEntities(_ text: String) -> String {
        guard let data = text.data(using: .utf8) else { return text }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch {
            return text
        }
    }
}
