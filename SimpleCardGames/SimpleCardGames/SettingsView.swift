import Foundation
import SwiftUI

class AppSettings: ObservableObject {
    @Published var volume: Double = 0.7
    @Published var isMusicEnabled: Bool = true
    @Published var isDarkModeEnabled: Bool = false
    @Published var isVibrationEnabled: Bool = true
    
    init() {
        // Settings will be loaded here later
    }

    func saveSettings() {
        // Settings will be saved here later
    }
}

struct SettingsView: View {
    @StateObject private var settings = AppSettings()
    @Environment(NavigationStack.self) var navigationStack
    @State private var showPrivacySheet = false
    @State private var showTermsSheet = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 0.93, blue: 0.88),
                    Color(red: 0.98, green: 0.96, blue: 0.91)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        navigationStack.pop()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    Text("SETTINGS")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // Placeholder for alignment
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.clear)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color.white.opacity(0.7))
                
                Divider()
                    .background(Color.gray.opacity(0.3))
                
                // Settings Content
                ScrollView {
                    VStack(spacing: 24) {
                        // Volume Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Volume")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Slider(value: $settings.volume, in: 0...1)
                                .tint(.blue)
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(8)
                        
                        // Music Toggle
                        HStack {
                            Text("Music")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Toggle("", isOn: $settings.isMusicEnabled)
                                .tint(.blue)
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(8)
                        
                        // Dark Mode Toggle
                        HStack {
                            Text("Dark Mode")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Toggle("", isOn: $settings.isDarkModeEnabled)
                                .tint(.blue)
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(8)
                        
                        // Vibration Toggle
                        HStack {
                            Text("Vibration")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Toggle("", isOn: $settings.isVibrationEnabled)
                                .tint(.blue)
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(8)
                        
                        Divider()
                            .background(Color.gray.opacity(0.2))
                            .padding(.vertical, 8)
                        
                        // Action Buttons
                        VStack(spacing: 12) {
                            // Restore Purchases Button
                            Button(action: {
                                // Restore purchases action
                            }) {
                                Text("Restore Purchases")
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(14)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            // Privacy Button
                            Button(action: {
                                showPrivacySheet = true
                            }) {
                                Text("Privacy Policy")
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(14)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            // Terms Button
                            Button(action: {
                                showTermsSheet = true
                            }) {
                                Text("Terms of Service")
                                    .font(.system(size: 16, weight: .semibold))
                                    .frame(maxWidth: .infinity)
                                    .padding(14)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(16)
                }
            }
        }
        .sheet(isPresented: $showPrivacySheet) {
            PrivacyPolicySheet(isPresented: $showPrivacySheet)
        }
        .sheet(isPresented: $showTermsSheet) {
            TermsOfServiceSheet(isPresented: $showTermsSheet)
        }
    }
}

// MARK: - Privacy Sheets

struct PrivacyPolicySheet: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Privacy Policy")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("We take your privacy seriously. This app collects minimal data to enhance your gaming experience. No personal information is shared with third parties.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                    
                    Text("Data We Collect")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("• Game preferences\n• Settings selections\n• Game statistics")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(16)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

// MARK: - Terms Sheets

struct TermsOfServiceSheet: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Terms of Service")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("By using this app, you agree to these terms and conditions.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                    
                    Text("License")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("This app is licensed to you for personal, non-commercial use. You may not modify, copy, or distribute the app without permission.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                    
                    Text("Limitations")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text("We are not liable for any damages or losses arising from your use of this app.")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(16)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environment(NavigationStack())
}