//
//  Edit.swift
//  PointAndLineToPlane
//
//  Created by HA on 2023/01/24.
//

import SnapKit
import UIKit


class EditController: UIViewController {
    //MARK: - Info
    
    private lazy var infoTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.addSubview(infoTextField)
        
        return view
    }()
    
    
    // 로그인 - 이메일 입력 필드
    private lazy var infoTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 37
        tf.backgroundColor = .clear
        tf.textColor = .black
        tf.tintColor = .black
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        
        return tf
    }()
  
    //MARK: - Nickname
    private lazy var nicknameTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.addSubview(nicknameTextField)
        view.addSubview(nicknameInfoLabel)
        
        return view
    }()
    
    private var nicknameInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Name : "
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var nicknameTextField: UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 37
        tf.backgroundColor = .clear
        tf.textColor = .black
        tf.tintColor = .black
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        
        return tf
    }()
    //MARK: - line
    
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
    
    private lazy var editButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "edit"), for: .normal)
        btn.addTarget(self, action: #selector(didTapEditButton), for: .touchDown)
        return btn
        
    }()
    
    @objc func didTapEditButton() {

        let alert = UIAlertController(title: "개인정보 바꾸기", message: "개인 정보를 바꾸시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { [self] action in
            print("확인버튼이 눌렸습니다.")
            let mvc = MyPageController()
            mvc.label5.text = nicknameTextField.text
            mvc.label4.text = infoTextField.text
            mvc.modalPresentationStyle = .fullScreen
            self.present(mvc, animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소버튼이 눌렸습니다.")
        }
        
        alert.addAction(success)
        alert.addAction(cancel)
        
        // 실제 띄우기
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        //self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        configure()
        
    }
    
    
    //MARK: - Configure
    
    func configure(){
        [line1, line2, editButton, nicknameTextFieldView, nicknameInfoLabel, nicknameTextField, infoTextFieldView, infoTextField]
            .forEach { view.addSubview($0)}
      
        infoTextFieldView.snp.makeConstraints{
            $0.top.equalTo(nicknameTextFieldView.snp.bottom).offset(17)
            $0.height.equalTo(37)
            $0.leading.equalTo(42)
            $0.trailing.equalTo(-42)
            
        }
        
        infoTextField.snp.makeConstraints{
            $0.top.equalTo(infoTextFieldView.snp.top).offset(6)
            $0.leading.equalTo(infoTextFieldView.snp.leading).offset(8)
            $0.trailing.equalTo(infoTextFieldView.snp.trailing).offset(-10)
        }
        
        line1.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(22)
            $0.leading.equalTo(25)
            $0.trailing.equalTo(-25)


        }
        
        line2.snp.makeConstraints{
            $0.top.equalTo(editButton.snp.bottom).offset(10)
            $0.leading.equalTo(25)
            $0.trailing.equalTo(-25)
        }
        
        editButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(line1.snp.bottom).offset(10)

        }
        
        nicknameTextFieldView.snp.makeConstraints{
            $0.top.equalTo(line2.snp.bottom).offset(170)
            $0.leading.equalTo(42)
            $0.trailing.equalTo(-42)
            $0.height.equalTo(37)
        }
        nicknameInfoLabel.snp.makeConstraints{
            $0.top.equalTo(nicknameTextFieldView.snp.top).offset(7)
            $0.leading.equalTo(nicknameTextFieldView.snp.leading).offset(10)
        }
        
        nicknameTextField.snp.makeConstraints{
            $0.top.equalTo(nicknameTextFieldView.snp.top).offset(6)
            $0.trailing.equalTo(nicknameTextFieldView.snp.trailing).offset(-10)
            $0.leading.equalTo(nicknameInfoLabel.snp.trailing).offset(6)

        }
    }
    
    
}




