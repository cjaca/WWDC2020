import SwiftUI

struct DashboardUIView: View {

    @ObservedObject var animation: AnimationViewController
    
    var body: some View {
        ZStack{
            if animation.gameIsPaused {
                Color.red.opacity(0.5)
                VStack {
                    VStack{
                        Text("Paused")
                        Button("Continue") {
                            self.animation.gameIsPaused = false
                        }
                    }.font(.largeTitle)
                    .padding()
                        .background(Color.green.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: CGFloat(10)))
                }.transition(.slide)
            }else{
                VStack {
                    HStack{
                        Spacer()
                        Button(action: {self.animation.gameIsPaused = true}){
                            Text("⏸").font(.largeTitle).padding()
                        }
                    }
                    Text("Dead emojis: \(animation.deadEmojis)").font(.largeTitle)
                    Spacer()
                }.transition(.slide)
            }
        }
    }
}

struct DashboardUIView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardUIView(animation: AnimationViewController(size: CGSize(width: 760, height: 960)))
    }
}

