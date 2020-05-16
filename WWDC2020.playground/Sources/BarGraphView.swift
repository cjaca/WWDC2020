import SwiftUI

struct BarGraphView: View {
    
    var frame : CGRect
            
    var data : [CGFloat] = []
    
    var text : String
    
    var emoji : String
    
    var numberOfEmojis = 0
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5.0)
                .foregroundColor(StyleSheet.backgroundColor)
            VStack(alignment: .leading, spacing: 10) {
                
                HStack(spacing: 10){
                    Text(text)
                        .font(.system(.caption))
                        .foregroundColor(StyleSheet.textColor)
                    Text(emoji + " \(numberOfEmojis)")
                        .font(.system(.body)).bold()
                        .foregroundColor(StyleSheet.secondaryTextColor)
                }
                
                BarGraph(dataPoints: data)
                    .fill(Color.green)
                    .frame(width: self.frame.width - 30, height: self.frame.height-75, alignment: .center)
            }
        }
    }
}

struct BarGraph: Shape {
    var dataPoints: [CGFloat]

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
            let y = point * -1 * rect.height

            return CGPoint(x: x, y: y)
        }

        return Path { p in
            guard dataPoints.count > 1 else { return }
            for idx in dataPoints.indices {
                p.addRect(CGRect(x: point(at: idx).x, y: rect.height, width: CGFloat(dataPoints.count)/rect.width, height: point(at: idx).y))
            }
        }
    }
}

struct BarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        BarGraphView(frame: CGRect(x: 0, y: 0, width: 350, height: 300), data: [], text: "", emoji: "😀", numberOfEmojis: 0)
    }
}


public func normalization(rawData: [CGFloat], normalizedData: [CGFloat], newValue: CGFloat)->([CGFloat], [CGFloat]){
    // return rawData, normalizedData, min, max
    
    var spareArray: [CGFloat] = []
    
    var normalizedData = normalizedData
    var rawData = rawData
    var oldMin : CGFloat
    var oldMax : CGFloat

    
    var min : CGFloat
    var max : CGFloat
    
    if rawData.count == 0 {
        rawData.append(newValue)
        normalizedData.append(1)
        
        return (rawData, normalizedData)
        
    } else {
        oldMin = rawData.min()!
        oldMax = rawData.max()!
        rawData.append(newValue)
        min = rawData.min()!
        max = rawData.max()!
    }
    
    
    if (newValue < oldMin || newValue > oldMax) {
        for element in rawData {
            spareArray.append((element - min) / (max - min) )
        }
    }else{
        spareArray = normalizedData
        spareArray.append((newValue - min) / (max - min) )
    }
        
    normalizedData = spareArray
    
    return (rawData, normalizedData)
}
