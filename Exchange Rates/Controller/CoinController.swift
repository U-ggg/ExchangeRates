//
//  CoinController.swift
//  Exchange Rates
//
//  Created by sidzhe on 01.05.2023.
//

import UIKit
import SnapKit

class CoinController: UIViewController {
    
    // MARK: UI
    
    private var coinManager = CoinManager()
    
    private lazy var backgroungImage = UIImageView(image: Constants.Images.backgroung)
    
    private lazy var avatarLabel: UIImageView = {
        let image = UIImageView()
        image.image = Constants.Images.blockchain
        return image
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Str.exchange
        label.textAlignment = .center
        label.textColor = .white
        label.font = Constants.Font.aldrichRegular.withSize(35)
        return label
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 20
        flowLayout.itemSize = CGSize(width: 350, height: 80)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(CoinCollectionCell.self, forCellWithReuseIdentifier: Constants.Str.identifier)
        return collection
    }()
    
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    //MARK: Methods
    
    private func setupView() {
        coinManager.delegate = self
        view.addSubview(backgroungImage)
        view.addSubview(collectionView)
        view.addSubview(picker)
        view.addSubview(avatarLabel)
        view.addSubview(headerLabel)
        
        backgroungImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).inset(-20)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        picker.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
            make.height.equalTo(140)
        }
        
        avatarLabel.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarLabel.snp.bottom).inset(-20)
        }
    }
}

// MARK: Extension CollectionView

extension CoinController: UICollectionViewDelegate {
}

extension CoinController: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoinData.shared.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Str.identifier, for: indexPath) as! CoinCollectionCell
        cell.config(CoinData.shared.model[indexPath.row])
        cell.layer.cornerRadius = 20
        cell.backgroundColor = Constants.Color.colorCell
        return cell
    }
}

// MARK: Extension pickerView

extension CoinController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return coinManager.checkValue(coinManager.currencyArray[row])
    }
}

// MARK: Extension CoinDelegate

extension CoinController: CoinDelegate {
    func setCoin(_ coinAipModel: [CoinApiModel]) {
        for i in 0..<CoinData.shared.model.count {
            CoinData.shared.model[i].usd = coinAipModel[i].asset_id_quote
            CoinData.shared.model[i].rate = coinAipModel[i].rateFinished
            self.collectionView.reloadData()
        }
    }
    
    func didFailError(_ error: Error) {
        print(error)
    }
}
