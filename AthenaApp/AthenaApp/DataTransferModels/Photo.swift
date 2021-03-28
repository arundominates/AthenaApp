//
//  Photo.swift
//  AthenaApp
//
//  Created by Arun Satyavan on 26/03/21.
//

import Foundation

struct Album: Codable {
    let title: String
    let link: String
    let albumDescription: String
    let modified: String
    let generator: String
    let items: [Photo]

    enum CodingKeys: String, CodingKey {
        case title, link
        case albumDescription = "description"
        case modified, generator, items
    }
}

struct Photo: Codable {
    let title, link: String
    let media: Media
    let dateTaken: String
    let itemDescription: String
    let published: String
    let author, authorID, tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case itemDescription = "description"
        case published, author
        case authorID = "author_id"
        case tags
    }
}

struct Media: Codable {
    let m: String
}

