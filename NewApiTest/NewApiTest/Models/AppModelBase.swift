
import Foundation
struct AppModelBase : Codable {
	let settings : Settings?
    let structure : [Structure]?
    let articles : [Articles]?

	enum CodingKeys: String, CodingKey {

		case settings
        case structure = "structure"
        case articles = "articles"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		settings = try Settings(from: decoder)
        structure = try values.decodeIfPresent([Structure].self, forKey: .structure)
        articles = try values.decodeIfPresent([Articles].self, forKey: .articles)
	}

}
