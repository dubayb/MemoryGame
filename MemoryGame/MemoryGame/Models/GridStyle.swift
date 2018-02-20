//
//  GridStyle.swift
//  MemoryGame
//
//  Created by Dubay, Bryan on 2/19/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import Foundation
import UIKit

enum GridStyle : String {
    case fiveByTwo = "5 X 2"
    case threeByFour = "3 X 4"
    case fourByFour = "4 X 4"
    case fourByFive = "4 X 5"
    func collectionViewLayout () -> (CGSize,Int){
        switch self {
        case .fiveByTwo:
            return (getSize(rowSize: 2) , 5)
        case .threeByFour:
            return (getSize(rowSize: 3) , 6)
        case .fourByFour:
            return (getSize(rowSize: 4) , 8 )
        case .fourByFive:
            return (getSize(rowSize: 4) , 10)
            
        }
    }
    
    func getSize(rowSize:CGFloat) -> CGSize {
        let screenBounds = UIScreen.main.bounds
        let widthAndheight = (screenBounds.width / rowSize) - 20
        return CGSize(width: widthAndheight, height: widthAndheight + 10)
    }
}
