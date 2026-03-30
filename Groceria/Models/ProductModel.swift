//
//  ProductModel.swift
//  Groceria
//
//  Created by Daddy on 30/03/2026.
//

import Foundation

// URL: https://alhebafruits.com/api/products

// MARK: - API envelope
// REVIEW:
// Server response shape is NOT a plain array.
// It returns an envelope like:
// { "status": "...", "message": "...", "data": { "data": [ ProductModel ] } }
// [USER WRONG] decoding as `[ProductModel]` => decode fails => nothing appears.
// [CURSOR FIX] model the response envelope so decoding can succeed.
struct ProductsAPIResponse: Codable {
    let status: String?
    let message: String?
    let data: ProductsDataEnvelope?
}

struct ProductsDataEnvelope: Codable {
    let data: [ProductModel]?
}

// MARK: - ProductModel
struct ProductModel: Identifiable, Codable {
    let id: Int?
    let code: String?
    let link, name, content, currency: String?
    let favorite, inCart: String?
    let idInCart: Int?
    let countInCart: String?
    let background, color, video: String?
    let image: String?
    let sizeGuideImage: String?
    let rate: String?
    let rateCount: Int?
    let rateAll: String?
    let prepareTime: String?
    let priceStart, priceEnd, price, start: String?
    let skip, orderLimit: String?
    let offer, offerType: String?
    let offerPrice, offerPercent, offerAmount, offerAmountAdd: String?
    let stockAmount, maxAmount: String?
    let maxAdditionFree, maxAddition, active, feature: Int?
    let shipping, isFilter, isSale, isLate: Int?
    let isSize, isMax, isNew, isSpecial: Int?
    let isOffer, isStock, isShippingFree, isReturned: Int?
    let isNotify: Int?
    let flag, flagName, orderMax: String?
    let dateStart, dateExpire, dayStart, dayEnd: String?
    let type, status, typeName, statusName: String?
    let orderID: Int?
    let parentID: String?
    let unitID: Int?
    let brandID, colorID, sizeID: String?
    let createdAt: String?
    let unit: Unit?
    let categories: Categories?
    let additions, brand, size, colorAttribute: String?
    
    // REVIEW:
    // API keys are snake_case (e.g. `in_cart`, `rate_count`, `price_start`, `is_filter`).
    // CodingKeys ensures those fields decode into Swift properties.
    enum CodingKeys: String, CodingKey {
        case id, code, link, name, content, currency, favorite
        case inCart = "in_cart"
        case idInCart = "id_in_cart"
        case countInCart = "count_in_cart"
        case background, color, video, image
        case sizeGuideImage = "size_guide_image"
        case rate
        case rateCount = "rate_count"
        case rateAll = "rate_all"
        case prepareTime = "prepare_time"
        case priceStart = "price_start"
        case priceEnd = "price_end"
        case price, start, skip
        case orderLimit = "order_limit"
        case offer
        case offerType = "offer_type"
        case offerPrice = "offer_price"
        case offerPercent = "offer_percent"
        case offerAmount = "offer_amount"
        case offerAmountAdd = "offer_amount_add"
        case stockAmount = "stock_amount"
        case maxAmount = "max_amount"
        case maxAdditionFree = "max_addition_free"
        case maxAddition = "max_addition"
        case active, feature, shipping
        case isFilter = "is_filter"
        case isSale = "is_sale"
        case isLate = "is_late"
        case isSize = "is_size"
        case isMax = "is_max"
        case isNew = "is_new"
        case isSpecial = "is_special"
        case isOffer = "is_offer"
        case isStock = "is_stock"
        case isShippingFree = "is_shipping_free"
        case isReturned = "is_returned"
        case isNotify = "is_notify"
        case flag
        case flagName = "flag_name"
        case orderMax = "order_max"
        case dateStart = "date_start"
        case dateExpire = "date_expire"
        case dayStart = "day_start"
        case dayEnd = "day_end"
        case type, status
        case typeName = "type_name"
        case statusName = "status_name"
        case orderID = "order_id"
        case parentID = "parent_id"
        case unitID = "unit_id"
        case brandID = "brand_id"
        case colorID = "color_id"
        case sizeID = "size_id"
        case createdAt = "created_at"
        case unit, categories, additions, brand, size, colorAttribute
    }
}

extension ProductModel {
    /// Resolves `image` when the API returns a full URL or a site-relative path.
    var resolvedImageURL: URL? {
        guard let raw = image?.trimmingCharacters(in: .whitespacesAndNewlines), !raw.isEmpty else { return nil }
        // REVIEW: API often returns something like `/uploads/products/...`.
        // This converts it into a full URL so `AsyncImage(url:)` can load it.
        if raw.lowercased().hasPrefix("http") { return URL(string: raw) }
        let path = raw.hasPrefix("/") ? raw : "/" + raw
        return URL(string: "https://alhebafruits.com" + path)
    }
    
    var displayPrice: String {
        // REVIEW: show `price` when present, otherwise fall back to `price_start`.
        if let p = price, !p.isEmpty { return p }
        if let p = priceStart, !p.isEmpty { return p }
        return "—"
    }
}

// MARK: - Categories
struct Categories: Codable {
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    /// API sends integers (e.g. parent category id), not strings.
    // [CURSOR FIX] type is `Int?` so JSON can decode.
    let parentID: Int?
    let link, name, content: String?
    let serviceID, image, type, status: String?
    let background, color: String?
    let productsCount, orderID, active: Int?
    let typeName, statusName: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case parentID = "parent_id"
        case link, name, content
        case serviceID = "service_id"
        case image, type, status, background, color
        case productsCount = "products_count"
        case orderID = "order_id"
        case active
        case typeName = "type_name"
        case statusName = "status_name"
        case createdAt = "created_at"
    }
}

// MARK: - Unit
struct Unit: Codable {
    let id: Int?
    let image: String?
    let name: String?
    let orderID, active: Int?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, image, name
        case orderID = "order_id"
        case active
        case createdAt = "created_at"
    }
}
