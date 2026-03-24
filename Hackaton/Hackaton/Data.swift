import Foundation
import SwiftUI
import Combine

class UserProfile: ObservableObject {
    @Published var name: String
    @Published var sexo: Color


    init(name: String, sexo: Color) {
        self.name = name
        self.sexo = Color.amarillo
    }
}


class Badgets: ObservableObject{
    @Published var badget1: Image
    @Published var badget2: Image
    @Published var badget3: Image
    
    init(badget1: String, badget2: String, badget3: String) {
        self.badget1 = Image(systemName: "plus.app")
        self.badget2 = Image(systemName: "plus.app")
        self.badget3 = Image(systemName: "plus.app")
    }
}

class RCues: ObservableObject{
    @Published var resultado: String
    @Published var total: Int
    
    init(resultado: String, total: Int) {
        self.resultado = resultado
        self.total = total
    }
}
class GaugeData: ObservableObject {
    @Published var value: Int
    let maxValue: Int

    init(value: Int = 0, maxValue: Int = 100) {
        self.value = value
        self.maxValue = maxValue
    }
}

