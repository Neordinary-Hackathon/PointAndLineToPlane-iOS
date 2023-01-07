//
//  ViewController.swift
//  PointAndLineToPlane
//
//  Created by HA on 2023/01/07.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var myLabel: UILabel = {
       let label = UILabel()
        label.text = "DLF"
        return label
    }()
    
    lazy var myLabel2: UILabel = {
       let label = UILabel()
        label.text = "DLF"
        label.font = UIFont(name: "Kefa-Regular", size: 20)
        return label
    }()
    
    lazy var myLabel3: UILabel = {
       let label = UILabel()
        label.text = "DLF"
        label.font = UIFont(name: "STIXTwoMath-Regular", size: 20)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
        getFontName()
        
    }
    
    func getFontName() {
            for family in UIFont.familyNames {

                let sName: String = family as String
                print("family: (sName)")

                for name in UIFont.fontNames(forFamilyName: sName) {
                    print("name: (\(name) as String)")
                }
            }
        }
    
    func configureViews() {
        [myLabel, myLabel2, myLabel3]
            .forEach {view.addSubview($0)}
        
        myLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(168)
            $0.centerX.equalToSuperview()
        }
        
        myLabel2.snp.makeConstraints {
            $0.top.equalTo(myLabel.snp.bottom).offset(42)
            $0.centerX.equalToSuperview()
        }
        myLabel3.snp.makeConstraints {
            $0.top.equalTo(myLabel2.snp.bottom).offset(42)
            $0.centerX.equalToSuperview()
        }
    }


}

