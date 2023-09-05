//
//  News.swift
//  CryptopiaAPI
//
//  Created by İrem Onart on 25.08.2023.
//

import Foundation

public struct News: Codable {
    public let articles: [New]
}

public struct New: Codable {
    public let source: Source
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?
}

public struct Source: Codable {
    public let name: String?
}
