//
//  WelcomeView.swift
//  Nearby
//
//  Created by Thiago Firsen on 10/12/24.
//

import UIKit

class WelcomeView: UIView {
    private let logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logoIcon"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Boas vindas ao Nearby!"
        label.font = Typography.titleXL
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Tenha cupons de vantagem para usar em seus estabelecimentos favoritos."
        label.font = Typography.textMD
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTextForTips: UILabel = {
        let label = UILabel()
        label.text = "Veja como funciona:"
        label.font = Typography.textMD
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tipsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 24
        stackView.axis = .vertical
        return stackView
    }()
    
    public let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Começar", for: .normal)
        button.backgroundColor = Colors.greenBase
        button.setTitleColor(Colors.gray100, for: .normal)
        button.titleLabel?.font = Typography.action
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupTips()
        addSubview(logoImageView)
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(subTextForTips)
        addSubview(tipsStackView)
        addSubview(startButton)
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            logoImageView.widthAnchor.constraint(equalToConstant: 48),
            logoImageView.heightAnchor.constraint(equalToConstant: 48),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            subTextForTips.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            subTextForTips.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            tipsStackView.topAnchor.constraint(equalTo: subTextForTips.bottomAnchor, constant: 24),
            tipsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            tipsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            startButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            startButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            startButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            startButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    private func setupTips() {
        let tipEstablishments = TipsView(icon: UIImage(named: "map") ?? UIImage(),
                                         title: "Encontre estabelecimentos",
                                         description: "Veja locais perto de você que são parceiros Nearby")
        
        let tipCoupon = TipsView(icon: UIImage(named: "qrcode") ?? UIImage(),
                                 title: "Ative o cupom com QR Code",
                                 description: "Escaneie o código no estabelecimento para usar o benefício")
        
        let tipAdvantage = TipsView(icon: UIImage(named: "ticket") ?? UIImage(),
                                    title: "Garanta vantagens perto de você",
                                    description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento ")
        
        tipsStackView.addArrangedSubview(tipEstablishments)
        tipsStackView.addArrangedSubview(tipCoupon)
        tipsStackView.addArrangedSubview(tipAdvantage)
    }
}
