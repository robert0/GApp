//
//  DataView.swift
//  GApp
//
//  Created by Robert Talianu
//
import SwiftUI


struct DataView: View, ViewUpdateListener {
    @StateObject var change = DelayedChange()
    var qList:[Sample4D] = []
    
    class DelayedChange: ObservableObject {
        private var queue: [Sample4D] = .init()
        @Published var value = ""
       
        func addChange(_ newValue: [Sample4D]) {
            queue = newValue
        }
    }
    
    mutating func viewUpdate(_ obj: Any) {
        var dobj = obj as! MockListenerHander
        var qobj:RollingQueue<Sample4D> = dobj.getQueue()
        self.qList = qobj.asList();
        //TODO .. force redraw
        change.addChange(qList)
    }
    
    
    var body: some View {
        VStack {
            Text("This is Dataview Panel!")
            //            Canvas { context, size in
            //                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Drawing Code@*/ /*@END_MENU_TOKEN@*/
            //            }
            Spacer()
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                
                for (i, v) in qList.enumerated() {
                    path.addLine(to: CGPoint(x: Double(i), y: v.y))
                }
            }.stroke()
            
        }.border(Color.red)

    }
}
