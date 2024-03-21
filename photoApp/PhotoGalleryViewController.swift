//
//  PhotoGalleryViewController.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    
    // MARK: - Private Properties

    private let model: PhotoGalleryModel
    private let photoGalleryView: PhotoGalleryViewable

    // MARK: - Init

    init(model: PhotoGalleryModel, view: PhotoGalleryView) {
        self.model = model
        self.photoGalleryView = view
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions

    private func showAlert(with code: String, and message: String) {
        let alert = UIAlertController(title: code, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hey VC")
        model.getPhotoInfo { [weak self] photoInfo in
            self?.photoGalleryView.mainView.setNumberOfRows(number: photoInfo.count)
        }
    }

    override func loadView() {
        self.view = photoGalleryView
        
        model.showAlert = { [weak self] (code, message) -> Void in
            self?.showAlert(with: code, and: message)
        }
        
        model.isNoResultLabelVisible = { [weak self] (isVisible) -> Void in
            self?.photoGalleryView.isNoResultLabelVisible(isVisible: isVisible)
        }

        model.isSpinnerAnimated = { [weak self] (isAnimated) -> Void in
            self?.photoGalleryView.isSpinnerAnimated(isAnimated: isAnimated)
        }
        
        photoGalleryView.mainView.pictureToCell = { [weak self] (number, completion) in
            guard let strongSelf = self else { return }
            let photoInfoForNumber = strongSelf.model.photoInfo[number]
            let stringUrlOfPicture = photoInfoForNumber.urls.regular
            guard let urlOfPicture = URL(string: stringUrlOfPicture) else {
                completion(nil)
                return
            }
            strongSelf.model.dowloadImage(url: urlOfPicture, completion: { img in
                completion(img)
            })
        }
        
        photoGalleryView.mainView.getMorePhotoInfo = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.model.getPhotoInfo { [weak self] photoInfo in
                self?.photoGalleryView.mainView.setNumberOfRows(number: photoInfo.count)
            }
        }
    }
}

