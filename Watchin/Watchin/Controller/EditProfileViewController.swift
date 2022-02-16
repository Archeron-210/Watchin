//
//  EditProfileViewController.swift
//  Watchin
//
//  Created by Archeron on 09/02/2022.
//

import UIKit

protocol EditProfileViewControllerDismissDelegate: AnyObject {
    func didDismiss()
}

class EditProfileViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var choosePictureButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!

    // MARK: - Properties

    weak var delegate: EditProfileViewControllerDismissDelegate?

    private let repository = UserRepository.shared

    private var user: User {
        UserRepository.shared.getUser()
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setProfilePictureAspect()
        setButtonAspect(for: choosePictureButton)
        setButtonAspect(for: saveChangesButton)
        setButtonAspect(for: exitButton)
        setTextFieldAspect()
        displayUserInfos()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.presentingViewController?.viewWillAppear(true)

        if isBeingDismissed {
            delegate?.didDismiss()
        }
    }

    // MARK: - Actions

    @IBAction func exitButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        saveChanges()
    }


    // MARK: - Private

    private func displayUserInfos() {
        userNameTextField.text = user.name
        if let profilePictureData = user.profilePictureData, let image = UIImage(data: profilePictureData) {
            profilePictureImageView.image = image
        } else {
            profilePictureImageView.image = UIImage(named: "defaultProfilePic")
        }
    }

    private func saveChanges() {
        guard let userName = userNameTextField.text, !userName.isEmpty else {
            emptyTextFieldAlert()
            return
        }
        let data = profilePictureImageView.image?.pngData()
        let user = User(name: userName, profilePictureData: data)
        let success = repository.saveUser(user)
        if success {
            successAlert()
        } else {
            failureAlert()
        }
    }

    // MARK: - UI Aspect

    private func setProfilePictureAspect() {
        profilePictureImageView.layer.borderWidth = 3
        profilePictureImageView.layer.masksToBounds = false
        profilePictureImageView.layer.borderColor = UIColor.white.cgColor
        profilePictureImageView.layer.cornerRadius = profilePictureImageView.frame.height/2
        profilePictureImageView.clipsToBounds = true
    }

    private func setButtonAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
    }

    private func setTextFieldAspect() {
        userNameTextField.setBottomBorderAndPlaceholderTextColor()
    }

    // MARK: - Alerts

    private func emptyTextFieldAlert() {
        let alert = UIAlertController(title: "⚠️", message: "Please enter your name before saving !", preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }

    private func successAlert() {
        let alert = UIAlertController(title: "✅", message: "Changes saved successfully !", preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }

    private func failureAlert() {
        let alert = UIAlertController(title: "❌", message: "We were unable to save your changes", preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }
}

    // MARK: - Keyboard Management

extension EditProfileViewController: UITextFieldDelegate {

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        userNameTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

    // MARK: - Image and Navigation Management

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func choosePictureButtonTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        profilePictureImageView.image = image
        picker.dismiss(animated: true)
    }
}

