//
//  AddBookViewController.swift
//  Library
//
//  Created by Dubay, Bryan on 4/11/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController , Networkable{
    
    @IBOutlet var submitButton: UIButton!
    
    var viewModel: BooksViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 10
        submitButton.layer.borderWidth = 2
        submitButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        //if text fields arent empty create an array of them. if the array is empty
        let entries = bookEntry.filter { $0.text != "" }
        if entries.isEmpty {
            //go back without alert
            self.dismiss(animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Leave changes unsaved?", message: "", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default) { action in
                self.dismiss(animated: true, completion: nil)
            }
            let no = UIAlertAction(title: "NO", style: .default, handler:nil)
            alertController.addAction(ok)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func submitNewBook(_ sender: UIButton) {

        if bookEntry[0].text == "" || bookEntry[1].text == "" {
            let alertController = UIAlertController(title: "Author and Title required", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(ok)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let book = Book.init(title: bookEntry[0].text!, author: bookEntry[1].text!, publisher: bookEntry[2].text!, categories: bookEntry[3].text!)
            guard let params = self.addBookParams(book: book) else { return }
            
            self.loadModelData(decodingType: Book.self, method: .post, url: AppConstants.baseUrl + "books/", params:params) { (result) in
                switch result {
                case .Value(let book):
                    self.viewModel.books?.append(book as! Book)
                    self.dismiss(animated: true, completion: nil)
                case .Error(let error):
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
   
    @IBOutlet var bookEntry: [UITextField]!
    
}
