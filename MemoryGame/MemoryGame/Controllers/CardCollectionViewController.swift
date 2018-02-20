//
//  CardCollectionViewController.swift
//  MemoryGame
//
//  Created by Dubay, Bryan on 2/17/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
class CardCollectionViewController: UICollectionViewController {

    var memoryService : MemoryService!
    var collectionSize: CGSize!
    var numberOfUniqueCards: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.black
        memoryService = MemoryService(numberOfUniqueCards: numberOfUniqueCards)
        collectionLayout()
        configureNavBarWithBackButton()
    }
    func configureNavBarWithBackButton(){
       
        let backButton = #imageLiteral(resourceName: "backNavBlue")
        let backButtonImage = backButton.stretchableImage(withLeftCapWidth: 0, topCapHeight: 10)
        let backButtonImageView = UIImageView.init(image: backButtonImage)
        backButtonImageView.contentMode = .scaleAspectFit
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(CardCollectionViewController.goBackToLobby))
        backButtonImageView.addGestureRecognizer(tapGesture)
        backButtonImageView.image = backButtonImage
        let barButton = UIBarButtonItem.init(customView:backButtonImageView)
        self.navigationItem.leftBarButtonItem = barButton

    }
    @objc func goBackToLobby()  {
        self.navigationController?.popViewController(animated: true)
    }
    func collectionLayout(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView!.collectionViewLayout = layout
    }
}
// MARK: UICollectionViewDataSource & Delegate
extension CardCollectionViewController {
    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memoryService.cards.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCollectionViewCell
        let card = memoryService.cards[indexPath.item]
        if card.isFlipped {
            cell.cardImageView.image = UIImage.init(named: memoryService.cards[indexPath.item].animal)
        } else {
            cell.cardImageView.image = #imageLiteral(resourceName: "0-cardBack")
        }
        if card.hasBeenMatched {
           cell.cardImageView.image = UIImage.init(named: memoryService.cards[indexPath.item].animal)
        }
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        memoryService.flipCard(index: indexPath.item)
        collectionView.reloadData()
    }
}
extension CardCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionSize
    }
}
// MARK: UICollectionViewDelegate

