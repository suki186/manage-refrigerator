//
//  SceneDelegate.swift
//  manageRefrigerator
//
//  Created by suki on 5/26/25.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 윈도우 초기화
        window = UIWindow(windowScene: windowScene)
        // 탭 바 색상 설정
        UITabBar.appearance().tintColor = UIColor(red: 98/255, green: 209/255, blue: 239/255, alpha: 1.0)
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
        
        // 로그인 상태에 따른 초기 화면
        if let currentUser = Auth.auth().currentUser {
            // 로그인된 상태 - 메인 탭바로 이동
            print("이미 로그인된 사용자: \(currentUser.email ?? "")")
            
            if let tabBarVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
                tabBarVC.selectedIndex = 2  // 기본 탭
                window?.rootViewController = tabBarVC
            }
        } else {
            // 로그인되지 않은 상태 - 로그인 화면으로
            print("로그인되지 않음 - 로그인 화면 표시")
            
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            window?.rootViewController = loginVC
        }
        
        window?.makeKeyAndVisible()
        
        
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

