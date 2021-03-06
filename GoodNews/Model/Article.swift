//
//  Article.swift
//  GoodNews
//
//  Created by DuongMT1.TCS on 5/13/22.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
    let author: String?
    let publishedAt: String?
    let content: String?
    let urlToImage: String?
    let url: String?
}


