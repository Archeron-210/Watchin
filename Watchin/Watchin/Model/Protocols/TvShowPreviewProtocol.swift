//
//  TvShowPreviewProtocol.swift
//  Watchin
//
//  Created by Archeron on 11/02/2022.
//

import Foundation

protocol TvShowPreview {
    var id: Int { get }
    var name: String { get }
    var imageUrl: URL? { get }
    var apiFormatedName: String { get }
    var country: String { get }

    // A MODIFIER - SUPPRIMER
    var watchedEpisodes: String { get }
    var platformAssociated: String { get }
}
