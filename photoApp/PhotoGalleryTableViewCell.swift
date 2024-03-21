//
//  NewsTableViewCell.swift
//  newsApp
//
//  Created by Niff1e on 27.02.23.
//

import Foundation
import UIKit

class PhotoGalleryTableViewCell: UITableViewCell, PhotoViewable {

    static let identifier = "PhotoGalleryTableViewCell"

    private(set) var mainView: PhotoMainViewable

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.mainView = PhotoView()

        super.init(style: .default, reuseIdentifier: PhotoGalleryTableViewCell.identifier)
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Functions

    private func setupView() {
        self.contentView.addSubview(mainView)

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }

    // MARK: - Internal Functions

    override func prepareForReuse() {
        super.prepareForReuse()
        mainView.clearAllInfo()
    }
}
