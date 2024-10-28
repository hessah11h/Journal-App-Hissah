import SwiftUI

struct NewJournal: View {
    @Binding var isPresented: Bool
    @Binding var notes: [Note]
    @State private var title: String = ""
    @State private var content: String = ""

    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "#1A1A1C") // لون الخلفية
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    HStack {
                        Button(action: {
                            isPresented = false
                        }) {
                            Text("Cancel")
                                .foregroundColor(Color(hex: "#A499FF"))
                                .padding()
                                .background(Color(hex: "#1A1A1C"))// لون زر الإلغاء
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            if !title.isEmpty && !content.isEmpty {
                                let newNote = Note(title: title, content: content, date: Date())
                                notes.append(newNote)
                                isPresented = false}
                        }) {
                            Text("Save")
                                .foregroundColor(Color(hex: "#A499FF"))
                                .padding()
                                .background(Color(hex: "#1A1A1C")) // لون زر الحفظ
                                .cornerRadius(10)
                        }
                    }

                    // حقل إدخال العنوان
                    TextField("Title", text: $title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(Color(hex: "#A499FF"))
                        .padding()
                        .background(Color(hex: "#1A1A1C"))
                        .cornerRadius(10)
                        .multilineTextAlignment(.leading)
                    Text(currentDate)
                        .font(.system(size: 16))
                        .foregroundColor(Color.white)
                    
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                        .padding(.horizontal, 20)


                    // حقل إدخال المحتوى
                    TextEditor(text: $content)
                        .font(.system(size: 20))
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color(hex: "#1A1A1C"))
                        .cornerRadius(10)
                        .frame(height: 500)
                        .scrollContentBackground(.hidden)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding()
            }
        }
    }
}
struct Note: Identifiable { // إضافة Identifiable لتسهيل عرض القائمة
    var id = UUID() // معرف فريد
    var title: String
    var content: String
    var date: Date
}


#Preview {
    NewJournal(isPresented: .constant(true), notes: .constant([]))
}
