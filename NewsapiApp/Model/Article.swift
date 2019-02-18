//
//  Article.swift
//  NewsapiApp
//
//  Created by Igor Skripnik on 13.02.2019.
//  Copyright © 2019 garik. All rights reserved.
//

import Foundation

struct Article {
    var source: String
    var author: String
    var title: String
    var description: String
    var urlToImage: String
    
    var url: String //для сафари
    var publishedAt: String //для сортировки
    
    init(dictionary:Dictionary <String, Any>) {
    
        source = (dictionary["source"] as? Dictionary <String, Any> ?? ["":""])["name"] as? String ?? ""
        author = dictionary["author"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        urlToImage = dictionary["urlToImage"] as? String ?? ""
        
        url = dictionary["url"] as? String ?? ""
        publishedAt = dictionary["publishedAt"] as? String ?? ""
    }
}
