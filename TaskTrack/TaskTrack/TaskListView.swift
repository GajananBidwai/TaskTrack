//
//  TaskListView.swift
//  TaskTrack
//
//  Created by Neosoft on 29/12/25.
//

import SwiftUI
import SwiftData

struct TaskListView: View {
    @Binding var date: Date
    @Query private var tasks: [Tasks]
    
    init(date: Binding<Date>) {
        self._date = date
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = #Predicate<Tasks> {
            return $0.date >= startDate && $0.date < endOfDate
        }
        
        let sortDescriptor = [
            SortDescriptor(\Tasks.date, order: .forward)
        ]
        self._tasks = Query(filter: predicate, sort: sortDescriptor)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(tasks) { task in
                    TaskItemView(task: task)
                }
            }
            .padding(.top, 20)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    TaskListView(date: .constant(Date()))
        .modelContainer(for: Tasks.self)
}

