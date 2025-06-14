//
//  RefrigeratorManager.swift
//  manageRefrigerator
//
//  Created by suki on 6/14/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UserNotifications

class RefrigeratorManager {
    
    static let shared = RefrigeratorManager()

    func checkExpiringItems(completion: @escaping ([ExpiringItem]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion([])
            return
        }
        
        let db = Firestore.firestore()
        let storageTypes = ["냉장", "냉동", "실온"]
        var alerts: [ExpiringItem] = []
        let group = DispatchGroup()
        
        for type in storageTypes {
            group.enter()
            db.collection("users").document(uid).collection(type).getDocuments { snapshot, error in
                defer { group.leave() }
                guard let documents = snapshot?.documents else { return }
                
                for doc in documents {
                    if let timestamp = doc.data()["expiration"] as? Timestamp {
                        let expDate = timestamp.dateValue()
                        
                        if let daysLeft = self.daysUntilExpiration(from: expDate),
                           daysLeft == 2 || daysLeft == 0 {
                            
                            let itemName = doc.data()["name"] as? String ?? "이름없음"
                            let item = ExpiringItem(category: type, itemName: itemName, daysLeft: daysLeft)
                            alerts.append(item)
                            self.sendLocalNotification(for: item, daysLeft: daysLeft)
                        }
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(alerts)
        }
    }
    
    private func daysUntilExpiration(from date: Date) -> Int? {
        let today = Calendar.current.startOfDay(for: Date())
        let exp = Calendar.current.startOfDay(for: date)
        return Calendar.current.dateComponents([.day], from: today, to: exp).day
    }

    private func sendLocalNotification(for item: ExpiringItem, daysLeft: Int) {
        let content = UNMutableNotificationContent()
        content.title = "🧊 소비기한 임박!"
        
        switch daysLeft {
        case 2:
            content.body = "[\(item.category)] '\(item.itemName)'의 소비기한이 2일 남았어요."
        case 0:
            content.body = "[\(item.category)] '\(item.itemName)'의 소비기한이 오늘까지예요."
        default:
            content.body = "[\(item.category)] '\(item.itemName)'의 소비기한이 임박했어요."
        }
        content.sound = .default

        // 알림 시각: 오전 10:00
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
