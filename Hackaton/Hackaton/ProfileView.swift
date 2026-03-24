import SwiftUI

struct ProfileView: View {
    @ObservedObject var profile: UserProfile
    @ObservedObject var badgets: Badgets
    
    @State private var isFollowing: Bool = false
    @State private var weeklyMood: [Int] = [60, 40, 80, 50, 70, 90, 65]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    // Header with image/gradient and circular avatar
                    ZStack(alignment: .bottomLeading) {
                        // Background banner
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                LinearGradient(colors: [profile.sexo.opacity(0.6), .black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .frame(height: 220)
                            .overlay(
                                // Decorative circles
                                ZStack {
                                    Circle()
                                        .fill(profile.sexo.opacity(0.35))
                                        .blur(radius: 20)
                                        .frame(width: 160, height: 160)
                                        .offset(x: -80, y: -60)
                                    Circle()
                                        .fill(.white.opacity(0.15))
                                        .blur(radius: 30)
                                        .frame(width: 140, height: 140)
                                        .offset(x: 120, y: -40)
                                }
                            )
                            .overlay(
                                // Top controls
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "xmark")
                                            .font(.headline)
                                            .padding(10)
                                            .background(.ultraThinMaterial, in: Circle())
                                    }
                                    Spacer()
                                    Button(action: {}) {
                                        Image(systemName: "ellipsis")
                                            .font(.headline)
                                            .padding(10)
                                            .background(.ultraThinMaterial, in: Circle())
                                    }
                                }
                                .padding()
                                , alignment: .top
                            )

                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(.ultraThinMaterial)
                                    .frame(width: 96, height: 96)
                                    .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 1))
                                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 6)
                                Image(systemName: "person.fill")
                                    .font(.system(size: 44))
                                    .foregroundStyle(.white)
                            }
                            VStack(alignment: .leading, spacing: 6) {
                                Text(profile.name.isEmpty ? "Tu perfil" : profile.name)
                                    .font(.title2).bold()
                                    .foregroundStyle(.white)
                                Text("@\(profile.name.lowercased().replacingOccurrences(of: " ", with: "_"))")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.85))
                            }
                            Spacer()
                        }
                        .padding()
                    }
                    .padding(.horizontal)

                    // Follow button & stats
                    HStack(spacing: 16) {
                        Button(action: { isFollowing.toggle() }) {
                            Text(isFollowing ? "Following" : "Follow")
                                .font(.headline)
                                .frame(maxWidth: 160)
                                .padding(.vertical, 10)
                                .background(profile.sexo, in: Capsule())
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        HStack(spacing: 24) {
                            VStack { Text("252").bold(); Text("Siguiendo").foregroundStyle(.secondary).font(.caption) }
                            VStack { Text("24K").bold(); Text("Seguidores").foregroundStyle(.secondary).font(.caption) }
                            VStack { Text("732").bold(); Text("Creaciones").foregroundStyle(.secondary).font(.caption) }
                        }
                    }
                    .padding(.horizontal)

                    // Bio
                    Text("Diseña tu bienestar con hábitos simples y seguimiento de ánimo.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)

                    // Mood summary card with semi-circle gauge
                    ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(profile.sexo.opacity(0.25), lineWidth: 1)
                            )
                            .shadow(color: profile.sexo.opacity(0.15), radius: 8, x: 0, y: 6)
                        
                        HStack {
                            // Semi-circle gauge
                            ZStack {
                                Circle()
                                    .trim(from: 0.0, to: 0.5)
                                    .rotation(Angle(degrees: 180))
                                    .stroke(Color.gray.opacity(0.25), style: StrokeStyle(lineWidth: 14, lineCap: .round))
                                    .frame(width: 140, height: 140)
                                let mood = 0.7
                                Circle()
                                    .trim(from: 0.0, to: 0.5 * mood)
                                    .rotation(Angle(degrees: 180))
                                    .stroke(profile.sexo, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                                    .frame(width: 140, height: 140)
                                VStack(spacing: 4) {
                                    Text("Ánimo")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    Text("70")
                                        .font(.title3).bold()
                                        .foregroundStyle(profile.sexo)
                                }
                                .offset(y: 24)
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Resumen semanal")
                                    .font(.headline)
                                HStack(spacing: 6) {
                                    ForEach(0..<weeklyMood.count, id: \.self) { i in
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(i == weeklyMood.count - 1 ? profile.sexo : profile.sexo.opacity(0.5))
                                            .frame(width: 18, height: CGFloat(weeklyMood[i]))
                                    }
                                }
                                .frame(height: 100, alignment: .bottom)
                            }
                        }
                        .padding(16)
                    }
                    .frame(height: 160)
                    .padding(.horizontal)

                    // Gallery / cards section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Actividades recientes")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        let columns = [GridItem(.flexible()), GridItem(.flexible())]
                        LazyVGrid(columns: columns, spacing: 12) {
                            ForEach(0..<4, id: \.self) { idx in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.ultraThinMaterial)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16)
                                                .stroke(profile.sexo.opacity(0.25), lineWidth: 1)
                                        )
                                    VStack(spacing: 8) {
                                        Image(systemName: "heart.text.square")
                                            .font(.title)
                                            .foregroundStyle(profile.sexo)
                                        Text(["Meditación", "Paseo", "Hidratación", "Diario"][idx % 4])
                                            .font(.subheadline)
                                            .foregroundStyle(.primary)
                                    }
                                    .padding(16)
                                }
                                .frame(height: 120)
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("")
            .toolbar { ToolbarItem(placement: .principal) { Text("Perfil").font(.headline) } }
        }
    }
}

#Preview {
    ContentView()
}
