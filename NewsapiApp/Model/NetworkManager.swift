//
//  NetworkManager.swift
//  NewsapiApp
//
//  Created by Igor Skripnik on 13.02.2019.
//  Copyright © 2019 garik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    override private init() {
        
    }
    

    func loadNews(filters:Dictionary<String,String>, completionHandler: @escaping ([Article]) -> Void) {
        
        var filtersString = ""
        for filter in filters {
            filtersString.append("&")
            filtersString.append("\(filter.key)=\(filter.value)")
        }
       
        let url = URL(string: "https://newsapi.org/v2/top-headlines?sortBy=publishedAt\(filtersString)&apiKey=7f690f05d66b43b6b2b3d39c7fda41bb")

        Alamofire.request(url!)
            .responseJSON { response in
                
                //есть ли данные
                 guard let data = response.data else {
                    completionHandler([])
                    return
                }
                
                //есть ли JSON
                guard let rootDictionaryAny = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
                    completionHandler([])
                    return
                    }
                
                
                //преобразование к типу и проверка
                guard let rootDictionary = rootDictionaryAny as? Dictionary<String, Any> else {
                    completionHandler([])
                    return
                }
                
                
                //если все ок - записываем новость в массив
                if let array = rootDictionary["articles"] as? [Dictionary <String, Any>] {
                    var returnArray: [Article] = []
                    for dict in array {
                        let newArticle = Article(dictionary: dict)
                        returnArray.append(newArticle)
                    }
                    completionHandler(returnArray)
                    return
                }
                
                completionHandler([])
        }
    }
}
