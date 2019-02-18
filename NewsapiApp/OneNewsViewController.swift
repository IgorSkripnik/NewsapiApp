//
//  OneNewsViewController.swift
//  NewsapiApp
//
//  Created by Igor Skripnik on 14.02.2019.
//  Copyright © 2019 garik. All rights reserved.
//

import UIKit
import SafariServices

class OneNewsViewController: UIViewController {

    var article: Article!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelDiscription: UILabel!
    
    @IBAction func actionOpenInSafari(_ sender: Any) {
        
        if let url = URL(string: article.url) {
        
            //create
            let svc = SFSafariViewController(url: url)
        
            //show
            present(svc, animated: true, completion: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTitle.text = article.title
        labelDiscription.text = article.description
        
        //загружаю картинку в отдельном потоке
        DispatchQueue.main.async {
            if let url = URL(string: self.article.urlToImage) {
                if let data = try? Data(contentsOf: url) {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
        
        if URL(string: article.url) == nil {
            //скрыть кнопку "open to safari"
            
//            вынести аутлет и enabled
        }
    }
    

}
