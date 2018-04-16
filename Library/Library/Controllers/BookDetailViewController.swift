//
//  BookDetailViewController.swift
//  Library
//
//  Created by Dubay, Bryan on 4/12/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController ,Networkable{

    @IBOutlet var checkoutButton: UIButton!
    var book: Book!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkoutButton.layer.cornerRadius = 10
        checkoutButton.layer.borderWidth = 2
        checkoutButton.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        //bind book to labels
       updateBookLabels()
    }
    func updateBookLabels(){
        bookLabels[0].text = book.title
        bookLabels[1].text = book.author
        if let publisher = book.publisher {
          bookLabels[2].text = "Publisher: " + "\(String(describing: publisher))"
        }
        if let categories = book.categories {
           bookLabels[3].text = "Tags: " + "\(String(describing: categories ))"
        }
    
        guard let person = book.lastCheckedOutBy,
            let date = book.lastCheckedOut
            else { return }
        bookLabels[4].text = "Last Checked Out: " + "\(person)" + " @ " + date.checkOutDate()
    }
    @IBAction func shareBook(_ sender: UIBarButtonItem) {
        guard let title = book.title, let author = book.author, let publisher = book.publisher else { return }
        let activityViewController = UIActivityViewController(activityItems: [title,author,publisher], applicationActivities: nil)
        activityViewController.modalPresentationStyle = .popover
        present(activityViewController, animated: true, completion: nil)
        let popController = activityViewController.popoverPresentationController
        popController?.permittedArrowDirections = .any
        popController?.barButtonItem = sender as? UIBarButtonItem
    }
    @IBAction func checkoutAndUpdate(_ sender: UIButton) {
        //ask for name
        let alert = UIAlertController(title: "Check out book",
                                      message: "Enter your name",
                                      preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            // Get 1st TextField's text
            let param = self.updateBookParams(checkedOutBy:alert.textFields![0].text!)
//            param.encode
            guard let id = self.book.id else  { return }
            let url = AppConstants.baseUrl + "books/\(String(describing: id))"
            self.loadModelData(decodingType: Book.self, method: .put, url: url, params:param) { result in
                switch result {
                case .Error(let error) :
                    print(error.localizedDescription)
                case .Value(let book) :
                    DispatchQueue.main.async {
                        self.book = book as! Book
                        self.updateBookLabels()
                        self.goBack()
                    }
                }
            }
        })
        alert.addTextField { (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.placeholder = "Your name here"
            textField.clearButtonMode = .whileEditing
        }
        alert.addAction(submitAction)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    func goBack() {
        var sharedModelBooks = BooksViewModel.shared.books
        let index = sharedModelBooks?.index { $0.id == book.id }
        sharedModelBooks![index!].lastCheckedOutBy = self.book.lastCheckedOutBy
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var bookLabels: [UILabel]!
    

}


