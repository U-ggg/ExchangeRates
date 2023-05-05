//
//  CoinCollectionCell.swift
//  Exchange Rates
//
//  Created by sidzhe on 01.05.2023.
//

import UIKit
import SnapKit

class CoinCollectionCell: UICollectionViewCell {
    
    //MARK: UI CELL
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 20
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.aldrichRegular
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.aldrichRegular
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var usdLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.aldrichRegular
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    //MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    private func setupView() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(rateLabel)
        stackView.addArrangedSubview(usdLabel)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
    }
    
    //MARK: Configuration CoinModel
    
    public func config(_ model: CoinModel) {
        imageView.image = model.image
        nameLabel.text = model.name
        rateLabel.text = model.rate
        usdLabel.text = model.usd
    }
}
