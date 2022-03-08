//
//  ShowResultDetailsViewController.swift
//  Watchin
//
//  Created by Archeron on 11/02/2022.
//

import UIKit

class ShowResultDetailsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var seasonCountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var addToYourShowsButton: UIButton!
    @IBOutlet weak var addToWatchinLaterButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!

    // MARK: - Properties

    var show: ShowDetailFormatted?
    var episodes: [EpisodeFormatted]?
    private let aspectSetter = AspectSettings.shared
    private let watchinShowRepository = WatchinShowRepository.shared
    private let episodeDetailRepository = EpisodeDetailRepository.shared

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAddToYourShowsButton()
        configureAddToWatchinLaterButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        aspectSetter.setButtonBasicAspect(for: addToYourShowsButton)
        aspectSetter.setButtonBasicAspect(for: addToWatchinLaterButton)
        aspectSetter.setButtonBasicAspect(for: seeMoreButton)
        displayShowDetails()
    }

    // MARK: - Actions

    @IBAction func addToYourShowsButtonTapped(_ sender: UIButton) {
        saveShowToYourShows()
        configureAddToYourShowsButton()
    }

    @IBAction func addToWatchinLaterButtonTapped(_ sender: UIButton) {
        watchinLaterPlatformPickerViewAlert()
        configureAddToWatchinLaterButton()
    }

    @IBAction func seeMoreButtonTapped(_ sender: UIButton) {
        goToWebsite()
    }

    // MARK: - Private

    private func displayShowDetails() {
        guard let show = show else {
            return
        }

        aspectSetter.setImage(for: show, on: tvShowPosterImageView)
        showTitleLabel.text = show.nameFormatted
        yearLabel.text = show.startDateFormatted
        genresLabel.text = show.genresFormatted
        countryLabel.text = show.countryFormatted
        statusLabel.text = "Status: \(show.statusFormatted)"
        descriptionLabel.text = show.descriptionFormatted
        displayCorrectSeasonInfo()
    }

    private func displayCorrectSeasonInfo() {
        guard let show = show else {
            return
        }
        let intNumberOfSeasons = Int(show.numberOfSeasons) ?? 0
        if intNumberOfSeasons > 1 {
        seasonCountLabel.text = "\(show.numberOfSeasons) Seasons"
        } else {
            seasonCountLabel.text = "\(show.numberOfSeasons) Season"
        }
    }

    private func saveShowToYourShows() {
        guard let show = show else {
            return
        }
        let success = watchinShowRepository.saveWatchinShow(show: show)
        if success {
            saveEpisodes()
            watchinShowRepository.updateShowTrackedStatus(show: show)
            successAlert(message: "Added to your shows ! 📺")
        } else {
            errorAlert(message: "We were unable to add this show to your shows, please check if you did not already save it.")
        }
    }

    private func saveEpisodes() {
        guard let episodes = episodes, let show = show else {
            return
        }
        for episode in episodes {
            episodeDetailRepository.saveEpisodeDetail(for: episode, of: show)
        }
    }

    private func saveShowToWatchinLater() {
        guard let show = show else {
            return
        }
        let success = watchinShowRepository.saveWatchinShow(show: show)

        if success {
            saveEpisodes()
        } else {
            errorAlert(message: "We were unable to add this show to Watchin' Later, please check if you did not already save it to your shows in your Home page !")
        }
    }

    private func goToWebsite() {
        guard let show = show else {
            return
        }
        guard let url = URL(string: show.descriptionSourceFormatted) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    private func savePlatform(from pickerView: UIPickerView) {
        guard let show = show else {
            return
        }
        let platformIndex = pickerView.selectedRow(inComponent: 0)
        let platform = sortedPlatformNames[platformIndex]
        watchinShowRepository.updateWatchinShowPlatform(show: show, platform: platform)
    }

    private func createPlatformsPickerView(for alert: UIAlertController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addSubview(pickerView)

        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 25),
            pickerView.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -50)
        ])

        pickerView.dataSource = self
        pickerView.delegate = self

        return pickerView
    }

    // MARK: - Alerts

    private func successAlert(message: String) {
        let alert = UIAlertController(title: "✅", message: message, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.dismiss(animated: true)
          }
    }

    private func errorAlert(message: String) {
        let alert = UIAlertController(title: "❌", message: message, preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }

    private func watchinLaterPlatformPickerViewAlert() {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.isModalInPresentation = true
        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: "Kohinoor Telugu", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor(red: 61, green: 176, blue: 239)]
        let titleString = NSAttributedString(string: "Please select a platform :", attributes: titleAttributes)
        alert.setValue(titleString, forKey: "attributedTitle")

        let pickerView = createPlatformsPickerView(for: alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (UIAlertAction) in

            self.saveShowToWatchinLater()
            self.savePlatform(from: pickerView)
            self.configureAddToWatchinLaterButton()
                }))
                self.present(alert,animated: true, completion: nil )
    }

    // MARK: - UI Aspect

    private func configureAddToYourShowsButton() {
        guard let show = show else {
            return
        }

        let isSavedToYourShows = watchinShowRepository.isInYourShows(show: show)
        let title = isSavedToYourShows ? "Added to your shows !" : "Add to your shows"
        let color = isSavedToYourShows ? UIColor(red: 61, green: 176, blue: 239) : UIColor.white
        let backgroundColor = isSavedToYourShows ? UIColor.white : UIColor.clear

        addToYourShowsButton.setTitle(title, for: .normal)
        addToYourShowsButton.setTitleColor(color, for: .normal)
        addToYourShowsButton.tintColor = color
        addToYourShowsButton.backgroundColor = backgroundColor
        addToYourShowsButton.isEnabled = !isSavedToYourShows
        addToWatchinLaterButton.isEnabled = !isSavedToYourShows
    }

    private func configureAddToWatchinLaterButton() {
        guard let show = show else {
            return
        }

        let isInWatchinLater = watchinShowRepository.isInWatchinLater(show: show)
        let title = isInWatchinLater ? "Added to Watchin' Later !" : "Add to Watchin' Later"
        let color = isInWatchinLater ? UIColor(red: 61, green: 176, blue: 239) : UIColor.white
        let backgroundColor = isInWatchinLater ? UIColor.white : UIColor.clear

        addToWatchinLaterButton.setTitle(title, for: .normal)
        addToWatchinLaterButton.setTitleColor(color, for: .normal)
        addToWatchinLaterButton.tintColor = color
        addToWatchinLaterButton.backgroundColor = backgroundColor
        addToWatchinLaterButton.isEnabled = !isInWatchinLater
        addToYourShowsButton.isEnabled = !isInWatchinLater
    }
}

    // MARK: - PickerView Management

extension ShowResultDetailsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortedPlatformNames.count
    }

}

extension ShowResultDetailsViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = sortedPlatformNames[row]
        pickerLabel.font = UIFont(name: "Kohinoor Telugu", size: 25)
        pickerLabel.textColor = UIColor(red: 61, green: 176, blue: 239)
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
}
