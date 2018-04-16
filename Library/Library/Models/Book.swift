//
//  Book.swift
//  Library
//
//  Created by Dubay, Bryan on 4/11/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import Foundation

struct Book : Codable {
    var author : String?
    var categories : String?
    var title :String?
    var publisher: String?
    var id : Int?
    var lastCheckedOutBy: String?
    var lastCheckedOut: String?
    
    init (title:String,author:String,publisher:String,categories:String) {
        self.author = author
        self.title = title
        self.publisher = publisher
        self.categories = categories
    }
}
