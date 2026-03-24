import SwiftUI

struct HomeView: View {
    @ObservedObject var profile: UserProfile
    @StateObject private var gaugeData = GaugeData(value: 40, maxValue: 100)
    @State private var tasks: [TaskItem] = [
        TaskItem(title: "Tomar agua", done: false),
        TaskItem(title: "Meditar 5 min", done: false),
        TaskItem(title: "Caminar 10 min", done: false)
    ]
    @State private var showChat = false

    struct TaskItem: Identifiable {
        let id = UUID()
        var title: String
        var done: Bool
    }
    
    struct ChatLogoShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let w = rect.width
            let h = rect.height
            // Cloud outline (rounded bumps)
            let cloudRect = CGRect(x: 0.1*w, y: 0.2*h, width: 0.8*w, height: 0.5*h)
            let r = min(cloudRect.width, cloudRect.height) * 0.28
            let c1 = CGPoint(x: cloudRect.minX + r, y: cloudRect.maxY)
            let c2 = CGPoint(x: cloudRect.minX + r*2.2, y: cloudRect.minY + r*0.4)
            let c3 = CGPoint(x: cloudRect.midX, y: cloudRect.minY)
            let c4 = CGPoint(x: cloudRect.maxX - r*1.8, y: cloudRect.minY + r*0.35)
            let c5 = CGPoint(x: cloudRect.maxX - r, y: cloudRect.maxY)

            path.move(to: c1)
            path.addCurve(to: c2, control1: CGPoint(x: c1.x - r*0.8, y: c1.y - r*0.8), control2: CGPoint(x: c2.x - r*0.6, y: c2.y - r*0.6))
            path.addCurve(to: c3, control1: CGPoint(x: c2.x + r*0.2, y: c2.y - r*0.8), control2: CGPoint(x: c3.x - r*0.6, y: c3.y - r*0.4))
            path.addCurve(to: c4, control1: CGPoint(x: c3.x + r*0.6, y: c3.y - r*0.4), control2: CGPoint(x: c4.x - r*0.2, y: c4.y - r*0.8))
            path.addCurve(to: c5, control1: CGPoint(x: c4.x + r*0.6, y: c4.y - r*0.2), control2: CGPoint(x: c5.x + r*0.1, y: c5.y - r*0.8))
            path.addCurve(to: c1, control1: CGPoint(x: c5.x - r*0.6, y: c5.y + r*0.4), control2: CGPoint(x: c1.x + r*0.2, y: c1.y + r*0.2))

