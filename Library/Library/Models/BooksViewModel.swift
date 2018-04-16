//
//  BooksViewModel.swift
//  Library
//
//  Created by Dubay, Bryan on 4/11/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import Foundation
enum BookResult {
    case Success
    case Failure
}
class BooksViewModel : Networkable  {
    static let shared = BooksViewModel()
    var books : [Book]?
    
    func getBooks(complete:@escaping (BookResult)->Void) {
        loadModelData(decodingType: [Book].self, method: .get, url: AppConstants.baseUrl + "books") { (result) in
            switch result{
            case .Value(let books):
                self.books = books as? [Book]
                complete(BookResult.Success)
            case .Error:
                complete(BookResult.Failure)
            }
        }
    }
       
}
