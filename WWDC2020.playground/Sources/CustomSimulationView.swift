import SwiftUI

struct CustomSimulationView: View {
    
    var frame: CGRect
    
    @EnvironmentObject var animation: AnimationViewController

    @Binding var showingSheet: Bool
    
    @State private var population: Int = 5
    @State private var initialInfected: Int = 2
    @State private var infectivity: Int = 50
    @State private var deathRate: Int = 5
    
    var width04 : CGFloat
    var width02 : CGFloat
    
    init(showingSheet: Binding<Bool>, frame: CGRect) {
        self._showingSheet = showingSheet
        self.frame = frame
        self.width04 = frame.size.width*0.4-20
        self.width02 = frame.size.width*0.2-20
    }
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: CGFloat(5.0))
                    .foregroundColor(StyleSheet.backgroundColor)
                
                VStack(alignment: .center){

                    HStack{
                        Spacer()
                        Text("Custom simulation")
                            .font(.system(.body))
                            .foregroundColor(StyleSheet.textColor)
                        Spacer()
                        Button(action: {
                            self.showingSheet.toggle()
                        }){
                            Image(systemName: "xmark.circle.fill")
                                .padding(.horizontal, CGFloat(10))
                        }
                    }
                    
                    HStack{
                        textView(text: "Population:", width: width04)
                        Spacer()
                        subTextView(text: "\(self.animation.numberOfEmojis)", width: width02)
                        Spacer()
                        Stepper("", onIncrement: {
                            if self.animation.numberOfEmojis < 100 {
                                self.animation.numberOfEmojis += 1
                                self.animation.addSprite()
                            }
                            else{
                                self.animation.numberOfEmojis = 100
                            }

                        }, onDecrement: {
                            if self.animation.numberOfEmojis > 5 {
                                self.animation.numberOfEmojis -= 1
                                self.animation.deleteSprite()
                            }
                            else {
                                self.animation.numberOfEmojis = 5
                            }
                        })
                                .colorScheme(.dark)
                                .frame(width: width04, height: CGFloat(20), alignment: .trailing)
                    }.padding()
                    
                    HStack{
                        textView(text: "Initial infected:", width: width04)
                        Spacer()
                        subTextView(text: "\(self.animation.initialInfected)", width: width02)
                        Spacer()
                        // 2...50
                        Stepper("", onIncrement: {
                            if self.animation.initialInfected < 50 {self.animation.initialInfected += 1}
                            else{
                                self.animation.initialInfected = 50
                            }
                        }, onDecrement: {
                            if self.animation.initialInfected > 2 {self.animation.initialInfected -= 2}
                            else {
                                self.animation.initialInfected = 2
                            }

                        })
                            .colorScheme(.dark)
                            .frame(width: width04, height: CGFloat(20), alignment: .trailing)
                    }.padding()
                    
                    HStack(alignment: .center){
                        textView(text: "Infectivity:", width: width04)
                        Spacer()
                        subTextView(text: "\(self.animation.infectivity) %", width: width02)
                        Spacer()
                        // 10...100
                        Stepper("", onIncrement: {
                            if self.animation.infectivity < 100 {self.animation.infectivity += 10}
                            else {
                                self.animation.infectivity=100
                            }
                        }, onDecrement: {
                            if self.animation.infectivity > 10 {self.animation.infectivity -= 10}
                            else {
                                self.animation.infectivity = 10
                            }
                        })
                            .colorScheme(.dark)
                            .frame(width: width04, height: CGFloat(20), alignment: .trailing)
                    }.padding()
                    
                    HStack(alignment: .center){
                        textView(text: "Death rate:", width: width04)
                        Spacer()
                        subTextView(text: "\(self.deathRate)", width: width02)
                        Spacer()
                        Stepper("", value: $deathRate, in: 0...100, step: 1)
                            .colorScheme(.dark)
                            .frame(width: width04, height: CGFloat(20), alignment: .trailing)
                    }.padding()
                }
            }
    }
}

struct textView: View {
    var text: String
    var width: CGFloat
    var body: some View {
        ZStack{
            Text(text)
            .font(.system(.body))
            .foregroundColor(StyleSheet.textColor)
            .frame(width: width, height: 20, alignment: .leading)
        }
    }
}

struct subTextView: View {
    var text: String
    var width: CGFloat
    var body: some View {
        ZStack{
            Text(text)
                    .font(.system(.body)).bold()
                    .foregroundColor(StyleSheet.secondaryTextColor)
                    .frame(width: width, height: 20, alignment: .center)
        }
    }
}

//struct CustomSimulationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSimulationView(showingSheet: Binding<Bool>, frame: CGRect(x: 0, y: 0, width: 350, height: 80))
//    }
//}