            // Waves inside
            let waveY1 = cloudRect.maxY + h*0.02
            let waveY2 = waveY1 + h*0.06
            let waveY3 = waveY2 + h*0.06
            func addWave(y: CGFloat, amplitude: CGFloat) {
                let startX = cloudRect.minX + r*0.3
                let endX = cloudRect.maxX - r*0.3
                path.move(to: CGPoint(x: startX, y: y))
                let midX = (startX + endX)/2
                path.addCurve(to: CGPoint(x: endX, y: y),
                              control1: CGPoint(x: startX + (midX-startX)*0.6, y: y - amplitude),
                              control2: CGPoint(x: midX + (endX-midX)*0.6, y: y + amplitude))
            }
            addWave(y: waveY1, amplitude: h*0.025)
            addWave(y: waveY2, amplitude: -h*0.02)
            addWave(y: waveY3, amplitude: h*0.02)
            return path
        }
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack{
                    VStack(spacing: 24) {
                        // Semi-circle gauge
                        ZStack {
                            // Background arc (track)
                            Circle()
                                .trim(from: 0.0, to: 0.5)
                                .rotation(Angle(degrees: 180))
                                .stroke(Color.gray.opacity(0.25), style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                .frame(width: 260, height: 260)

                            // Progress arc using profile.sexo
                            let progress = min(max(Double(gaugeData.value) / Double(gaugeData.maxValue), 0.0), 1.0)
                            Circle()
                                .trim(from: 0.0, to: 0.5 * progress)
                                .rotation(Angle(degrees: 180))
                                .stroke(profile.sexo, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                .frame(width: 260, height: 260)
                                .animation(.easeInOut(duration: 0.4), value: gaugeData.value)

                            // Tick marks (optional subtle)
                            ForEach(0..<6) { i in
                                let angle = -90.0 + (Double(i) * (180.0 / 5.0))
                                Rectangle()
                                    .fill(Color.secondary.opacity(0.4))
                                    .frame(width: 2, height: 10)
                                    .offset(y: -120)
                                    .rotationEffect(.degrees(angle))
                            }

                            // Value label
                            VStack(spacing: 8) {
                                Text("Estado de Animo")
                                    .font(.headline)
                                    .foregroundStyle(.secondary)
                                Text("\(gaugeData.value)")
                                    .font(.system(size: 48, weight: .bold, design: .rounded))
                                    .foregroundStyle(profile.sexo)
                            }
                            .offset(y: 40)
                        }

                        // Controls to change the Int (for demo/testing)
                        HStack(spacing: 16) {
                            Button("😞") { gaugeData.value = 0 }
                                .buttonStyle(.borderedProminent)
                                .tint(profile.sexo)
                            Button("🙁") { gaugeData.value = Int(Double(gaugeData.maxValue) * 0.25) }
                                .buttonStyle(.borderedProminent)
                                .tint(profile.sexo)
                            Button("😐") { gaugeData.value = Int(Double(gaugeData.maxValue) * 0.5) }
                                .buttonStyle(.borderedProminent)
                                .tint(profile.sexo)
                            Button("🙂") { gaugeData.value = Int(Double(gaugeData.maxValue) * 0.75) }
                                .buttonStyle(.borderedProminent)
                                .tint(profile.sexo)
                            Button("😄") { gaugeData.value = gaugeData.maxValue }
                                .buttonStyle(.borderedProminent)
                                .tint(profile.sexo)
                        }
                        
                        // Daily tasks as 2-column grid with liquid glass style
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Tareas diarias")
                                .font(.headline)
                                .foregroundStyle(.black)
                                .bold()
                            
                            let columns = [
                                GridItem(.flexible(), spacing: 12),
                                GridItem(.flexible(), spacing: 12)
                            ]
                            
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach($tasks) { $task in
                                    ZStack {
                                        // Liquid glass background
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .fill(.ultraThinMaterial)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(profile.sexo.opacity(0.25), lineWidth: 1)
                                            )
                                            .shadow(color: profile.sexo.opacity(0.15), radius: 8, x: 0, y: 6)
                                        
                                        VStack(alignment: .leading, spacing: 12) {
                                            HStack {
                                                Text(task.title)
                                                    .font(.headline)
                                                    .foregroundStyle(.primary)
                                                    .lineLimit(2)
                                                    .minimumScaleFactor(0.8)
                                                Spacer()
                                                // Check button to mark done
                                                Button(action: { task.done.toggle() }) {
                                                    Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                                                        .font(.title2)
                                                        .foregroundStyle(task.done ? profile.sexo : Color.secondary)
                                                }
                                                .buttonStyle(.plain)
                                            }
                                            
                                            ProgressView(value: task.done ? 1.0 : 0.0)
                                                .tint(profile.sexo)
                                        }
                                        .padding(16)
                                    }
                                    .frame(height: 120)
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.top, 40)
                }
                // Floating chat button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ChatButton(tint: profile.sexo) {
                            showChat = true
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 24)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        print("Press")
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }
                ToolbarItem(placement: .principal){
                    Text("Hola \(profile.name)")
                        .font(.headline)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)
                }
            }
            .navigationDestination(isPresented: $showChat) {
                ChatView(profile: profile)
            }
        }
    }
}

struct ChatButton: View {
    var tint: Color
    var action: () -> Void
    @State private var pulse = false

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 72, height: 72)
                    .overlay(
                        Circle()
                            .stroke(tint.opacity(0.35), lineWidth: 1)
                    )
                    .shadow(color: tint.opacity(0.25), radius: 12, x: 0, y: 8)

                // Pulsing glow
                Circle()
                    .stroke(tint.opacity(0.6), lineWidth: 6)
                    .frame(width: pulse ? 88 : 72, height: pulse ? 88 : 72)
                    .opacity(pulse ? 0.0 : 0.7)

                // Logo shape
                HomeView.ChatLogoShape()
                    .stroke(tint, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 42, height: 42)
                    .shadow(color: tint.opacity(0.8), radius: 3)
            }
        }
        .buttonStyle(.plain)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: false)) {
                pulse.toggle()
            }
        }
        .accessibilityLabel("Abrir chat bot")
    }
}

struct ChatBotView: View {
    var body: some View {
        Text("Chat Bot")
            .font(.largeTitle)
            .navigationTitle("Asistente")
    }
}

#Preview {
    HomeView(profile: UserProfile(name: "Alex", sexo: .blue))
}
