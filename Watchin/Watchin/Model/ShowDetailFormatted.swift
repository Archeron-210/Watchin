//
//  ShowDetailFormatted.swift
//  Watchin
//
//  Created by Archeron on 21/02/2022.
//

import Foundation

protocol ShowDetailFormatted {

    var idFormatted: Int { get }
    var nameFormatted: String { get }
    var descriptionFormatted: String { get }
    var descriptionSourceFormatted: String { get }
    var startDateFormatted: String { get }
    var countryFormatted: String { get }
    var statusFormatted: String { get }
    var imageStringUrlFormatted: String { get }
    var genresFormatted: String { get }
    var numberOfSeasons: String { get }
    var numberOfEpisodes: String { get }
    var watchedSeasons: Int { get }
    var watchedEpisodes: Int { get }
    var platform: String { get }

}
