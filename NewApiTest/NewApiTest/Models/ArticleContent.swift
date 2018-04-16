
import Foundation
struct ArticleContent : Codable {
	let type : String?
	let inherit : String?
    let data : [TextData]?

	enum CodingKeys: String, CodingKey {

		case type = "type"
		case inherit = "inherit"
        case data = "data"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		inherit = try values.decodeIfPresent(String.self, forKey: .inherit)
        data = try values.decodeIfPresent([TextData].self, forKey: .data)
	}

}
