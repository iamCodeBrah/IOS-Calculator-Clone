//
//  CalcHeaderCell.swift
//  Calculator-Clone
//
//  Created by John Lee on 2022-09-15.
//

import UIKit

class CalcHeaderCell: UICollectionReusableView {
    
    static let identifer = "CalcHeaderCell"
    
    // MARK: - UI Components
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 72, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(currentCalcText: String) {
        self.label.text = currentCalcText
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.backgroundColor = .black
        
        self.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
        ])
    }
}
