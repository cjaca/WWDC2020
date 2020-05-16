import SwiftUI

struct DashboardUIView: View {
    @ObservedObject var animation: AnimationViewController
    @EnvironmentObject var dane: dataContainer
    
    @State private var showingSheet = false
    
    var body: some View {
        GeometryReader { geometry in
            
            HStack(){
                
                // First Column
                ZStack{
                    VStack(alignment: .leading){
                        
                        // Mode buttons
                        RegulationView()
                        .frame(width: (geometry.size.width/2)-30, height: 280)
                        

                        Button(action: {
                            self.showingSheet.toggle()
                        }){
                            Text("Custom simulation")
                        }
                    }
                    if self.showingSheet {
                        CustomSimulationView(showingSheet: self.$showingSheet, frame: CGRect(x: 0, y: 0, width: (geometry.size.width/2)-30, height: 280))
                             .frame(width: (geometry.size.width/2)-30, height: 280)
                     }
                }

                
                // Second Column
                VStack(alignment: .leading){
                
                    
                // StatsView
                StatsView(frame: CGRect(x: 0, y: 0, width: (geometry.size.width/2)-30, height: 80))
                    .frame(width: (geometry.size.width/2)-30, height: 80)
                    .environmentObject(self.animation)
                    
                    ZStack{
//                        // Healthy Line Graph
//                        InvertedBarGraphView(frame: CGRect(x: 0, y: 0, width: (geometry.size.width/2)-30, height: 150), data: self.animation.normalizedDataHealthy, color: .green)
//                                .frame(width: (geometry.size.width/2)-30, height: 150)
                        
                        // Infected Line Graph
                        BarGraphView(frame: CGRect(x: 0, y: 0, width: (geometry.size.width/2)-30, height: 150), data: self.animation.normalizedDataInfected, text: "Infected: " , emoji: "🤢",  numberOfEmojis: self.animation.infectedEmojis)
                            .frame(width: (geometry.size.width/2)-30, height: 150)
//                            
//                            // Recovered Line Graph
//                            InvertedBarGraphView(frame: CGRect(x: 0, y: 0, width: (geometry.size.width/2)-30, height: 150), data: self.animation.normalizedDataRecovered)
//                                .frame(width: (geometry.size.width/2)-30, height: 150)
                            
//                            // Dead Line Graph
//                        InvertedBarGraphView(frame: CGRect(x: 0, y: 0, width: (geometry.size.width/2)-30, height: 150), data: self.animation.normalizedDataDead, color: .blue)
//                                .frame(width: (geometry.size.width/2)-30, height: 150)
                    }
                    


                }
            }
            .offset(y:145)
        }
    }
}

struct DashboardUIView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardUIView(animation: AnimationViewController(size: CGSize(width: 760, height: 960)))
    }
}

