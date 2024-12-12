//
//  WelcomeViewController.swift
//  Nearby
//
//  Created by Thiago Firsen on 10/12/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    let contentView: WelcomeView
    weak var delegate: HomeViewFlowDelegate?

    init(contentView: WelcomeView,
         delegate: HomeViewFlowDelegate) {
        self.contentView = contentView
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        self.view.backgroundColor = Colors.gray100
        contentView.startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        setupConstraint()
    }
    
    @objc
    private func didTapStartButton() {
        delegate?.navigateToHome()
    }
    
    private func setupConstraint() {
        self.setupContentViewToViewController(contentView: contentView)
    }
}
