//
//  PetPalApp.swift
//  PetPal
//
//  Created by Andrew on 20.05.2023.
//

import SwiftUI
import Firebase
import CoreData


final class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Failed to request authorization for user notifications: \(error)")
            } else if granted {
                // Дозвіл було надано, можна налаштувати повідомлення
            } else {
                // Користувач відхилив запит на дозвіл
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    }
}



@main
struct PetPalApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionServiceImpl()
        
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                    case .loggedIn:
                        HomeView()
                            .environmentObject(sessionService)
                            .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    
                    case .loggedOut:
                        StartInfoView()
                    }
                }
            }
        }
        
}

