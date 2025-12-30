//
//  CenterDelegate.swift
//  TaskTrack
//
//  Created by Neosoft on 30/12/25.
//

import Foundation
import NotificationCenter

class CenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .sound]
    }
    
//    @MainActor
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
//        let identifier = response.actionIdentifier
//        if identifier == "deleteButton" {
//            print("Delete Button Pressed")
//        } else if identifier == "inputField" {
//            print("Response \((response as! UNTextInputNotificationResponse).userText)")
//        }
//    }
}
