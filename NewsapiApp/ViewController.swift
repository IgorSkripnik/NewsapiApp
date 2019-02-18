//
//  ViewController.swift
//  NewsapiApp
//
//  Created by Igor Skripnik on 13.02.2019.
//  Copyright © 2019 garik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var articles : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //show loader
        
        NetworkManager.shared.loadNews(filters: [:]) { [weak self] (result) in
            //hide loder
            self?.articles = result
            self?.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let article = self.articles[indexPath.row]
        cell?.textLabel?.text = article.title
        cell?.detailTextLabel?.text = article.description
        
        return cell!
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToOneNews", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToOneNews" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                (segue.destination as! OneNewsViewController).article = self.articles[indexPath.row]
            
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}

