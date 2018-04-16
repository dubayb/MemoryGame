//
//  Networkable.swift
//  Library
//
//  Created by Dubay, Bryan on 4/11/18.
//  Copyright © 2018 Bryan Dubay. All rights reserved.
//

import Foundation

enum Result<A> {
    case Value(A)
    case Error(Error)
}
enum HTTPMethod : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
protocol Networkable {
}
extension Networkable {
    
    func deleteData(url:String,completion: @escaping (BookResult)->Void) {
        let aurl:URL = URL(string: url)!
        var request = URLRequest(url: aurl)
        request.httpMethod = HTTPMethod.delete.rawValue
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response)
            if error != nil {
                completion(BookResult.Failure)
            } else {
                completion(BookResult.Success)
            }
        }
        task.resume()
    }
    func updateBookParams (checkedOutBy:String) -> Data? {
        let bookDict = ["lastCheckedOutBy": checkedOutBy] as [String:Any]
        do {
            return try JSONSerialization.data(withJSONObject: bookDict, options: [])
        }
        catch {
            return nil
        }
    }
    func addBookParams (book:Book) -> Data?{
        let bookDict = ["author":book.author!,"categories":book.categories!,"title":book.title!,"publisher":book.publisher!] as [String : Any]
        do {
            return try JSONSerialization.data(withJSONObject: bookDict, options: [])
        }
        catch {
            return nil
        }
    }
    func loadModelData<T: Decodable>( decodingType: T.Type, method:HTTPMethod,url:String,params:Data? = nil, completion:@escaping ( Result<Any> ) -> Void ){
        let aurl:URL = URL(string: url)!
        var request = URLRequest(url: aurl)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method.rawValue
        if params != nil{
          request.httpBody = params
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                //save nav data
                if error != nil {
                    completion(Result.Error(error!))
                }
                let jsonDecoder = JSONDecoder()
                let apiBase = try jsonDecoder.decode(decodingType, from: data!)
                completion(Result.Value(apiBase as Any))
            } catch {
                completion(Result.Error(error))
            }
        }
        task.resume()
    }
    
}
