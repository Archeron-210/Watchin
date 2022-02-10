//
//  SearchResult.swift
//  Watchin
//
//  Created by Archeron on 10/02/2022.
//

import Foundation

// MARK: - Data Mapping From API JSON Response

struct SearchResult: Decodable {
    var tv_shows: [TvShowsSearchDetail]
}

struct TvShowsSearchDetail: Decodable {
    var id: String
    var name: String
    var apiFormatedName: String
    var image: String

    // setting coding keys to custom property names :
    private enum CodingKeys: String, CodingKey {
        case id, name, apiFormatedName = "permalink", image = "image_thumbnail_path"
    }

}
