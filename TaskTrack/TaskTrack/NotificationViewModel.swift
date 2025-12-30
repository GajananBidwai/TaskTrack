//
//  NotificationViewModel.swift
//  TaskTrack
//
//  Created by Neosoft on 30/12/25.
//

import Foundation
import NotificationCenter
import UIKit
import Observation

@Observable class NotificationViewModel: @unchecked Sendable {
    @ObservationIgnored let center = UNUserNotificationCenter.current()
    @ObservationIgnored let centerDelegate: CenterDelegate = CenterDelegate()
    
    static let shared: NotificationViewModel = NotificationViewModel()
    
    private init() {
        center.delegate = centerDelegate
    }
    
    func askAuthorization() async -> Bool {
        do {
            let authorized = try await center.requestAuthorization(options: [.alert, .sound])
            return authorized
        } catch {
            print("Error \(error)")
            return false
        }
    }
    
    func postNotificationBasesOnTime(time: TimeInterval, taskName: String) async {
        let settings = await center.notificationSettings()

        guard settings.authorizationStatus == .authorized else { return }

        let content = UNMutableNotificationContent()
        content.title = "Reminder to do"
        content.body = taskName
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: max(time, 1),
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        try? await center.add(request)
    }
    
    
}
