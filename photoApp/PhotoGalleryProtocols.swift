//
//  PhotoGalleryProtocols.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import Foundation
import UIKit

protocol PhotoGalleryViewable: UIView {

    var mainView: PhotoGalleryMainViewable { get }

    func isNoResultLabelVisible(isVisible: Bool)
    func isSpinnerAnimated(isAnimated: Bool)
}

protocol PhotoGalleryMainViewable: UIView {
    
    var getMorePhotoInfo: (() -> Void)? { get set }
    var pictureToCell: ((_ number: Int, _ completion: @escaping (UIImage?) -> Void) -> Void)? { get set }
    
    func setNumberOfRows(number: Int)
}
