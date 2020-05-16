import SwiftUI

struct RegulationView: View {
    
    @State private var noRegulationsToggle = true
    @State private var moderateRegulationsToggle = false
    @State private var strongRegulationsToggle = false
    @State private var veryStrongRegulationsToggle = false
    @State private var strongestRegulationsToggle = false
    
    let regulations = [
        Regulation(name: "No Regulations", description: "No measures taken", color: .purple),
        Regulation(name: "Moderate Regulations", description: "Quarantine for the sick", color: .red),
        Regulation(name: "Strong Regulations", description: "Closed schools and movement restrictions", color: .orange),
        Regulation(name: "Very Strong Regulations", description: "Required masks", color: .yellow),
        Regulation(name: "Strongest Regulations", description: "Closed Borders", color: .green),
    ]
    
    func noRegulations(){
        noRegulationsToggle = true
        moderateRegulationsToggle = false
        strongRegulationsToggle = false
        veryStrongRegulationsToggle = false
        strongestRegulationsToggle = false
    }
    
    func moderateRegulations(){
        noRegulationsToggle = false
        moderateRegulationsToggle = true
        strongRegulationsToggle = false
        veryStrongRegulationsToggle = false
        strongestRegulationsToggle = false
    }
    
    func strongRegulations(){
        noRegulationsToggle = false
        moderateRegulationsToggle = false
        strongRegulationsToggle = true
        strongestRegulationsToggle = false
        veryStrongRegulationsToggle = false
    }
    
    func strongestRegulations(){
        noRegulationsToggle = false
        moderateRegulationsToggle = false
        strongRegulationsToggle = false
        strongestRegulationsToggle = true
        veryStrongRegulationsToggle = false
    }
    
    func veryStrongRegulations(){
        noRegulationsToggle = false
        moderateRegulationsToggle = false
        strongRegulationsToggle = false
        strongestRegulationsToggle = false
        veryStrongRegulationsToggle = true
    }
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 5.0)
                    .foregroundColor(StyleSheet.backgroundColor)
                VStack{
                        VStack{
                            DescriptionView(label: regulations[0].name, description: regulations[0].description, color: regulations[0].color, isSelected: Binding(
                                get: { self.noRegulationsToggle },
                                set: { (newValue) in
                                    self.noRegulationsToggle = newValue
                                    self.noRegulations() }
                            )).padding(.top)
                            Divider().background(Color(.white))
                            

                                DescriptionView(label: regulations[1].name, description: regulations[1].description, color: regulations[1].color, isSelected: Binding(
                                    get: { self.moderateRegulationsToggle },
                                    set: { (newValue) in
                                        self.moderateRegulationsToggle = newValue
                                        self.moderateRegulations() }
                                ))
                            
                            Divider().background(Color(.white))
                            
                            Button(action: {
                                
                            }){
                                DescriptionView(label: regulations[2].name, description: regulations[2].description, color: regulations[2].color, isSelected: Binding(
                                    get: { self.strongRegulationsToggle },
                                    set: { (newValue) in
                                        self.strongRegulationsToggle = newValue
                                        self.strongRegulations() }
                                ))
                            }
                            Divider().background(Color(.white))
                            
                            Button(action: {
                                
                            }){
                                DescriptionView(label: regulations[3].name, description: regulations[3].description, color: regulations[3].color, isSelected: Binding(
                                    get: { self.veryStrongRegulationsToggle },
                                    set: { (newValue) in
                                        self.veryStrongRegulationsToggle = newValue
                                        self.veryStrongRegulations() }
                                ))
                            }
                                                        
                            Divider().background(Color(.white))
                            
                            Button(action: {
                                
                            }){
                                DescriptionView(label: regulations[4].name, description: regulations[4].description, color: regulations[4].color, isSelected: Binding(
                                    get: { self.strongestRegulationsToggle },
                                    set: { (newValue) in
                                        self.strongestRegulationsToggle = newValue
                                        self.strongestRegulations() }
                                ))
                            }.padding(.bottom)
                    }

                }
            }
    }
}

struct DescriptionView: View {
    let label: String
    let description: String
    let color: Color
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: {
            self.isSelected.toggle()

        }){
            HStack(){
                ZStack{
                        Circle()
                        .stroke(color, lineWidth: 2)
                        .frame(width:20, height: 20)
                        .foregroundColor(color)

                    if(isSelected) {
                        Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(color)
                        .blur(radius: 3.5)
                    }
                }
                
                Spacer()

                  VStack(alignment: .trailing, spacing: 0) {
                          Text(label)
                              .font(.system(.body))
                              .foregroundColor(StyleSheet.secondaryTextColor)
                          Text(description)
                              .font(.system(.caption))
                              .foregroundColor(StyleSheet.textColor)
                      }
              }.padding(.horizontal, 25)
        }

    }
}

struct Regulation {
    var uid = UUID()
    var name = ""
    var description = ""
    var color: Color = .clear
}


struct RegulationView_Previews: PreviewProvider {
    static var previews: some View {
        RegulationView()
    }
}
