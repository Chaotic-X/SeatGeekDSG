//
//  ListRow.swift
//  SeatGeekDSG
//
//  Created by Alex Lundquist on 4/4/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListRow: View {

    @EnvironmentObject var favorite: Favorites
    var data: Event
    var heart: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .frame(width: 25, height: 25)
            .foregroundColor(Color.red)
            .shadow(color: .gray, radius: 2, x: 2, y: 2)
    }
    var listImage: some View {
        Group {
            if let urlString = data.performers.first?.image {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60, alignment: .center)
                    .cornerRadius(6)
                    .padding(.leading, 15)
            }
        }
    }
    var body: some View {
        HStack(spacing: 8){
            ZStack{
                listImage
                if favorite.contains(data) {
                    heart
                        .offset(x: -20, y: -25)                    
                }
            }
            VStack(alignment: .leading, spacing: 2){
                Text(data.venue.name)
                    .font(.system(size: 14, weight: .bold, design: .default))
                Text("\(data.venue.city), \(data.venue.state)")
                    .font(.system(size: 14, weight: .light, design: .default))
                Text(data.formattedDate)
                    .font(.system(size: 14, weight: .thin, design: .default))
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .foregroundColor(Color.black)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

//struct ListRow_Preview: PreviewProvider {
//    static var previews: some View {
//        ListRow(textTitle: "This Text is some crazy Text in this label", place: "Mimai, FL", time: "Weds 12, Jul 2019 7:30 PM", imagePlace: "Audrey", isFavorite: true)
//            .previewLayout(.sizeThatFits)
//    }
//}
