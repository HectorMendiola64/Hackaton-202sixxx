//
//  ChatView.swift
//  Hackaton
//
//  Created by Hector Mendiola on 24/03/26.
//

import SwiftUI
import Combine
// UserProfile is used to color user bubbles

struct ChatMessage: Identifiable, Equatable {
    enum Sender { case user, assistant }
    let id = UUID()
    let sender: Sender
    let text: String
    let timestamp: Date
}

@MainActor
final class OfflineMentalHealthBot: ObservableObject {
    @Published private(set) var messages: [ChatMessage] = []
    @Published var isThinking: Bool = false

    init() {
        // Mensaje de bienvenida y aviso de seguridad
        let welcome = "Hola, soy tu acompañante de bienestar. Estoy aquí para escucharte y ofrecerte sugerencias de autocuidado. No sustituyo atención profesional. Si estás en peligro o piensas hacerte daño, busca ayuda de emergencia de inmediato."
        messages.append(ChatMessage(sender: .assistant, text: welcome, timestamp: Date()))
    }

    func send(_ userText: String) async {
        let trimmed = userText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        messages.append(ChatMessage(sender: .user, text: trimmed, timestamp: Date()))
        isThinking = true
        // Simular latencia breve para UX
        try? await Task.sleep(nanoseconds: 350_000_000)
        let reply = generateReply(for: trimmed)
        messages.append(ChatMessage(sender: .assistant, text: reply, timestamp: Date()))
        isThinking = false
    }

    // Motor de respuesta offline basado en reglas simples
    private func generateReply(for input: String) -> String {
        let text = input.lowercased()

        // Detección simple de riesgo (no diagnóstica)
        let crisisKeywords = ["suicidio", "suicidar", "quitarme la vida", "hacerme daño", "autolesion", "autolesión", "dañarme", "no quiero vivir"]
        if crisisKeywords.contains(where: { text.contains($0) }) {
            return "Siento que estés pasando por un momento tan difícil. Tu vida es valiosa. Si estás en peligro inmediato o piensas hacerte daño, llama a los servicios de emergencia de tu país o a una línea de ayuda de crisis ahora mismo. En muchos países puedes marcar el número de emergencias local. También puedes contactar a alguien de confianza cerca de ti. Estoy aquí para acompañarte, pero no sustituyo ayuda profesional."
        }

        // Clasificación muy básica de intención/tema
        if containsAny(text, ["ansiedad", "ansioso", "ansiosa", "nervioso", "nerviosa", "preocupado"]) {
            return empathetic(prefix: "Gracias por compartir cómo te sientes. La ansiedad puede ser abrumadora.") +
            "\n\n" +
            bullets([
                "Prueba la respiración 4-6: inhala 4 segundos, exhala 6, durante 2-3 minutos.",
                "Nombra 5 cosas que ves, 4 que sientes, 3 que oyes, 2 que hueles y 1 que saboreas (técnica 5-4-3-2-1).",
                "Reduce cafeína y descansa si puedes."
            ]) + followUp()
        }

        if containsAny(text, ["triste", "tristeza", "deprimido", "deprimida", "sin ganas"]) {
            return empathetic(prefix: "Siento que te sientas así. Es válido sentirse triste a veces.") +
            "\n\n" +
            bullets([
                "Date permiso para sentir y expresarlo (escribir o hablar con alguien de confianza).",
                "Pequeños pasos: una ducha tibia, salir a tomar aire o caminar 5-10 minutos.",
                "Recuerda algo que te haya reconfortado antes (música, mascota, actividad creativa)."
            ]) + followUp()
        }

        if containsAny(text, ["enojo", "enojado", "enojada", "ira", "frustrado", "frustrada"]) {
            return empathetic(prefix: "Gracias por contarme. El enojo también es una emoción válida.") +
            "\n\n" +
            bullets([
                "Haz una pausa física: respira profundo o sal a caminar unos minutos.",
                "Escribe lo que sientes y qué necesitas; luego vuelve a leerlo con calma.",
                "Si es posible, pospone decisiones importantes hasta sentirte más sereno/a."
            ]) + followUp()
        }

        if containsAny(text, ["dormir", "insomnio", "sueño", "no puedo dormir"]) {
            return empathetic(prefix: "El descanso es clave para el bienestar.") +
            "\n\n" +
            bullets([
                "Intenta una rutina: horarios regulares y luz tenue antes de dormir.",
                "Evita pantallas 30-60 minutos antes y prueba respiración lenta.",
                "Si los pensamientos se aceleran, escribe una lista de preocupaciones para mañana."
            ]) + followUp()
        }

        if containsAny(text, ["comer", "alimenticio", "agua", "tomar"]) {
            return empathetic(prefix: "La alimentación y la hidratación influyen en tu bienestar.") +
            "\n\n" +
            bullets([
                "Establece horarios regulares de comida para ayudar a tu cuerpo a encontrar ritmo.",
                "Sustituye alimentos ultraprocesados por alternativas más naturales cuando sea posible.",
                "Pospone antojos hasta después de cumplir una pequeña meta que te propongas."
            ]) + followUp()
        }

        // Respuesta general empática
        return empathetic(prefix: "Gracias por abrirte conmigo. Estoy aquí para escucharte.") +
        "\n\n" +
        bullets([
            "¿Quieres contarme un poco más sobre lo que está pasando?",
            "Podemos explorar una acción pequeña que te ayude hoy (respirar, moverte, hidratarte).",
            "Recuerda: pedir ayuda es valiente. Si lo deseas, podemos planear a quién contactar."
        ])
    }

