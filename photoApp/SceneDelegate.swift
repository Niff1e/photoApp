//
//  SceneDelegate.swift
//  photoApp
//
//  Created by Pavel Maal on 20.03.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene,
                willConnectTo session: UISceneSession,
                options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene is UIWindowScene) else { return }

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.windowScene = scene
        
        window?.rootViewController = createTableVC()
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Private Functions

    private func createTableVC() -> PhotoGalleryViewController {
        let modelForTableVC = PhotoGalleryModel()
        let viewForTableVC = PhotoGalleryView(view: PhotoGalleryTableView())
        let controller = PhotoGalleryViewController(model: modelForTableVC, view: viewForTableVC)
        return controller
    }
}

