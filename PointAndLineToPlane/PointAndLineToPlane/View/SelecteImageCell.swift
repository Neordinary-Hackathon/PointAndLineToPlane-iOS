//
//  SelecteImageCell.swift
//  PointAndLineToPlane
//
//  Created by HA on 2023/01/07.
//

import UIKit
import SnapKit

class SelecteImageCell: UICollectionViewCell {
    //MARK: - Properties
    static let reuseIdentifier = "Mycell"
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "점"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "글감이 어쩌구"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    lazy var crossImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MainCrossImage")
        
        return imageView
    }()
    
    lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DotPictureImage")
        
        
        return imageView
    }()

    

    //MARK: - Life cycle
    override init(frame: CGRect) {
           super.init(frame: frame)
           setup()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper
    func setup() {
        contentView.layer.cornerRadius = 10
            contentView.layer.masksToBounds = true
        contentView.backgroundColor = .black
        [titleLabel, descriptionLabel, crossImageView, pictureImageView]
            .forEach {contentView.addSubview($0)}
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36)
            $0.leading.equalToSuperview().inset(36)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(36)
        }
        
        crossImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(68)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(52)
            $0.height.equalTo(52)
        }
        
        pictureImageView.snp.makeConstraints {
            $0.top.equalTo(crossImageView.snp.bottom).offset(53)
            $0.centerX.equalToSuperview()
        }
            
    }

    
    
    
}
