

import Foundation
struct Articles : Codable {
    let type : String?
    let id : Int?
    let title : String?
    let name : String?
    let url : String?
    let comments : Bool?
    let redirect : String?
    let excerpt : String?
    let image : String?
    let imageWidth : Int?
    let imageHeight : Int?
    let imageCaption : String?
    let author : String?
    let authorImage : String?
    let relatedLinks : [RelatedLinks]?
    let date : Int?
    let modified : Int?
    let categories : [String]?
    let icons : [String]?
    let adString : String?
    let adTargeting : AdTargeting?
    let articleContent : [ArticleContent]?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case id = "id"
        case title = "title"
        case name = "name"
        case url = "url"
        case comments = "comments"
        case redirect = "redirect"
        case excerpt = "excerpt"
        case image = "image"
        case imageWidth = "imageWidth"
        case imageHeight = "imageHeight"
        case imageCaption = "imageCaption"
        case author = "author"
        case authorImage = "authorImage"
        case relatedLinks = "relatedLinks"
        case date = "date"
        case modified = "modified"
        case categories = "categories"
        case icons = "icons"
        case adString = "adString"
        case adTargeting
        case articleContent = "content"
    }

	init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        comments = try values.decodeIfPresent(Bool.self, forKey: .comments)
        redirect = try values.decodeIfPresent(String.self, forKey: .redirect)
        excerpt = try values.decodeIfPresent(String.self, forKey: .excerpt)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        imageWidth = try values.decodeIfPresent(Int.self, forKey: .imageWidth)
        imageHeight = try values.decodeIfPresent(Int.self, forKey: .imageHeight)
        imageCaption = try values.decodeIfPresent(String.self, forKey: .imageCaption)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        authorImage = try values.decodeIfPresent(String.self, forKey: .authorImage)
        relatedLinks = try values.decodeIfPresent([RelatedLinks].self, forKey: .relatedLinks)
        date = try values.decodeIfPresent(Int.self, forKey: .date)
        modified = try values.decodeIfPresent(Int.self, forKey: .modified)
        categories = try values.decodeIfPresent([String].self, forKey: .categories)
        icons = try values.decodeIfPresent([String].self, forKey: .icons)
        adString = try values.decodeIfPresent(String.self, forKey: .adString)
        adTargeting = try AdTargeting(from: decoder)
        articleContent = try values.decodeIfPresent([ArticleContent].self, forKey: .articleContent)
	}

}
