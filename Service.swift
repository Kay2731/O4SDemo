//
//  Service.swift
//  O4S
//
//  Created by Keertika on 06/02/21.
//  Copyright © 2021 keertika. All rights reserved.
//

import Foundation

enum APIError:Error{
    case internalError
    case parsingError
    case serverError
}


class Service{
    
    
     func request<T:Codable>(_ objectType: T.Type,urlString:String, completion:@escaping((Result<[T],APIError>)->Void)){
        guard let url = URL(string: urlString)
            else{ completion(.failure(.internalError));  return }
        
        var request = URLRequest(url:url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        
        call(T.self, request: request, completion: completion)
    }
    
    
     func call<T:Codable>(_ objectType: T.Type,request:URLRequest,completion:@escaping((Result<[T],APIError>)->Void)){
        let dataTask = URLSession.shared.dataTask(with:request){(data,response,error) in
            guard error == nil
                else{completion(.failure(.serverError)); return }
            
        do {
           guard let data = data
           else {completion(.failure(.serverError)); return   }
            let decoder = JSONDecoder()
             decoder.keyDecodingStrategy = .convertFromSnakeCase
           let object = try decoder.decode([T].self, from:data)
           completion(Result.success(object))
            } catch{
             completion(Result.failure(.parsingError))
            }
        }
        
        dataTask.resume()
    }
}
