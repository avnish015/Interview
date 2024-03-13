//
//  MainWindowCoordinator.swift
//  AsyncImageLoadInTableViewCell
//
//  Created by Avnish Kumar on 13/03/24.
//

import UIKit

class MainWindowCoordinator {
    
    let window: UIWindow
    let navigationController: UINavigationController
    
    init(windowScene: UIWindowScene, navigationController: UINavigationController = UINavigationController()) {
        self.window = UIWindow(windowScene: windowScene)
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = PersonListViewController()
        self.navigationController.pushViewController(mainViewController, animated: true)
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }
}

