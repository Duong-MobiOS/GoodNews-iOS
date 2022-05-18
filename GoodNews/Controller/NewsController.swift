//
//  NewsController.swift
//  GoodNews
//
//  Created by Mai Duong on 18/05/2022.
//

import Foundation
import UIKit
import WebKit

class NewsController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    var urlString: String = ""
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleBar()
        let myURL = URL(string:urlString)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    private func setupTitleBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
 
}
