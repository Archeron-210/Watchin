//
//  WatchinLaterShowDetailsViewController.swift
//  Watchin
//
//  Created by Archeron on 07/03/2022.
//

import UIKit

class WatchinLaterShowDetailsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var startDateAndStatusLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var platformNameLabel: UILabel!
    @IBOutlet weak var changePlatformButton: UIButton!
    @IBOutlet weak var startWatchinItButton: UIButton!

    // MARK: - Properties

    var show: ShowDetailFormatted?
    var watchinShowRepository = WatchinShowRepository.shared

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Actions

    @IBAction func changePlatformButtonTapped(_ sender: UIButton) {
    }

    @IBAction func startWatchinItButtonTapped(_ sender: UIButton) {
    }

    // MARK: - Private


    // MARK: - Alerts

}
