//
//  SegueExtension.swift
//  Library
//
//  Created by Dubay, Bryan on 4/12/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import Foundation

import UIKit
import Foundation
//getting rid of those nasty string-y segue ids
protocol SegueHandlerType {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController,
    SegueIdentifier.RawValue == String
{
    
    func performSegueWithIdentifier(segueIdentifier: SegueIdentifier,
                                    sender: AnyObject?) {
        
        performSegue(withIdentifier: segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        
        // extracting error handling here
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("Invalid segue identifier \(String(describing: segue.identifier)).") }
        
        return segueIdentifier
    }
}
