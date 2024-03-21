//
//  PhotoGalleryModel.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import Foundation
import UIKit

enum PhotoGaleryError: Error {
    case invalidURL
    case badPercentEncoding
}

final class PhotoGalleryModel {
    
    // MARK: - Private properties

    private let decoder = PhotoJSONDecoder()
    private let internetManager = InternetManager()
    private var partOfURLs: Int = 0
    private var pageSize = 10
    private let maxPageSize = 30
    private var isDownloadingAllowed = true
    
    
    // MARK: - Private(set) properties

    private(set) var photoInfo: [PhotoInfo] = []

    // MARK: - Internal properties

    var showAlert: ((_ code: String, _ message: String) -> Void)?
    var isNoResultLabelVisible: ((Bool) -> Void)?
    var isSpinnerAnimated: ((Bool) -> Void)?
    
    // MARK: - Private functions

    private func getURL(numberOfPage: Int) throws -> URL {
        var stringURL = String()
            // swiftlint:disable:next line_length
        stringURL = String("https://api.unsplash.com/photos/?client_id=qgyVOt-I9U_n50xmreIL6CaUr3SvHq3_b3sK9c6w-9Q&page=\(numberOfPage)&per_page=\(pageSize)")
        
        guard let encodedUrl = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw PhotoGaleryError.badPercentEncoding
        }
        guard let url = URL(string: encodedUrl) else {
            throw PhotoGaleryError.invalidURL
        }
        return url
    }
    
    private func showAlertOnMain(title: String, description: String, isNoResultLabelVisible: Bool,
                                 isSpinnerAnimated: Bool) {
        DispatchQueue.main.async {
            self.isSpinnerAnimated?(isSpinnerAnimated)
            self.isNoResultLabelVisible?(isNoResultLabelVisible)
            self.showAlert?(title, description)
        }
    }
    
    private func checkingForTheExactNumberOfArticles(number: Int) {
        let limit = min(number, self.maxPageSize)
        if self.photoInfo.count == limit {
            self.isDownloadingAllowed = false
        } else if limit < self.photoInfo.count + self.pageSize {
            self.pageSize = limit - self.photoInfo.count
        }
    }
    
    private func handlingRequest(data: Data?,
                                 completionHandler: @escaping (Result<SuccessResponse, ErrorResponse>) -> Void) {
        guard let jsonData = data else {
            showAlertOnMain(title: "Whoops!", description: "DataFetchingError!", isNoResultLabelVisible: true,
                            isSpinnerAnimated: false)
            return
        }

        decoder.decodeNewsJSON(from: jsonData) { result in
            completionHandler(result)
        }
    }
    
    private func successResponseHandling(response: SuccessResponse) {
        isSpinnerAnimated?(false)

        photoInfo += response.photoInfo
        checkingForTheExactNumberOfArticles(number: response.photoInfo.count)
    }
    
    // MARK: - Internal Funtions

    func dowloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        internetManager.downloadImage(with: url) { completion($0) }
    }
    
    func getPhotoInfo(completionHandler: @escaping ([PhotoInfo]) -> Void) {
        isNoResultLabelVisible?(false)
        partOfURLs = (photoInfo.count)/pageSize
        do {
            if isDownloadingAllowed {
                isSpinnerAnimated?(true)
                let url = try getURL(numberOfPage: partOfURLs + 1)
                internetManager.getData(with: url) { [weak self] data in
                    self?.handlingRequest(data: data) { [weak self] result in
                        switch result {
                        case .failure(let errorResponse):
                            guard let strongSelf = self else { return }
                            DispatchQueue.main.async {
                                completionHandler(strongSelf.photoInfo)
                                var statusOfNoResultLabel = true
                                if strongSelf.photoInfo.count != 0 {
                                    statusOfNoResultLabel = false
                                }
                                self?.showAlertOnMain(title: "Whooops!", description: errorResponse.errors,
                                                      isNoResultLabelVisible: statusOfNoResultLabel, isSpinnerAnimated: false)
                            }
                        case .success(let successResponse):
                            guard let strongSelf = self else { return }
                            DispatchQueue.main.async {
                                strongSelf.successResponseHandling(response: successResponse)
                                completionHandler(strongSelf.photoInfo)
                            }
                        }
                    }
                }
            }
        } catch PhotoGaleryError.invalidURL {
            showAlertOnMain(title: "Whooops!", description: "InvalidUrl", isNoResultLabelVisible: true,
                            isSpinnerAnimated: false)
        } catch PhotoGaleryError.badPercentEncoding {
            showAlertOnMain(title: "Whooops!", description: "BadEncodingUrl", isNoResultLabelVisible: true,
                            isSpinnerAnimated: false)
        } catch {
            showAlertOnMain(title: "Whooops!", description: "UnexpectedError", isNoResultLabelVisible: true,
                            isSpinnerAnimated: false)
        }
    }

}
