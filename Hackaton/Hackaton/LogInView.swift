import SwiftUI

struct LogInView: View {
    @ObservedObject var profile:UserProfile
    @State private var cambiarVista = false
    @State private var home = false
    var body: some View {
        TabView{
            colorChoice(profile: profile)
            nameChoice(profile: profile)
            test(profile: profile, cambiarVista: $cambiarVista)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .ignoresSafeArea()
        }
}

struct colorChoice: View {
    @ObservedObject var profile:UserProfile
    var body: some View{
        ZStack {
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, profile.sexo]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(width: 400, height: 400)
                .offset(x:350, y:-500)
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, profile.sexo]),
                                     startPoint: .bottomLeading,
                                     endPoint: .topTrailing))
                .frame(width: 400, height: 400)
                .offset(x:-350, y:-70)
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [profile.sexo, Color.white]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(width: 400, height: 400)
                .offset(x:350, y:500)
            VStack{
                Text("¿Còmo te identificas?")
                    .font(.largeTitle)
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.azul)
                        .frame(width: 500, height: 80)
                        .onTapGesture {
                            profile.sexo = Color.azul
                        }
                    Text("Masculino")
                        .bold()
                        .font(.largeTitle)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.morado)
                        .frame(width: 500, height: 80)
                        .onTapGesture {
                            profile.sexo = Color.morado
                            
                        }
                    Text("Femenino")
                        .bold()
                        .font(.largeTitle)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.amarillo)
                        .frame(width: 500, height: 80)
                        .onTapGesture {
                            profile.sexo = Color.amarillo
                        }
                    Text("Otro")
                        .bold()
                        .font(.largeTitle)
                }
            }
        }
    }
}

struct nameChoice: View {
    @ObservedObject var profile:UserProfile
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, profile.sexo]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(width: 400, height: 400)
                .offset(x:350, y:-500)
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white, profile.sexo]),
                                     startPoint: .bottomLeading,
                                     endPoint: .topTrailing))
                .frame(width: 400, height: 400)
                .offset(x:-350, y:-70)
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [profile.sexo, Color.white]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(width: 400, height: 400)
                .offset(x:350, y:500)
            VStack {
                Text("¿Cùal es tu nombre?")
                    .bold()
                    .font(.largeTitle)
                    .padding()
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.white, lineWidth: 15)
                        .fill(profile.sexo)
                        .frame(width: 500, height: 70, alignment: .center)
            
                    TextField("Nombre", text: $profile.name)
                        .frame(width: 500, height: 70, alignment: .center)
                }
            }
        }
    }
}

struct test: View {
    @ObservedObject var profile:UserProfile
    @Binding var cambiarVista: Bool
    var body: some View {
        NavigationStack(){
            ZStack {
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.white, profile.sexo]),
                                         startPoint: .top,
                                         endPoint: .bottom))
                    .frame(width: 400, height: 400)
                    .offset(x:350, y:-500)
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.white, profile.sexo]),
                                         startPoint: .bottomLeading,
                                         endPoint: .topTrailing))
                    .frame(width: 400, height: 400)
                    .offset(x:-350, y:-70)
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [profile.sexo, Color.white]),
                                         startPoint: .top,
                                         endPoint: .bottom))
                    .frame(width: 400, height: 400)
                    .offset(x:350, y:500)
                VStack {
                    Text("A continuacion aplicaremos un examen para conocerte mejor y adaptar nuetra aplicacion \na tus necesidades ")
                        .bold()
                        .font(.largeTitle)
                        .padding()
                    NavigationLink(destination: TestView(profile: profile, cuetionario: RCues(resultado: "", total: 0))){
                        ZStack{
                            Circle()
                                .stroke(.white, lineWidth: 15)
                                .fill(profile.sexo)
                                .frame(width: 150, height: 150)
                            
                            Image(systemName: "arrowtriangle.forward.fill")
                                .resizable()
                                .frame(width: 70, height: 80)
                        }
                    }
                    
                }
            }
        }
        .transition(.move(edge: .bottom))
        .animation(.easeInOut(duration: 1.5))
    }
}

#Preview {
    ContentView()
}
