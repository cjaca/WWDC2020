import SwiftUI

struct InvertedBarGraphView: View {
    
    var frame: CGRect
            
    var data : [CGFloat] = []
    
    var color : Color
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 5.0)
//                .foregroundColor(StyleSheet.backgroundColor)
            
            VStack {
                InvertedBarGraph(dataPoints: data)
                    .stroke(color, lineWidth: 2)
                    .aspectRatio(16/9, contentMode: .fit)
                    .border(Color.gray, width: 1)
                    .padding()
                
            }
        }
    }
}

struct InvertedBarGraph: Shape {
    var dataPoints: [CGFloat]

    func path(in rect: CGRect) -> Path {
        func point(at ix: Int) -> CGPoint {
            let point = dataPoints[ix]
            let x = rect.width * CGFloat(ix) / CGFloat(dataPoints.count - 1)
//            let y = (1-point) * rect.height
            let y = point * rect.height

            return CGPoint(x: x, y: y)
        }

        return Path { p in
            guard dataPoints.count > 1 else { return }
            let start = dataPoints[0]
            p.move(to: CGPoint(x: 0, y: (1-start) * rect.height))
            for idx in dataPoints.indices {
                //p.addLine(to: point(at: idx))
                p.addRect(CGRect(x: point(at: idx).x, y: 0, width: CGFloat(dataPoints.count)/rect.width, height: point(at: idx).y))
                //p.closeSubpath()

            }
        }
    }
}

struct InvertedBarGraphView_Previews: PreviewProvider {
    static var previews: some View {
        InvertedBarGraphView(frame: CGRect(x: 0, y: 0, width: 350, height: 300), data: [], color: .blue)
    }
}
