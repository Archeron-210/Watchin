//
//  PlatformPickerViewController.swift
//  Watchin
//
//  Created by Archeron on 01/03/2022.
//

import UIKit

class PlatformPickerViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var platformPickerView: UIPickerView!
    @IBOutlet weak var exitButton: UIButton!

    // MARK: - Properties

    private let watchinShowRepository = WatchinShowRepository.shared
    var show: ShowDetailFormatted?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setContainerViewAspect()
        setButtonAspect(button: doneButton)
        setButtonAspect(button: exitButton)
    }

    // MARK: - Action

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        savePlatform()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Private

    private func savePlatform() {
        guard let show = show as? WatchinShow else {
            return
        }
        let platformIndex = platformPickerView.selectedRow(inComponent: 0)
        let platform = sortedPlatformNames[platformIndex]

        show.platform = platform
        watchinShowRepository.saveModifications()
    }
    
    // MARK: - UIAspect

    private func setContainerViewAspect() {
        pickerContainerView.layer.cornerRadius = 10
    }

    private func setButtonAspect(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 61, green: 176, blue: 239).cgColor
        button.layer.cornerRadius = 10
    }
}

    // MARK: - PickerView Management

extension PlatformPickerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortedPlatformNames.count
    }


}

extension PlatformPickerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return sortedPlatformNames[row]
    }
}
