//
//  PlatformPickerViewController.swift
//  Watchin
//
//  Created by Archeron on 01/03/2022.
//

import UIKit

protocol PlatformPickerViewControllerDismissDelegate: AnyObject {
    func didDismiss()
}

class PlatformPickerViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var platformPickerView: UIPickerView!
    @IBOutlet weak var exitButton: UIButton!

    // MARK: - Properties

    weak var delegate: PlatformPickerViewControllerDismissDelegate?
    var show: ShowDetailFormatted?
    private let aspectSetter = AspectSettings.shared
    private let watchinShowRepository = WatchinShowRepository.shared
    private var platformNamesSorted: [String] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        aspectSetter.setContainerViewAspect(for: pickerContainerView)
        aspectSetter.setButtonOnWhiteBackgroundAspect(for: doneButton)
        aspectSetter.setButtonOnWhiteBackgroundAspect(for: exitButton)
        platformNamesSorted = Platform.shared.names.sorted()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.presentingViewController?.viewWillAppear(true)

        if isBeingDismissed {
            delegate?.didDismiss()
        }
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
        guard let show = show else {
            return
        }
        let platformIndex = platformPickerView.selectedRow(inComponent: 0)
        let platform = platformNamesSorted[platformIndex]
        watchinShowRepository.updateWatchinShowPlatform(show: show, platform: platform)
    }

}

    // MARK: - PickerView Management

extension PlatformPickerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return platformNamesSorted.count
    }


}

extension PlatformPickerViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        aspectSetter.setLabelForPicker(for: pickerLabel, with: platformNamesSorted[row])
        return pickerLabel
    }
}
