//
//  MainTabController.swift
//  PointAndLineToPlane
//
//  Created by HA on 2023/01/07.
//

import UIKit
import SnapKit


class MainTabController: UITabBarController {
   
    //MARK: - Properties

    let HEIGHT_TAB_BAR:CGFloat = 120

//    lazy var myLabel1: UILabel = {
//       let label = UILabel()
//        label.text = "DLF"
//        label.font = UIFont(name: "Kefa-Regular", size: 24)
//        return label
//    }()
//    
//    lazy var myLabel2: UILabel = {
//       let label = UILabel()
//        label.text = "점 선 면"
//        return label
//    }()
//    
//   
//    
//    lazy var myImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "round1")
//        
//        return imageView
//    }()
//    
//    lazy var myImageView1: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "line1")
//        
//        return imageView
//    }()
    
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureLabel()
        
    }
    
    
    //MARK: - Helpers
    
    func configureViewControllers(){  // constructor
        tabBar.backgroundColor = UIColor(named: "TabBarBackgroundColor")
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        let write = templateNavigationController(unselectedImage: UIImage(imageLiteralResourceName: "write"), selectedImage: UIImage(imageLiteralResourceName: "write_selected"), rootViewController: WriteController())
       
        let community = templateNavigationController(unselectedImage: UIImage(imageLiteralResourceName: "community"), selectedImage: UIImage(imageLiteralResourceName: "community_selected"), rootViewController: CommunityController())
        
        let myWork = templateNavigationController(unselectedImage: UIImage(imageLiteralResourceName: "mywork"), selectedImage: UIImage(imageLiteralResourceName: "mywork_selected"), rootViewController: MyWorkController())
        
        let myPage = templateNavigationController(unselectedImage: UIImage(imageLiteralResourceName: "mypage"), selectedImage: UIImage(imageLiteralResourceName: "mypage_selected"), rootViewController: MyPageController())
        
        viewControllers = [write, community, myWork, myPage]
        
        tabBar.tintColor = .white
    }
    
    
    func configureLabel() {
//        [myLabel1, myLabel2, myImageView, myImageView1]
//            .forEach {view.addSubview($0)}
//        
//        myLabel1.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(60)
//            $0.leading.equalToSuperview().inset(30)
//        }
//        
//        myLabel2.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(65)
//            $0.leading.equalToSuperview().inset(85)
//        }
//        
//        
//        myImageView.snp.makeConstraints {
//            $0.bottom.equalToSuperview().inset(250)
//            $0.leading.equalToSuperview().inset(187)
//        }
//        
//        myImageView1.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(100)
//        }
        
    }
    
    override func viewDidLayoutSubviews() {
                super.viewDidLayoutSubviews()
                var tabFrame = self.tabBar.frame
                tabFrame.size.height = HEIGHT_TAB_BAR
                tabFrame.origin.y = self.view.frame.size.height - HEIGHT_TAB_BAR
                self.tabBar.frame = tabFrame
            }
    
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage,rootViewController:UIViewController) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        
        return nav
    }
    
}

