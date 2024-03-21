//
//  PhotoProtocols.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import Foundation
import UIKit

protocol PhotoViewable {

    var mainView: PhotoMainViewable { get }
}

protocol PhotoMainViewable: UIView {

    func setImageToCell(image: UIImage?)
    func clearAllInfo()
}
