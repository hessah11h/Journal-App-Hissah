import SwiftUI

extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct MainPage: View {
    
    @State private var searchText = "" // State variable for search text
    @State private var isPresentingNewJournal = false // State to control sheet presentation
    @State private var notes: [Note] = [] // تعريف الملاحظات الجديدة
    @State private var isBookmarked = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black // background color
                    .ignoresSafeArea() // This makes the color fill the entire screen
                
                VStack {
                    // Spacer to adjust position
                    Spacer().frame(height: 60) // Adjust this for spacing below the nav title
                    
                    // Custom Search Bar
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Text("Search")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(Color(hex: "#EBEBF5")?.opacity(0.6))
                                .padding(.leading, 45) // Align with the text field padding
                        }
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.gray)
                            .padding(.leading, 20) // Padding for the icon
                        
                        TextField("", text: $searchText)
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(Color(hex: "#EBEBF5")?.opacity(0.6))
                            .padding(.leading, 30)
                            .padding(.vertical, 10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    List {
                        ForEach(notes) { note in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(note.title)
                                        .font(.headline)
                                        .foregroundColor(Color(hex: "#A499FF"))
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                    Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                        .foregroundColor(isBookmarked ? Color(hex: "#D4C8FF") : Color(hex: "#D4C8FF"))
                                        .font(.system(size: 24, weight: .regular))
                                        .onTapGesture {
                                            isBookmarked.toggle()
                                        }
                                }
                                Text(note.date, style: .date)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                Text(note.content)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .listRowBackground(Color.black)
                            .padding()
                            .background(Color(red: 23/255, green: 23/255, blue: 25/255))
                            .cornerRadius(14)
                            .shadow(color: Color.gray.opacity(0.09), radius: 60, x: 0, y: 2)
                            .opacity(1)
                            .swipeActions(edge: .leading) { // Swipe actions على اليسار
                                Button {
                                    // Navigate to edit page
                                    print("Edit tapped for note: \(note.title)")
                                } label: {
                                    Label("", systemImage: "pencil")
                                }
                                .tint(Color(hex: "#A499FF")) // لون الزر
                            }
                            .swipeActions(edge: .trailing) { // Swipe actions على اليمين
                                Button(role: .destructive) {
                                    // منطق الحذف هنا
                                    if let index = notes.firstIndex(where: { $0.id == note.id }) {
                                        notes.remove(at: index)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    Spacer() // Push content down
                }
            }
            .navigationTitle("") // Set to empty to use custom title
            .toolbar {
                // Custom title aligned to the leading side
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Journal")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundColor(Color.white)
                        .padding(.top, 80)
                }
                
                // First button on the right (Filter)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Action for filtering journal entries
                        print("Filter button tapped")
                    }) {
                        Image(systemName: "line.3.horizontal.decrease")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color(hex: "#D4C8FF"))
                            .frame(width: 40, height: 40)
                            .background(Color(hex: "#1F1F22"))
                            .clipShape(Circle())
                    }
                }
                
                // Second button on the right (Add)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Add button tapped")
                        isPresentingNewJournal = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .regular))
                            .foregroundColor(Color(hex: "#D4C8FF"))
                            .frame(width: 40, height: 40)
                            .background(Color(hex: "#1F1F22"))
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $isPresentingNewJournal) {
                        NewJournal(isPresented: $isPresentingNewJournal, notes: $notes) // Pass the notes array
                    }
                }
            }
        }
    }
}

#Preview {
    MainPage()
}
