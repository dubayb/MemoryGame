//
//  BooksTableViewController.swift
//  Library
//
//  Created by Dubay, Bryan on 4/11/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController ,  Networkable {
    var viewModel : BooksViewModel!
    let reuseID = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = BooksViewModel.shared
        loadBookData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel = BooksViewModel.shared
        tableView.reloadData()
    }
    func loadBookData(){
        viewModel.getBooks { bookResult in
            switch bookResult {
            case .Failure :
                break
            case .Success :
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        let book = viewModel.books?[indexPath.row]
        cell.textLabel?.text = book?.title
        cell.detailTextLabel?.text = book?.author
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // MARK: TableView Editing
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let book = viewModel.books?[indexPath.row] {
                self.deleteData(url: AppConstants.baseUrl + "books/\(String(describing: book.id!))") { (result) in
                    switch result {
                    case .Failure:
                        break
                    case .Success:
                        self.viewModel.books!.remove(at: indexPath.row)
                        DispatchQueue.main.async {
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                }
            }
        }   
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segueIdentifierForSegue(segue: segue) {
        case .addBook:
            let addBookVC = segue.destination as! AddBookViewController
            addBookVC.viewModel = self.viewModel
        //segue withviewmodel
        case .bookDetail:
            let bookDetailVC = segue.destination as! BookDetailViewController
            guard let indexPath = sender as? IndexPath, let books = self.viewModel.books else { return }
            bookDetailVC.book = books[indexPath.row]
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = indexPath as AnyObject
        performSegueWithIdentifier(segueIdentifier: .bookDetail, sender: sender )
    }
    @IBAction func addBook(_ sender: UIBarButtonItem) {
        //modal to add book vc
        performSegueWithIdentifier(segueIdentifier: .addBook, sender: self)
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        if(self.tableView.isEditing == true) {
            self.tableView.setEditing(false, animated: true)
            sender.title = "Edit"
        }
        else {
            self.tableView.setEditing(true, animated: true)
            sender.title = "Done"
        }
    }
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        let url = AppConstants.baseUrl + "clean"
        self.deleteData(url: url) { (result) in
            switch result {
            case .Failure:
                break
            case .Success:
                self.viewModel.books!.removeAll()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension BooksTableViewController : SegueHandlerType{
    enum SegueIdentifier: String {
        case addBook
        case bookDetail 
    }
}
