import SwiftUI

struct CustomSimulationView: View {
    
    var frame: CGRect
    
    @Binding var showingSheet: Bool
    
    @State private var population: Int = 5
    @State private var initialInfected: Int = 2
    @State private var infectivity: Int = 50
    @State private var deathRate: Int = 5
    
    init(showingSheet: Binding<Bool>, frame: CGRect) {
        self._showingSheet = showingSheet
        self.frame = frame
    }
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 5.0)
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
                                .padding(.horizontal, 10)
                        }

                    }
                    HStack{
                            Text("Population:")
                                .font(.system(.body))
                                .foregroundColor(StyleSheet.textColor)
                                .frame(width: self.frame.size.width*0.4-20, height: 20, alignment: .leading)
                        Spacer()
                            Text("\(self.population)")
                                .font(.system(.body)).bold()
                                .foregroundColor(StyleSheet.secondaryTextColor)
                                .frame(width: self.frame.size.width*0.2-20, height: 20, alignment: .center)
                        Spacer()

                            Stepper("", value: $population,in: 5...100)
                                .colorScheme(.dark)
                                .frame(width: self.frame.size.width*0.4-20, height: 20, alignment: .trailing)
                    }.padding()
                    
                    HStack{
                        Text("Initial infected:")
                            .font(.system(.body))
                            .foregroundColor(StyleSheet.textColor)
                            .frame(width: self.frame.size.width*0.4-20, height: 20, alignment: .leading)
                        Spacer()

                        Text("\(self.initialInfected)")
                            .font(.system(.body)).bold()
                            .foregroundColor(StyleSheet.secondaryTextColor)
                            .frame(width: self.frame.size.width*0.2-20, height: 20, alignment: .center)
                        Spacer()

                        Stepper("", value: $initialInfected,in: 2...50)
                            .colorScheme(.dark)
                            .frame(width: self.frame.size.width*0.4-20, height: 20, alignment: .trailing)
                    }.padding()
                    
                    HStack(alignment: .center){
                        Text("Infectivity:")
                            .font(.system(.body))
                            .foregroundColor(StyleSheet.textColor)
                            .frame(width: self.frame.size.width*0.4-20, height: 20, alignment: .leading)
                        Spacer()

                        Text("\(self.infectivity) %")
                            .font(.system(.body)).bold()
                            .foregroundColor(StyleSheet.secondaryTextColor)
                            .frame(width: self.frame.size.width*0.2-20, height: 20, alignment: .center)
                        Spacer()

                        Stepper("", value: $infectivity,in: 0...100,step: 10)
                            .colorScheme(.dark)
                            .frame(width: self.frame.size.width*0.4-20, height: 20, alignment: .trailing)
                    }.padding()
                    
                    HStack(alignment: .center){
                        Text("Death rate:")
                            .font(.system(.body))
                            .foregroundColor(StyleSheet.textColor)
                            .frame(width: self.frame.size.width*0.4-20, height: 20, alignment: .leading)
                        Spacer()

                        Text("\(self.deathRate)")
                            .font(.system(.body)).bold()
                            .foregroundColor(StyleSheet.secondaryTextColor)
                            .frame(width: self.frame.size.width*0.2-20, height: 20, alignment: .center)
                        Spacer()

                        Stepper("", value: $deathRate, in: 0...100, step: 1)
                            .colorScheme(.dark)
                            .frame(width: self.frame.size.width*0.4-20, height: 20, alignment: .trailing)
                    }.padding()
                }
                
                    

                        
                        
                        

            }
    }
}


//struct CustomSimulationView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSimulationView(showingSheet: Binding<Bool>, frame: CGRect(x: 0, y: 0, width: 350, height: 80))
//    }
//}
