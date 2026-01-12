//
//  TaskSheetView.swift
//  TaskTrack
//
//  Created by Neosoft on 29/12/25.
//

import SwiftUI
import SwiftData

struct TaskSheetView: View {
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = .init()
    @State private var isButtonDisabeld: Bool = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    var notificationViewModel = NotificationViewModel.shared
    
    var body: some View {
            VStack(alignment: .leading, spacing: 25) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.red)
                        
                        Spacer()
                        
//                            let task = Task(title: taskTitle, date: taskDate)
//                            do {
//                                context.insert(task)
//                                try context.save()
//                                dismiss()
//                            } catch {
//                                print(error.localizedDescription)
//                            }
                            
                            
                        Button {
                            let task = Tasks(title: taskTitle, date: taskDate)
                            do {
                                context.insert(task)
                                try context.save()
                                Task {
                                    await notification()
                                }
                                dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            Text("Add")
                                .foregroundColor(.primary)
                        }

                    }
                    
                    Spacer()
                    
                    Text("Task Title")
                        .font(.body)
                        .padding(.top, 10)
                        .foregroundColor(Color.primary)
                    
                    TextField("  Your Task Title", text: $taskTitle)
                        .font(.body)
                        .frame(height: 35)
                        .background(.secondary)
                        .foregroundColor(Color.white)
                        .cornerRadius(6)
                    
                    Text("Task Date")
                        .font(.body)
                        .foregroundColor(Color.primary)
                    
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                }
                .padding()
                
                Spacer()
                
                Button {
                    let task = Tasks(title: taskTitle, date: taskDate)
                    do {
                        context.insert(task)
                        try context.save()
                        Task {
                            await notification()
                        }
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                } label: {
                    Text("Add Task")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.white)
                        .foregroundColor(Color.accentColor)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding()
                }.disabled(isButtonDisabeld)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
            .padding(.bottom)
            .task(priority: .background) {
                let authorization = await notificationViewModel.askAuthorization()
                isButtonDisabeld = !authorization
            }
    }
    
    func notification() async {
        await notificationViewModel.postNotificationBasesOnTime(
            time: taskDate.timeIntervalSinceNow,
            taskName: taskTitle
        )
    }
}

#Preview {
    TaskSheetView()
}
