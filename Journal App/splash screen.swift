import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            if isActive {
                MainPage()
//                EmptyScreen() // انتقل إلى الشاشة التالية
            } else {
                VStack {
                    Image("url")
                    Text("Journali")
                        .font(.system(size: 42, weight: .black))
                        .foregroundColor(Color.white)
                        .padding(.vertical, 5)
                    Text("Your thoughts, your story")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(Color.white)
                }
                .onAppear {
                    // تأخير الانتقال لمدة 5 ثوانٍ
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        isActive = true
                    }
                }
            }
        }
    }
}

//struct EmptyScreen: View {
//    var body: some View {
//        Text("Welcome to the Empty Screen!")
//            .font(.largeTitle)
//            .foregroundColor(.black)
//            .ignoresSafeArea()
//    }
//}

#Preview {
    SplashScreen()
}
