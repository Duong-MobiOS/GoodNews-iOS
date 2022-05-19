//
//  DetailsNewsController.swift
//  GoodNews
//
//  Created by DuongMT1.TCS on 5/13/22.
//

import Foundation
import UIKit


class DetailsNewsController: UITableViewController {

    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerTableViewCells()
    }
    

    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always

        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=590f4a541501431bbad210b5e2a6c9e8")!
        
        Webservice().getArticles(url: url) { articles in
            if let articles = articles {
                self.articleListVM = ArticleListViewModel(articles: articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            }
            
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.authorLabel.text = articleVM.author
        cell.dateLabel.text = articleVM.publishedAt
        cell.newsImage.load(urlString: articleVM.urlToImage)
        cell.selectionStyle = .none
    
        return cell
    }
    
    private func registerTableViewCells() {
        let newCell = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        self.tableView.register(newCell, forCellReuseIdentifier: "ArticleTableViewCell")
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        
        if let newsVC = storyboard?.instantiateViewController(identifier: "NewsVC") as? NewsController {
            self.navigationController?.pushViewController(newsVC, animated: true)
            newsVC.urlString = articleVM.url
        }
    }
    
}

extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

