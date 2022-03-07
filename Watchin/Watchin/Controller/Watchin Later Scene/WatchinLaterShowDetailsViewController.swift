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
    @IBOutlet weak var deleteButton: UIButton!

    // MARK: - Properties

    var show: ShowDetailFormatted?
    var watchinShowRepository = WatchinShowRepository.shared

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonAspect(for: changePlatformButton)
        setButtonAspect(for: startWatchinItButton)
        setButtonAspect(for: deleteButton)
        displayShowDetails()
    }

    // MARK: - Actions

    @IBAction func changePlatformButtonTapped(_ sender: UIButton) {
        goToPlatformsPicker()
    }

    @IBAction func startWatchinItButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        deleteAlert()
    }

    // MARK: - Private

    private func displayShowDetails() {
        guard let show = show else {
            return
        }

        setImage()
        showTitleLabel.text = show.nameFormatted
        startDateAndStatusLabel.text = "\(show.startDateFormatted) - \(show.statusFormatted)"
        genresLabel.text = show.genresFormatted
        seasonsLabel.text = "\(show.numberOfSeasons) Seasons"
        episodesLabel.text = "\(show.numberOfEpisodes) Episodes"
        platformNameLabel.text = show.platformFormatted
    }

    private func setImage() {
        guard let show = show else {
            return
        }

        if let imageUrl = URL(string: show.imageStringUrlFormatted) {
            tvShowPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        }
    }

    private func goToPlatformsPicker() {
        guard let currentShow = show, let platformPickerViewController = self.storyboard?.instantiateViewController(identifier: "PlatformPickerViewController") as? PlatformPickerViewController else {
            return
        }
        platformPickerViewController.show = currentShow
        platformPickerViewController.delegate = self
        self.present(platformPickerViewController, animated: true)
    }

    private func deleteAndGoBackToWatchinLater() {
        guard let show = show else {
            return
        }
        watchinShowRepository.deleteWatchinShow(show: show)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - UI Aspect

    private func setButtonAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.titleLabel?.numberOfLines = 1
    }


    // MARK: - Alerts

    private func deleteAlert() {
        let alert = UIAlertController(title: "⚠️", message: "You are about to delete this show from your Watchin' later list. Are you sure ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteAndGoBackToWatchinLater()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

}

extension WatchinLaterShowDetailsViewController: PlatformPickerViewControllerDismissDelegate {
    func didDismiss() {
        guard let show = show else {
            return
        }
        self.show = watchinShowRepository.getWatchinShow(id: show.idFormatted)
        displayShowDetails()
    }
}
