import SwiftUI
import Combine

struct AccessibilityVoiceOverView: View {
    
    @StateObject var viewModel = AccessibilityVoiceOverViewModel()
    
    @State private var isActive: Bool = false
    @State private var isFavourite: Bool = false
        
        var body: some View {
            NavigationStack {
                Form {
                    Section {
                        Toggle("Volume", isOn: $isActive)
                        
//                        .accessibilityElement(children: .combine)
//                        .accessibilityAddTraits(.isButton)
//                        .accessibilityValue(isActive ? "is on" : "is off")
//                        .accessibilityHint("Double tap to toggle setting.")
//                        .accessibilityAction {
//                            isActive.toggle()
//                        }
                        
                    } header: {
                        Text("PREFERENCES")
                    }

                    Section {
                        HStack {
                            Text("Volume")
                            Spacer()
                            
                            Text(isActive ? "TRUE" : "FALSE")
                                .accessibilityHidden(true)
                        }
                        .background(Color.black.opacity(0.001))
                        .onTapGesture {
                            isActive.toggle()
                        }
                        .accessibilityElement(children: .combine)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityHint(isActive ? "Double tap to off" : "Double tap to on")
                        .accessibilityValue(isActive ? "is on" : "is off")
                        .accessibilityAction {
                            isActive.toggle()
                        }
                        
                        Button("Favorites") {
                            print("favorites")
                        }
//                        .accessibilityRemoveTraits(.isButton)
                        
                        Button {
                            isFavourite.toggle()
                        } label: {
                            Image(systemName: isFavourite ? "heart.fill" : "heart")
                        }
                        .accessibilityLabel(isFavourite ? "Favorites" : "Not favourites")
                        .accessibilityHint("double tap to change value.")

                        Text("Favorites")
//                            .accessibilityAddTraits(.isButton)
//                            .onTapGesture {
//                                
//                            }
                        
                    } header: {
                        Text("APPLICATION")
                    }
                    
                    VStack {
                        Text("CONTENT")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.secondary)
                            .font(.caption)
//                            .accessibilityAddTraits(.isHeader)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                
                                ForEach(0..<10) { x in
                                    VStack {
                                        Image("Rys\(x+1)")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10)
                                        
                                        Text("Item \(x)")
                                    }
                                    .onTapGesture {
                                        
                                    }
//                                    .accessibilityElement(children: .combine)
//                                    .accessibilityAddTraits(.isButton)
//                                    .accessibilityLabel("Item \(x). Image of Steve Jobs.")
//                                    .accessibilityHint("Double tap to open.")
//                                    .accessibilityAction {
//                                        
//                                    }
                                }
                            }
                        }
                    }
                    
                    Section {
                        Button("Dog") {
                            print("Dog")
                        }
                        Button("Cat") {
                            print("cat")
                        }
                        Button("other animals") {
                            print("other animals")
                        }
                        Button("circle of fifth") {
                            print("circle of fifth")
                        }
                        
                    } header: {
                        Text("some content")
                    }

                }
                .navigationTitle("Settings")
            }
        }
}

#Preview {
    AccessibilityVoiceOverView()
}
