//
//  ShowResultDetailsViewController.swift
//  Watchin
//
//  Created by Archeron on 11/02/2022.
//

import UIKit

class ShowResultDetailsViewController: UIViewController {

    // MARK: - Properties

    var tvShow: TvShowPreview?

    // MARK: - Outlets
    @IBOutlet weak var tvShowPoster: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var seeDescriptionButton: UIButton!
    @IBOutlet weak var numberOfSeasonsLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var addToYourTvShowsButton: UIButton!
    @IBOutlet weak var addToWatchinLaterButton: UIButton!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonAspect(for: seeDescriptionButton)
        setButtonAspect(for: addToYourTvShowsButton)
        setButtonAspect(for: addToWatchinLaterButton)

    }

    // MARK: - Actions

    // MARK: - Private

    private func setButtonAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
    }

}
