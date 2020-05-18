import SwiftUI

struct DashboardUIView: View {
    @ObservedObject var animation: AnimationViewController
    
    @State private var showingSheet = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack{

                ZStack{
                    if self.animation.restartViewIsVisible{
                        restartView()
                        .environmentObject(self.animation)
                        .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                        .animation(.default)

                    }
                }.frame(width: 550, height: 100)

                
                HStack(){
                    
                    // First Column
                    VStack(alignment: .leading) {
                        ZStack{
                            VStack(alignment: .leading){
                                
                                // Mode buttons
                                CustomSimulationView(showingSheet: self.$showingSheet, frame: CGRect(x: 0, y: 0, width: (geometry.size.width/2)-30, height: 280))
                                    .environmentObject(self.animation)
                                    .frame(width: (geometry.size.width/2)-30, height: 280)


                            }
                            if self.showingSheet {
                                RegulationView(showingSheet: self.$showingSheet)
                                .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                                .animation(.default)
                                .frame(width: (geometry.size.width/2)-30, height: 280)

                             }
                        }
                    }

                    
                    // Second Column
                    VStack(alignment: .leading){
                        
                    // StatsView
                    StatsView(frame: CGRect(x: 0, y: 0, width: (geometry.size.width/2)-30, height: 80))
                        .frame(width: (geometry.size.width/2)-30, height: 80)
                        .environmentObject(self.animation)
                        
                        ZStack{
                            // Infected Line Graph
                            BarGraphView(frame: CGRect(x: 0, y: 0, width: (geometry.size.width/2)-30, height: 150), data: self.animation.normalizedDataInfected, text: "Infected: " , emoji: "🤢",  numberOfEmojis: self.animation.infectedEmojis, maximum: self.animation.maximumInfected)
                                .frame(width: (geometry.size.width/2)-30, height: 150)
                        }
                        
                        HStack{

                            
                            ZStack{
                                RoundedRectangle(cornerRadius: CGFloat(5.0))
                                    .frame(width: (geometry.size.width*5/16)-19, height: 35)
                                    .foregroundColor(StyleSheet.backgroundColor)
                                Button(action: {
                                    self.showingSheet.toggle()
                                }){
                                    Image(systemName: "slider.horizontal.3")
                                        .font(.system(.body))
                                        .foregroundColor(StyleSheet.secondaryTextColor)
                                    .padding(.horizontal, CGFloat(5))
                                    Text("Custom simulation")
                                    .font(.system(.body))
                                    .foregroundColor(StyleSheet.secondaryTextColor)
                                }
                            }.frame(width: (geometry.size.width*5/16)-19, height: 35)
                            // Start/Pause btn
                            ZStack{
                                RoundedRectangle(cornerRadius: CGFloat(5.0))
                                    .frame(width: (geometry.size.width*3/16)-19, height: 35)
                                    .foregroundColor(StyleSheet.backgroundColor)
                                HStack{
                                    Button(action: {
                                        self.animation.gameIsPaused.toggle()
                                    }){
                                        if !self.animation.gameIsPaused {
                                            HStack(alignment: .center){
                                                Image(systemName: "pause.circle")
                                                    .font(.system(.body))
                                                    .foregroundColor(StyleSheet.secondaryTextColor)
                                                    .padding(.horizontal, CGFloat(5))
                                                Text("Pause")
                                                    .font(.system(.body))
                                                    .foregroundColor(StyleSheet.secondaryTextColor)
                                            }.frame(width: (geometry.size.width*3/16)-19, height: 35)

                                        }else{
                                            HStack(alignment: .center){
                                                Image(systemName: "arrowtriangle.right.circle")
                                                    .font(.system(.body))
                                                    .foregroundColor(StyleSheet.secondaryTextColor)
                                                    .padding(.horizontal, CGFloat(5))
                                                Text("Start")
                                                    .font(.system(.body))
                                                    .foregroundColor(StyleSheet.secondaryTextColor)

                                            }.frame(width: (geometry.size.width*3/16)-19, height: 35)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .offset(y:100)
            }

            
            
        }
    }
}

struct DashboardUIView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardUIView(animation: AnimationViewController(size: CGSize(width: 760, height: 960)))
    }
}
