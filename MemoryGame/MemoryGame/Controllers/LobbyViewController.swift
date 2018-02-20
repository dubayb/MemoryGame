//
//  LobbyViewController.swift
//  MemoryGame
//
//  Created by Dubay, Bryan on 2/17/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import UIKit

private let segueID = "ShowCardView"

class LobbyViewController: UIViewController {
    
    @IBOutlet var gridButtons : [UIButton]!
    
    override func viewDidLoad() {
        for button in gridButtons {
            button.backgroundColor = .clear
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBAction func gridStyleChosen(_ sender: UIButton) {
        guard let gridStyle = sender.titleLabel?.text else {  assertionFailure("nil grid style"); return}
        let gridSelection = GridStyle(rawValue:gridStyle)?.collectionViewLayout()
        performSegue(withIdentifier: segueID, sender: gridSelection)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CardCollectionViewController {
            let gridSelection = sender as! (CGSize,Int)
            vc.collectionSize = gridSelection.0
            vc.numberOfUniqueCards = gridSelection.1
        }
    }
}


