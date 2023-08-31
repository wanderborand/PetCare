

import SwiftUI
import Combine

struct Activity: Identifiable, Codable {
    let id = UUID()
    let date: Date
    let duration: TimeInterval
}

struct PetActivityView: View {
    @Environment(\.self) var env
    
    @State private var isTimerActive = false
    @State private var isTimerPaused = false
    @State private var startTime = Date()
    @State private var totalWalkTime: TimeInterval = 0
    @State private var walkTimes: [TimeInterval] = []
    
    @State private var timerValue: TimeInterval = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var showStatistics = false
    
    @State private var activities: [Activity] = [] {
        didSet {
            saveActivities()
        }
    }
    
    @State private var chartDataPoints: [TimeInterval] = [] {
        didSet {
            saveChartDataPoints()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("PetActivity".localized)
                    .font(.title)
                    .padding()
                
                Text("TrackManage".localized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                ZStack {
                    Circle()
                        .stroke(Color.blue.opacity(0.3), lineWidth: 20)
                        .frame(width: 200, height: 200)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(timerValue) / 60)
                        .stroke(Color.blue, lineWidth: 20)
                        .frame(width: 200, height: 200)
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1))
                    
                    Text(timerString)
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                        .animation(.none)
                }
                .padding()
                .onTapGesture {
                    if isTimerActive {
                        if isTimerPaused {
                            resumeTimer()
                        } else {
                            pauseTimer()
                        }
                    } else {
                        startTimer()
                    }
                }
                
                HStack {
                    Button(action: {
                        if isTimerActive {
                            if isTimerPaused {
                                resumeTimer()
                            } else {
                                pauseTimer()
                            }
                        }
                    }) {
                        Text(isTimerPaused ? "Resume".localized : "Pause".localized)
                            .font(.callout)
                            .scaleEffect(0.9)
                            .padding(.vertical, 6)
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background {
                                Capsule()
                                    .fill(Color("purpleMain"))
                                    .frame(maxWidth: .infinity)
                            }
                            .foregroundColor(.white)
                            .contentShape(Capsule())
                    }
                    .padding(25)

                    Button(action: {
                        if isTimerActive {
                            stopTimer()
                            isTimerActive = false
                        } else {
                            startTimer()
                            isTimerActive = true
                        }
                    }) {
                        Text(isTimerActive ? "Stop".localized : "Start".localized)
                            .font(.callout)
                            .scaleEffect(0.9)
                            .padding(.vertical, 6)
                            .padding(12)
                            .frame(maxWidth: .infinity)
                            .background {
                                Capsule()
                                    .fill(isTimerActive ? Color.musicColor : Color.greenMain)
                                    .frame(maxWidth: .infinity)
                            }
                            .foregroundColor(.white)
                            .contentShape(Capsule())
                    }
                    .padding(25)
                }

                
                NavigationLink(destination: StatisticsView(activities: activities, walkTimes: chartDataPoints, lastTimerValue: timerValue)) {
                    Text("Statistics")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background {
                            Capsule()
                                .fill(Color("blueMain"))
                        }
                }
                .padding(25)
            }
            .onReceive(timer) { _ in
                if isTimerActive && !isTimerPaused {
                    updateTimer()
                }
            }
            .onAppear {
                loadActivities()
                loadChartDataPoints()
            }
            .onDisappear {
                saveActivities()
                saveChartDataPoints()
            }
            .navigationBarTitle("PetActivity".localized, displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                env.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.blue)
            })
        }
    }
    
    private var timerString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: timerValue) ?? ""
    }
    
    private func startTimer() {
        isTimerActive = true
        startTime = Date()
        timerValue = 0
    }
    
    private func stopTimer() {
        isTimerActive = false
        isTimerPaused = false
        let endTime = Date()
        let walkTime = endTime.timeIntervalSince(startTime)
        walkTimes.append(walkTime)
        totalWalkTime += walkTime
        
        let activity = Activity(date: Date(), duration: walkTime)
        activities.append(activity)
        
        chartDataPoints.append(walkTime)
    }
    
    private func pauseTimer() {
        isTimerPaused = true
    }
    
    private func resumeTimer() {
        isTimerPaused = false
        startTime = Date().addingTimeInterval(-timerValue)
    }
    
    private func updateTimer() {
        let currentTime = Date()
        timerValue = currentTime.timeIntervalSince(startTime)
    }
    
    private func saveActivities() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(activities) {
            UserDefaults.standard.set(encodedData, forKey: "activities")
        }
    }
    
    private func loadActivities() {
        if let encodedData = UserDefaults.standard.data(forKey: "activities") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Activity].self, from: encodedData) {
                activities = decodedData
            }
        }
    }
    
    private func saveChartDataPoints() {
        UserDefaults.standard.set(chartDataPoints, forKey: "chartDataPoints")
    }
    
    private func loadChartDataPoints() {
        if let loadedDataPoints = UserDefaults.standard.array(forKey: "chartDataPoints") as? [TimeInterval] {
            chartDataPoints = loadedDataPoints
        }
    }
}

struct StatisticsView: View {
    var activities: [Activity]
    var walkTimes: [TimeInterval]
    var lastTimerValue: TimeInterval
    
    var body: some View {
        VStack {
            Text("Statistics")
                .font(.title)
                .padding()
            
            if !walkTimes.isEmpty {
                LineChartView(dataPoints: walkTimes)
                    .frame(height: 200)
                    .padding()
            } else {
                Text("No data available")
                    .font(.headline)
            }
            
            if !activities.isEmpty {
                List(activities) { activity in
                    VStack(alignment: .leading) {
                        Text("Дати: \(formatDate(activity.date))")
                        Text("Тривалість: \(formatTime(activity.duration))")
                    }
                }
                .padding()
            } else {
                Text("No activities available")
                    .font(.headline)
            }
        }
    }
    
    private func formatTime(_ timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter.string(from: timeInterval) ?? ""
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}

struct LineChartView: View {
    var dataPoints: [TimeInterval]
    
    var body: some View {
        GeometryReader { geometry in
            let maxValue = dataPoints.max() ?? 0
            let dataCount = CGFloat(dataPoints.count)
            let stepWidth = geometry.size.width / dataCount
            let stepHeight = geometry.size.height / CGFloat(maxValue)
            
            Path { path in
                for (index, dataPoint) in dataPoints.enumerated() {
                    let x = CGFloat(index) * stepWidth
                    let y = geometry.size.height - CGFloat(dataPoint) * stepHeight
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}

struct PetActivityView_Previews: PreviewProvider {
    static var previews: some View {
        PetActivityView()
    }
}
