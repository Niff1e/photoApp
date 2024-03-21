//
//  PhotoGalleryTableView.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import Foundation
import UIKit

final class PhotoGalleryTableView: UITableView, UITableViewDelegate, UITableViewDataSource, PhotoGalleryMainViewable {
    
    // MARK: Private Properties
    
    private var numberOfRows: Int = 0

    // MARK: - Internal Properties

    var getMorePhotoInfo: (() -> Void)?
    var pictureToCell: ((_ number: Int, _ completion: @escaping (UIImage?) -> Void) -> Void)?
    
    // MARK: - Init

    init() {
        super.init(frame: .zero, style: .plain)
        self.backgroundColor = .white
        self.dataSource = self
        self.delegate = self
        self.register(PhotoGalleryTableViewCell.self, forCellReuseIdentifier: PhotoGalleryTableViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.dequeueReusableCell(withIdentifier: PhotoGalleryTableViewCell.identifier,
                                                        for: indexPath) as? PhotoGalleryTableViewCell {
            pictureToCell?(indexPath.row) { [weak self] img in
                guard let strongSelf = self else { return }
                let tableViewCell = strongSelf.cellForRow(at: indexPath)
                (tableViewCell as? PhotoGalleryTableViewCell)?.mainView.setImageToCell(image: img)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }

    // MARK: - Table View Delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == numberOfRows - 1 {
            getMorePhotoInfo?()
        }
    }
    
    // MARK: - Internal Functions
    
    func setNumberOfRows(number: Int) {
        self.numberOfRows = number
        self.reloadData()
    }
}
