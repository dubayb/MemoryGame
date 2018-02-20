//
//  MemoryService.swift
//  MemoryGame
//
//  Created by Dubay, Bryan on 2/17/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import Foundation

struct MemoryService {
    var cards = [Card]()
    let allAnimals = ["cat","pig","horse","spider","ghostDog","bat","hen","cow","goldFish","fish"]
    var oneFlippedCardIndex : Int? {
        get {
            var checkedIndex: Int?
            for index in cards.indices {
                if cards[index].isFlipped {
                    if checkedIndex == nil {
                        checkedIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return checkedIndex
        }
        set {
            for index in cards.indices {
                self.cards[index].isFlipped = (index == newValue)
            }
        }
    }
    init(numberOfUniqueCards:Int) {
        fillCards(numberOfUniqueCards:numberOfUniqueCards)
    }
    mutating func fillCards(numberOfUniqueCards:Int)  {
        
        guard numberOfUniqueCards <= allAnimals.count else { return }
        for i in 0..<numberOfUniqueCards {
            self.cards.append(Card(isFlipped: false, hasBeenMatched: false, animal:allAnimals[i]))
        }
        self.cards.append(contentsOf: self.cards)
        self.cards.shuffle()
    }
    
    mutating func flipCard(index:Int ) {
        if !cards[index].hasBeenMatched {
            if let matchedIndex = oneFlippedCardIndex, matchedIndex != index {
                if cards[matchedIndex].animal == cards[index].animal {
                    cards[matchedIndex].hasBeenMatched = true
                    cards[index].hasBeenMatched = true
                }
                cards[index].isFlipped = true
            } else {
                oneFlippedCardIndex = index
            }
        }
    }
}
struct Card {
    var isFlipped = false
    var hasBeenMatched = false
    var animal: String
}
extension Array {
    mutating func shuffle() {
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random()
            }
        }
    }
}

