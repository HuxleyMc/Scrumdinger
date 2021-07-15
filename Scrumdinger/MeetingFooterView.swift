//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Huxley McGuffin on 14/7/21.
//

import SwiftUI

struct MeetingFooterView: View {

    let speakers: [ScrumTimer.Speaker]

    var skipAction: () -> Void

    private var speakerNumber: Int? {
        
        let _ = print(speakers)
        

        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }

        return index + 1

    }

    private var isLastSpeaker: Bool {
        let isLast = speakers.allSatisfy { $0.isCompleted }
        return isLast

    }

    private var speakerText: String {

        guard let speakerNumber = speakerNumber else { return "No more speakers" }

        return "Speaker \(speakerNumber) of \(speakers.count)"

    }

    var body: some View {

        VStack {

            HStack {
                
                if isLastSpeaker {

                    Text("Last Speaker")

                } else {

                    Text(speakerText)

                    Spacer()

                    Button(action: skipAction) {

                        Image(systemName:"forward.fill")

                    }

                    .accessibilityLabel(Text("Next speaker"))

                }

            }

        }
        .padding([.bottom, .horizontal])

    }

}

struct MeetingFooterView_Previews: PreviewProvider {
    static var speakers = [
        ScrumTimer.Speaker(name: "Larry", isCompleted: true),
        ScrumTimer.Speaker(name: "Ben", isCompleted: false),
        ScrumTimer.Speaker(name: "John", isCompleted: false),
        ScrumTimer.Speaker(name: "Harry", isCompleted: false),
    ]
    static var previews: some View {
        MeetingFooterView(speakers: speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
