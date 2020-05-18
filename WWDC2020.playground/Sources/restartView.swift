import SwiftUI

struct restartView: View {
    @EnvironmentObject var animation: AnimationViewController

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: CGFloat(10.0))
                .foregroundColor(StyleSheet.backgroundColor)
                .frame(width: 550, height: 100)
            VStack{
                Text("Do you want to restart simulation with current settings?")
                .font(.system(.body))
                .foregroundColor(StyleSheet.secondaryTextColor)
                .padding(.horizontal, CGFloat(10))
                HStack{
                    Button(action: {
                        self.animation.restart()
                        self.animation.restartViewIsVisible = false
                    }){
                        Text("Yes")
                        .font(.system(.body))
                        .foregroundColor(Color.white)
                        .padding(.horizontal, CGFloat(10))
                    }.padding()
                    Button(action: {
                        self.animation.isPaused = false
                        self.animation.restartViewIsVisible = false
                    }){
                        Text("No")
                        .font(.system(.body))
                        .foregroundColor(Color.white)
                        .padding(.horizontal, CGFloat(10))
                    }.padding()
                }
            }
        }.frame(width: 550, height: 100)
    }
}
