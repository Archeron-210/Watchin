//
//  Show.swift
//  Watchin
//
//  Created by Archeron on 22/02/2022.
//

import Foundation

struct Show: ShowDetailFormatted {
// a Show is an object that ONLY implements ShowDetailFormatted: it allows to manipulate an object throughout the app that is purely a ShowDetailFormatted, without being an object that conforms to it, so at this state there are no computed properties

    var idFormatted: Int
    var nameFormatted: String
    var descriptionFormatted: String
    var descriptionSourceFormatted: String
    var startDateFormatted: String
    var countryFormatted: String
    var statusFormatted: String
    var imageStringUrlFormatted: String
    var genresFormatted: String
    var numberOfSeasons: String
    var numberOfEpisodes: String
    var platformFormatted: String
    var trackedFormatted: Bool


    // MARK: - Init
    // allows to create a Show with any object that conforms to ShowDetailFormatted

    init(showDetailFormatted: ShowDetailFormatted) {
        self.idFormatted = showDetailFormatted.idFormatted
        self.nameFormatted = showDetailFormatted.nameFormatted
        self.descriptionFormatted = showDetailFormatted.descriptionFormatted
        self.descriptionSourceFormatted = showDetailFormatted.descriptionSourceFormatted
        self.startDateFormatted = showDetailFormatted.startDateFormatted
        self.countryFormatted = showDetailFormatted.countryFormatted
        self.statusFormatted = showDetailFormatted.statusFormatted
        self.imageStringUrlFormatted = showDetailFormatted.imageStringUrlFormatted
        self.genresFormatted = showDetailFormatted.genresFormatted
        self.numberOfSeasons = showDetailFormatted.numberOfSeasons
        self.numberOfEpisodes = showDetailFormatted.numberOfEpisodes
        self.platformFormatted = showDetailFormatted.platformFormatted
        self.trackedFormatted = showDetailFormatted.trackedFormatted
    }


}
