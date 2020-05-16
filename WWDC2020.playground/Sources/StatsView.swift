import SwiftUI

struct StatsView: View {
    var frame: CGRect
    
    @EnvironmentObject var dane: dataContainer
    @EnvironmentObject var animation: AnimationViewController


    var body: some View {
        
        GeometryReader{ reader in
            ZStack{
                
                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(StyleSheet.backgroundColor)
                
                HStack(spacing: 40){
                    VStack(alignment: .center, spacing: 10){
                        Text("Healthy")
                            .font(.system(.caption))
                            .foregroundColor(StyleSheet.textColor)
                        Text("😊 \(self.animation.healthyEmojis)")
                            .font(.system(.body)).bold()
                            .foregroundColor(StyleSheet.secondaryTextColor)
                    }
                    VStack(alignment: .center, spacing: 10) {
                        Text("Infected")
                            .font(.system(.caption))
                            .foregroundColor(StyleSheet.textColor)
                        Text("🤢 \(self.animation.infectedEmojis)")
                            .font(.system(.body)).bold()
                            .foregroundColor(StyleSheet.secondaryTextColor)
                    }
                    VStack(alignment: .center, spacing: 10) {
                        Text("Recovered")
                            .font(.system(.caption))
                            .foregroundColor(StyleSheet.textColor)
                        Text("😷 \(self.animation.recoveredEmojis)")
                            .font(.system(.body)).bold()
                            .foregroundColor(StyleSheet.secondaryTextColor)
                    }
                    VStack(alignment: .center, spacing: 10) {
                        Text("Dead")
                            .font(.system(.caption))
                            .foregroundColor(StyleSheet.textColor)
                        Text("☠️ \(self.animation.deadEmojis)")
                            .font(.system(.body)).bold()
                            .foregroundColor(StyleSheet.secondaryTextColor)
                    }
                }
            }
        }

    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(frame: CGRect(x: 0, y: 0, width: 350, height: 80))
    }
}
