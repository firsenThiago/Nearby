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
        let startViewController = SplashViewController(contentView: contentView, delegate: self)
        navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

extension NearbyFlowController: SplashFlowDelegate {
    func decideNavigationFlow() {
        let contentView = WelcomeView()
        let welcomeViewControler = WelcomeViewController(contentView: contentView, delegate: self)
        navigationController?.pushViewController(welcomeViewControler, animated: true)
    }
}

extension NearbyFlowController: HomeViewFlowDelegate {
    func navigateToHome() {
        let homeView = HomeView()
        let homeViewController = HomeViewController(homeView: homeView)
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}
