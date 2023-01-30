//
//  SceneDelegate.swift
//  PointAndLineToPlane
//
//  Created by HA on 2023/01/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
//    func changeRootViewController (_ vc: UIViewController, animated: Bool) {
//      UIApplication.shared.windows.first?.rootViewController = vc
//      UIApplication.shared.windows.first?.makeKeyAndVisible()
//
//      let mainViewController = self.storyboard.instantiateViewController(identifier: "LineViewController") as! LineViewController
//      self.navigationController.present(mainViewController, animated: true, completion: nil)
//    }
  //  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
  //    guard let windowScene = (scene as? UIWindowScene) else { return }
  //    window = UIWindow(windowScene: windowScene)
  //    if !hasJwtToken() {
  //      // 로그인 안된 상태
  //      let login = LoginViewController()
  //      window?.rootViewController = login
  //    } else {
  //      // 로그인 된 상태
  //      let main = LineViewController()
  //      window?.rootViewController = main
  //      //    window?.rootViewController = login // 전환
  //    }
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    /*  if !hasJwtToken() {
     // 로그인 안된 상태
     let login = LineViewController()
     window?.rootViewController = login
     } else {
     // 로그인 된 상태
     let main = LineViewController()
     window?.rootViewController = main
     } */
    window?.rootViewController = MainTabController()
    window?.makeKeyAndVisible()
  }
  func hasJwtToken() -> Bool {
    return UserDefaults.standard.object(forKey: "jwtToken") != nil
  }
  func sceneDidDisconnect(_ scene: UIScene) {
  }
  func sceneDidBecomeActive(_ scene: UIScene) {
  }
  func sceneWillResignActive(_ scene: UIScene) {
  }
  func sceneWillEnterForeground(_ scene: UIScene) {
  }
  func sceneDidEnterBackground(_ scene: UIScene) {
  }
}

