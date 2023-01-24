//
//  MyPageController.swift
//  PointAndLineToPlane
//
//  Created by HA on 2023/01/07.
//

import UIKit
import SnapKit

class MyPageController: UIViewController {
    
    private lazy var profileView: UIView = {
        let img = UIView()
        img.backgroundColor = .black
        img.layer.cornerRadius = 30
        img.clipsToBounds = true

        return img
    }()
    
    private lazy var line1: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "line1")
        
        return img
    }()
    
    private lazy var line2: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "line2")
        
        return img
    }()
    
    private lazy var line3: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "line3")
        
        return img
    }()
    
    private lazy var editButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "edit"), for: .normal)

        return btn
    }()
    
    @objc func didTapEditButton() {
      let evc = EditController()
        evc.modalPresentationStyle = .fullScreen
        self.present(evc, animated: true, completion: nil)
        
        //self.navigationController?.pushViewController(evc, animated: true)
        
    }
    
    private lazy var checkView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "check")
        
        return img
    }()
    private lazy var checkView1: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "check")
        
        return img
    }()
    private lazy var checkView2: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "check")
        
        return img
    }()
    
    
    private lazy var label1: UILabel = {
        let label = UILabel()
        label.text = "공지사항"
        return label
    }()
    
    private lazy var label2: UILabel = {
        let label = UILabel()
        label.text = "로그인 정보"
        return label
    }()
    
    private lazy var label3: UILabel = {
        let label = UILabel()
        label.text = "버전 정보 1.0.0"
        return label
    }()
    
    lazy var label4: UILabel = {
        let label = UILabel()
        label.text = "한 줄 소개 _2054년 노벨상 수상러"
        return label
    }()
    
    lazy var label5: UILabel = {
        let label = UILabel()
        label.text = "정약용"
        return label
    }()
    
    private lazy var label6: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    
    private lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 5
        return view
        
    }()
    
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        configure()
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchDown)

        
    }
    
    //MARK: - Configure
    
    func configure(){
        [label1, label2, label3, label4, label5, label6, line1, line2, line3,profileView, editButton, checkView, centerView,checkView1,checkView2]
            .forEach { view.addSubview($0)}
      
        checkView2.snp.makeConstraints{
            $0.bottom.equalTo(checkView1.snp.bottom).offset(-48)
            $0.leading.equalTo(25)

        }
        
        checkView1.snp.makeConstraints{
            $0.bottom.equalTo(checkView.snp.bottom).offset(-48)
            $0.leading.equalTo(25)

        }
        
        
        editButton.snp.makeConstraints{
            $0.bottom.equalTo(line1.snp.bottom).offset(-139)
            $0.leading.equalTo(320)
            $0.trailing.equalTo(-25)
            
        }
        
        profileView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(label6.snp.top).offset(-20)
            $0.width.equalTo(60)
            $0.height.equalTo(60)

        }

        label6.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(label5.snp.top).offset(-7)
        }

        label5.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(line1.snp.top).offset(-17)
        }
        
        line1.snp.makeConstraints{
            $0.bottom.equalTo(label4.snp.top).offset(-16)
            $0.leading.equalTo(25)
            $0.trailing.equalTo(-25)
        }
        
        label4.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(line2.snp.top).offset(-16)
        }
        
        line2.snp.makeConstraints{
            $0.bottom.equalTo(centerView.snp.top).offset(-11)
            $0.leading.equalTo(25)
            $0.trailing.equalTo(-25)
        }
        
        centerView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(259)
            $0.bottom.equalTo(line3.snp.top).offset(-16)
            $0.leading.equalTo(23)
            $0.trailing.equalTo(-23)
        }
        
        line3.snp.makeConstraints{
            $0.bottom.equalTo(label1.snp.top).offset(-16)
            $0.leading.equalTo(25)
            $0.trailing.equalTo(-25)
        }
        
        label1.snp.makeConstraints{
            $0.bottom.equalTo(label2.snp.top).offset(-28)
            $0.leading.equalTo(checkView.snp.trailing).offset(20)
            
        }
        
        label2.snp.makeConstraints{
            $0.bottom.equalTo(label3.snp.top).offset(-28)
            $0.leading.equalTo(checkView.snp.trailing).offset(20)
        }
        
        label3.snp.makeConstraints{
            $0.top.equalToSuperview().inset(528)
            $0.leading.equalTo(checkView.snp.trailing).offset(20)
        }
        checkView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(528)
            $0.leading.equalTo(25)
        }
        
    }
}


