//
//  SearchResult.swift
//  Watchin
//
//  Created by Archeron on 10/02/2022.
//

import Foundation

// MARK: - Data Mapping From API JSON Response

struct SearchResult: Decodable {
    var tv_shows: [ShowSearchDetail]
}

struct ShowSearchDetail: Decodable {
    var id: Int
    var name: String
    var country: String
    var apiFormatedName: String
    var imageStringUrl: String

    // setting coding keys to custom property names :
    private enum CodingKeys: String, CodingKey {
        case id, name, country, apiFormatedName = "permalink", imageStringUrl = "image_thumbnail_path"
    }

}

