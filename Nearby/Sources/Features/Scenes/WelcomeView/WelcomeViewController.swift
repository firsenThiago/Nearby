//
//  WelcomeViewController.swift
//  Nearby
//
//  Created by Thiago Firsen on 10/12/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    let contentView: WelcomeView
    
    init(contentView: WelcomeView) {
        self.contentView = contentView
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
        setupConstraint()
    }
    
    private func setupConstraint() {
        self.setupContentViewToViewController(contentView: contentView)
    }
}
