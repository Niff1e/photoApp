//
//  PhotoGalleryView.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import Foundation
import UIKit

final class PhotoGalleryView: UIView, PhotoGalleryViewable {
    
    // MARK: Private Properties

    private(set) var mainView: PhotoGalleryMainViewable

    private var noResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("no_results_label", comment: "")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.isHidden = true
        return label
    }()

    private var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .black
        indicator.backgroundColor = .white
        indicator.style = .large
        indicator.stopAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }()

    // MARK: - Init

    init(view: PhotoGalleryMainViewable) {
        self.mainView = view
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.mainView.backgroundColor = .white
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Functions

    private func setupView() {
        self.addSubview(mainView)
        self.addSubview(noResultLabel)
        self.addSubview(indicator)

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            noResultLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            noResultLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            noResultLabel.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),

            indicator.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    // MARK: - Internal Functions

    func isNoResultLabelVisible(isVisible: Bool) {
        if isVisible {
            noResultLabel.isHidden = false
        } else {
            noResultLabel.isHidden = true
        }
    }

    func isSpinnerAnimated(isAnimated: Bool) {
        if isAnimated {
            self.mainView.isUserInteractionEnabled = false
            self.indicator.isHidden = false
            self.indicator.startAnimating()
        } else {
            self.mainView.isUserInteractionEnabled = true
            self.indicator.isHidden = true
            self.indicator.stopAnimating()
        }
    }
}
