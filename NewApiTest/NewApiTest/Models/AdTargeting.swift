

import Foundation
struct AdTargeting : Codable {
	let category : String?

	enum CodingKeys: String, CodingKey {

		case category = "Category"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		category = try values.decodeIfPresent(String.self, forKey: .category)
	}

}
