//
//  PhotoView.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import Foundation
import UIKit

final class PhotoView: UIView, PhotoMainViewable {
    
    // MARK: - Private Properties
    
    private var pictureView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPictureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions

    private func setupPictureView() {
        self.addSubview(pictureView)

        NSLayoutConstraint.activate([
            pictureView.topAnchor.constraint(equalTo: self.topAnchor),
            pictureView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pictureView.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }

    
    // MARK: - Internal Functions

    func setImageToCell(image: UIImage?) {
        pictureView.image = image
    }

    func clearAllInfo() {
        pictureView.image = nil
    }
}
