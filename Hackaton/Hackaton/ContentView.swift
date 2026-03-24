import SwiftUI

struct ContentView: View {
    @StateObject private var profile = UserProfile(name: "", sexo: .amarillo)
    @StateObject private var badgets = Badgets(badget1: "plus.app", badget2: "plus.app", badget3: "plus.app")
    
    var body: some View {
        TabView {
            HomeView(profile: profile)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }
            ProfileView(profile: profile, badgets: badgets)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
            MapaView()
                .tabItem{
                    Image(systemName: "map.fill")
                    Text("Mapa")
                }
        }
        .tabViewStyle(.automatic)
    }
}

#Preview {
    ContentView()
}
