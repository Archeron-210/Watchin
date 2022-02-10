//
//  SearchViewController.swift
//  Watchin
//
//  Created by Archeron on 07/02/2022.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setSearchButtonAspect()
        setTextFieldAspect()
        tableView.backgroundColor = UIColor.clear
    }

    // MARK: - Actions



    // MARK: - Private

    private func setSearchButtonAspect() {
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.white.cgColor
        searchButton.layer.cornerRadius = 10
    }

    private func setTextFieldAspect() {
        searchTextField.setBottomBorderAndPlaceholderTextColor()
    }

}

    // MARK: - KeyboardManagement

extension SearchViewController: UITextFieldDelegate {

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // retourne le tableau de séries.count
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell", for: indexPath) as? TvShowTableViewCell else {
            return UITableViewCell()
        }
        // à compléter
        cell.configure(poster: "watchinIcon", showTitle: "Show Title", watchedEpisodes: "Watched episodes: \n250/250", platform: "On: add platform")
        cell.backgroundColor = UIColor.clear


        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160.0
    }
    
}
