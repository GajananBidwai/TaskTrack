//
//  TaskTrackApp.swift
//  TaskTrack
//
//  Created by Neosoft on 29/12/25.
//

import SwiftUI

@main
struct TaskTrackApp: App {
    var notification = NotificationViewModel.shared
    var body: some Scene {
        WindowGroup {
            TaskView()
                .environment(notification)
        }
        .modelContainer(for: Tasks.self)
        
    }
}