    private func empathetic(prefix: String) -> String {
        """
        \(prefix)
        No puedo dar diagnósticos ni reemplazo de terapia, pero puedo ofrecerte apoyo y sugerencias de autocuidado.
        """.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func bullets(_ items: [String]) -> String {
        items.map { "• \($0)" }.joined(separator: "\n")
    }

    private func followUp() -> String {
        "\n\nSi te parece, cuéntame qué te gustaría intentar primero o cómo te gustaría que te acompañe."
    }

    private func containsAny(_ text: String, _ keywords: [String]) -> Bool {
        keywords.contains { text.contains($0) }
    }
}

struct ChatView: View {
    @ObservedObject var profile: UserProfile
    @StateObject private var bot = OfflineMentalHealthBot()
    @State private var draft: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(bot.messages) { message in
                                MessageBubble(message: message, userColor: profile.sexo)
                                    .id(message.id)
                            }
                            if bot.isThinking {
                                ThinkingBubble()
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                    }
                    .background(Color(.systemGroupedBackground))
                    .onChange(of: bot.messages) { _, _ in
                        if let last = bot.messages.last?.id {
                            withAnimation { proxy.scrollTo(last, anchor: .bottom) }
                        }
                    }
                }

                Divider()

                HStack(alignment: .bottom, spacing: 8) {
                    TextField("Escribe aquí...", text: $draft, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(1...4)
                        .submitLabel(.send)
                        .onSubmit { Task { await send() } }

                    Button(action: { Task { await send() } }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || bot.isThinking)
                }
                .padding(.all, 12)
                .background(.ultraThinMaterial)
            }
            .navigationTitle("Mind")
        }
    }

    private func send() async {
        let text = draft
        draft = ""
        await bot.send(text)
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    let userColor: Color

    var body: some View {
        HStack(alignment: .bottom) {
            if message.sender == .user { Spacer(minLength: 0) }
            VStack(alignment: .leading, spacing: 6) {
                Text(message.text)
                    .foregroundStyle(message.sender == .user ? .white : .primary)
                    .padding(12)
                    .background(message.sender == .user ? userColor : Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                Text(Self.relativeFormatter.localizedString(for: message.timestamp, relativeTo: Date()))
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            if message.sender == .assistant { Spacer(minLength: 0) }
        }
        .transition(.move(edge: message.sender == .user ? .trailing : .leading).combined(with: .opacity))
    }

    private static let relativeFormatter: RelativeDateTimeFormatter = {
        let f = RelativeDateTimeFormatter()
        f.locale = Locale(identifier: "es")
        f.unitsStyle = .short
        return f
    }()
}

struct ThinkingBubble: View {
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            HStack(spacing: 6) {
                ForEach(0..<3) { i in
                    Circle()
                        .fill(Color.secondary)
                        .frame(width: 6, height: 6)
                        .opacity(0.6)
                        .scaleEffect(1)
                        .animation(.easeInOut(duration: 0.8).repeatForever().delay(Double(i) * 0.15), value: i)
                }
            }
            .padding(10)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

#Preview {
    ChatView(profile: UserProfile(name: "", sexo: .azul))
}
