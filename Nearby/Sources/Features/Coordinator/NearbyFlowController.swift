//
//  NearbyFlowController.swift
//  Nearby
//
//  Created by Thiago Firsen on 09/12/24.
//

import UIKit

class NearbyFlowController {
    private var navigationController: UINavigationController?
    
    public init() {
    }
    
    func start() -> UINavigationController? {
        let contentView = SplashView()
        let startViewController = SplashViewController(contentView: contentView)
        navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}
