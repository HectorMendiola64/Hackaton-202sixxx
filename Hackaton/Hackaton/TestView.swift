import SwiftUI

struct TestView: View {
    @ObservedObject var profile:UserProfile
    @ObservedObject var cuetionario:RCues
    @State private var selection: Int = 1
    @State private var goHome: Bool = false
    var body: some View {
        NavigationStack(){
            VStack{
                Text("Test")
                    .bold()
                    .font(.largeTitle)
                TabView(selection: $selection){
                    prg1(cuetionario: cuetionario, profile: profile, selection: $selection)
                        .tag(1)
                    prg2(cuetionario: cuetionario, profile: profile, selection: $selection)
                        .tag(2)
                    prg3(cuetionario: cuetionario, profile: profile, selection: $selection)
                        .tag(3)
                    prg4(cuetionario: cuetionario, profile: profile, selection: $selection)
                        .tag(4)
                    prg5(cuetionario: cuetionario, profile: profile, selection: $selection)
                        .tag(5)
                    prg6(cuetionario: cuetionario, profile: profile, selection: $selection)
                        .tag(6)
                    prg7(cuetionario: cuetionario, profile: profile, selection: $selection)
                        .tag(7)
                    prg8(cuetionario: cuetionario, profile: profile, selection: $selection)
                        .tag(8)
                    prg9(cuetionario: cuetionario, profile: profile, selection: $selection)
                        .tag(9)
                    prg10(cuetionario: cuetionario, profile: profile, goHome: $goHome)
                        .tag(10)
                }
                NavigationLink(destination: HomeView(profile: profile), isActive: $goHome) {
                    EmptyView()
                }
            }
        }
        .transition(.move(edge: .bottom))
        .animation(.easeInOut(duration: 1.5)) 
    }
}

struct prg1: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var selection: Int
    var body: some View {
        VStack{
            Text("¿Te has sentido constantemente nervioso/a, inquieto/a o con dificultad para relajarte?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
        }
    }
}
struct prg2: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var selection: Int
    var body: some View {
        VStack{
            Text("¿Has tenido pensamientos repetitivos que no puedes controlar o preocupación excesiva por cosas cotidianas?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
        }
    }
}
struct prg3: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var selection: Int
    var body: some View {
        VStack{
            Text("¿Has perdido el interés o el placer en actividades que antes disfrutabas?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
        }
    }
}
struct prg4: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var selection: Int
    var body: some View {
        VStack{
            Text("¿Te has sentido triste, vacío/a o sin esperanza la mayor parte del tiempo?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
        }
    }
}
struct prg5: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var selection: Int
    var body: some View {
        VStack{
            Text("¿Has tenido cambios importantes en tu forma de comer (comer en exceso o restringir alimentos)?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
        }
    }
}
struct prg6: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var selection: Int
    var body: some View {
        VStack{
            Text("¿Te preocupa mucho tu peso o tu imagen corporal al punto de afectar tu estado de ánimo?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
        }
    }
}
struct prg7: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var selection: Int
    var body: some View {
        VStack{
            Text("¿Has sentido que escuchas voces o ves cosas que otras personas no perciben?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
        }
    }
}
struct prg8: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var selection: Int
    var body: some View {
        VStack{
            Text("¿Has tenido ideas de que alguien te observa, persigue o conspira contra ti sin evidencia clara?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
        }
    }
}
struct prg9: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var selection: Int
    var body: some View {
        VStack{
            Text("¿Te cuesta concentrarte, organizar tareas o mantener la atención en actividades importantes?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                    withAnimation { if selection < 10 { selection += 1 } }
                }
                
            }
        }
    }
}
struct prg10: View {
    @ObservedObject var cuetionario:RCues
    @ObservedObject var profile:UserProfile
    @Binding var goHome: Bool
    var body: some View {
        VStack{
            Text("¿Estos sentimientos o conductas afectan tu vida diaria (escuela, trabajo, relaciones)?")
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Nunca")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 0
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Rara Vez")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 1
                }
                
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Frecuentemente")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 2
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Casi Siempre")
                        .font(.largeTitle)
                        .bold()
                }
                .onTapGesture {
                    cuetionario.total += 3
                }
                
            }
            .padding()
            
            Button(action: { goHome = true }) {
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(profile.sexo)
                        .frame(width: 350, height: 100)
                    Text("Finalizar")
                        .font(.largeTitle)
                        .bold()
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
