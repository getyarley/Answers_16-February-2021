//By: Jeremy Yarley
//16 February 2021

//          PROBLEM 1
//Reverse a String

print("PROBLEM 1")
let forwardString: String = "Hello there"
print("Forward String: \(forwardString)")


//Brute force reverse String, O(n) NOTE: this also removes spaces
func bruteForceReverse(from forwardString: String) -> String {
    //Convert String to array of Character(s)
    let forwardCharacters: [Character] = Array(forwardString)
    var reversedCharacters: [Character] = []
    
    //Loop through Characters array backwards and append to new array
    for index in 0..<forwardCharacters.count {
        if forwardCharacters[forwardCharacters.count - 1 - index] != " " { //Removes spaces
            reversedCharacters.append(forwardCharacters[forwardCharacters.count - 1 - index]) //This was incorrect in my previous answer
        }
    }
    
    //Convert array of Character(s) to a String and return
    let reversedString = String(reversedCharacters)
    return reversedString
}


let bruteForceReversedString = bruteForceReverse(from: forwardString)
print("Brute force reversed String (spaces removed): \(bruteForceReversedString)")




//Faster method, go from both sides simultaniously. O(n/2), performs reverse operation in place.
//NOTE: This version doesn't remove spaces. I didn't add it here since I did it in the brute force method.
//      IF I did make it remove spaces, the spaces would need to be removed BEFORE the for loop, since the
//      size of the array will change once the spaces are removed, throwing off the loop sequence.
func fasterStringReverse(from forwardString: String) -> String {
    //Convert string to array of Character(s)
    var forwardCharacters: [Character] = Array(forwardString)
    
    //Loop through the array for half the length. One pointer at the end of the array and one at the beginning.
    //Swap the last character with the first character until both pointers reach the center.
    //Strings with an odd number round down when halfed, leaving the middle character in place, which is what we want anyways.
    for index in 0..<forwardCharacters.count/2 {
        let frontValue = forwardCharacters[index] //Placeholder for first pointer
        forwardCharacters[index] = forwardCharacters[forwardCharacters.count - 1 - index] //Move last Character to first place
        forwardCharacters[forwardCharacters.count - 1 - index] = frontValue //Move front value placeholder to the end
    }
    
    //Convert array of Character(s) to a String
    let reversedString = String(forwardCharacters)
    return reversedString
}


let fasterReversedString = fasterStringReverse(from: forwardString)
print("Faster method reversed String (spaces NOT removed): \(fasterReversedString)")





//          PROBLEM 2
// Given a paragraph and a list of banned words, return the most frequent word that is not in the list of banned words.
// It is guaranteed there is at least one word that isn't banned, and that the answer is unique.
// Words in the list of banned words are given in lowercase, and free of punctuation.

// Example:

// Input:
// paragraph = "Bob hit a ball, the hit ball flew far after it was hit."
// banned = ["hit"]
// Output: "ball"
// Explanation:
// "hit" occurs 3 times, but it is a banned word.
// "ball" occurs twice (and no other word does), so it is the most frequent non-banned word in the paragraph.

print("\nPROBLEM 2")

//Paragraph with all lowercase and punctuation removed
let paragraph: String = "bob hit a ball the hit ball flew far after it was hit"
let bannedWords: Set<String> = ["hit"] //Used as a Set instead of a dictionary, so we don't have to have an arbitrary value, save space.


//The method I was originally working on, it returns the most common non-banned word(s) in an array from the paragraph.
//This allows for more than one word to be the most common.
//A little under O(2n)
func getMostCommonWord(from paragraph: String, bannedWords: Set<String>) -> [String] {
    //Convert paragraph into an array of Strings, using the space Character as the separator
    let wordsArray = paragraph.split(separator: " ") //This converts to substrings
    
    //Dictionary containing every word and the number of times it occurs
    var wordsDict: [String: Int] = [:]
    
    //Loop through wordsArray and append to the wordsDict Dictionary
    for word in wordsArray { //O(n)
        //Check to make sure the word isn't banned
        if !bannedWords.contains(String(word)) {
            //Word is NOT banned
            
            //Check to see if the word has already been encountered
            if let _ = wordsDict[String(word)] {
                wordsDict[String(word)]! += 1 //NOT first occurence, add one to the value
            } else {
                wordsDict[String(word)] = 1 //First occurence, add word to wordDict
            }
        }
    }
    
    
    var mostCommonWords: [String] = []
    var largestOccurence: Int = 0
    
    //Loop through Dictionary and get the most common words
    for (word, count) in wordsDict { //Slightly less than O(n);
                                    //e.g. O(m), (where m = #values in wordsDict) = O(n) - (#duplicate words) - (banned word occurences)
        //Check if count is largest
        if count > largestOccurence {
            mostCommonWords = [word] //Set mostCommonWords Array to the word
            largestOccurence = count //Set largestOccurence to the number of occurences
        } else if count == largestOccurence {
            //A word is found that has the same number of occurences as the largest
            mostCommonWords.append(word) //Add word to mostCommonWords
            //No need to update largestOccurence
        }
    }
    
    return mostCommonWords
}


//Simply print the most common words, prevents writing logic twice for both examples below.
func printMostCommonWords(from words: [String]) {
    if words.count > 1 {
        print("There are multiple most common words, and they are: \(words)")
    } else {
        print("The most common word is: \(words[0])")
    }
}



//SOLUTION 1: Only one word has the maximum occurences
let mostCommonWords = getMostCommonWord(from: paragraph, bannedWords: bannedWords)
print("Paragraph: \(paragraph)")
printMostCommonWords(from: mostCommonWords)



//SOLUTION 2: Multiple words have the same maximum occurence
//            Paragraph updated to add another occurence of 'bob'
let multiplesParagraph: String = "bob hit a ball the hit ball flew far after it was hit by bob"
let multipleCommonWords = getMostCommonWord(from: multiplesParagraph, bannedWords: bannedWords)
print("\nSecond Paragraph: \(multiplesParagraph)")
printMostCommonWords(from: multipleCommonWords)



