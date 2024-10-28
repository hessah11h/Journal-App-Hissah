import SwiftUI

struct EmptyScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image("url")
                    Text("Begin Your Journal")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color(red: 0.832, green: 0.783, blue: 1.001))
                        .padding(.vertical, 5)
                    
                    Text("Craft your personal diary, tap the plus icon to begin")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Journal")
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Journal")
                        .font(.system(size: 34, weight: .semibold))
                        .foregroundColor(Color.white) // Title color
                        .padding(.top,100)
                }
                // مجموعة الأزرار على اليمين
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    // زر الفلتر
                    Button(action: {
                        print("زر فلتر ")
                    }) {
                        Image(systemName: "line.horizontal.3.decrease")
                            .resizable()
                            .foregroundColor(Color(red: 0.808, green: 0.759, blue: 0.969)).frame(width: 20, height: 20)
                            .padding(8)
                            .background(Color(red: 31/255, green: 31/255, blue: 34/255))
                            .clipShape(Circle())
                            .opacity(1)
                    }

                    // زر الزائد
                    Button(action: {
                        print("زر زائد ")
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .foregroundColor(Color(red: 0.808, green: 0.759, blue: 0.969)) // اللون المطلوب
                            .frame(width: 20, height: 20)
                            .padding(8)
                            .background(Color(red: 31/255, green: 31/255, blue: 34/255)) // لون الخلفية
                            .clipShape(Circle())
                            .opacity(1)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    EmptyScreen()
}
