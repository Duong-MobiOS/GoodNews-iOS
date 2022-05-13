//
//  DetailsNewsController.swift
//  GoodNews
//
//  Created by DuongMT1.TCS on 5/13/22.
//

import Foundation
import UIKit

class DetailsNewsController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=590f4a541501431bbad210b5e2a6c9e8")!
        
        Webservice().getArticles(url: url) { _ in
            
        }
        
    }
    
}
