// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ModelWeather: Decodable {
    let geoObject: GeoObject?
    let yesterday: Yesterday?
    let fact: Fact?
  //  let forecasts: [Forecast]?

    enum CodingKeys: String, CodingKey {
        case geoObject = "geo_object"
        case yesterday = "yesterday"
        case fact = "fact"
       // case forecasts = "forecasts"
    }
}

// MARK: - Fact
struct Fact: Decodable {
    let temp: Int
    let feelsLike: Int
    let icon: String
    let condition: String
    let precType: Int

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case icon = "icon"
        case condition = "condition"
        case precType = "prec_type"
    }
}
let Condition:[String:String] = [
    "clear":"ясно.",
    "partly-cloudy" : "малооблачно.",
    "cloudy":"облачно с прояснениями.",
    "overcast" : "пасмурно.",
    "drizzle" : "морось.",
    "light-rain" : "небольшой дождь.",
    "rain" : "дождь.",
    "moderate-rain" : "умеренно сильный дождь.",
    "heavy-rain" : "сильный дождь.",
    "continuous-heavy-rain" : "длительный сильный дождь.",
    "showers" : "ливень.",
    "wet-snow" : "дождь со снегом.",
    "light-snow ": "небольшой снег.",
    "snow" : "снег.",
    "snow-showers" : "снегопад.",
    "hail" : "град.",
    "thunderstorm" : "гроза.",
    "thunderstorm-with-rain" : "дождь с грозой.",
    "thunderstorm-with-hail" : "гроза с градом."
]
// MARK: - AccumPrec
struct AccumPrec: Decodable {
    let the1: Int?
    let the3: Int?
    let the7: Double?

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
        case the3 = "3"
        case the7 = "7"
    }
}

// MARK: - Forecast
struct Forecast: Decodable {
    let date: String?
    let dateTs: Int?
    let week: Int?
    let sunrise: String?
    let sunset: String?
    let riseBegin: String?
    let setEnd: String?
    let moonCode: Int?
    let moonText: String?
    let parts: Parts?
    let hours: [Hour]?
    let biomet: Biomet?

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case dateTs = "date_ts"
        case week = "week"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case riseBegin = "rise_begin"
        case setEnd = "set_end"
        case moonCode = "moon_code"
        case moonText = "moon_text"
        case parts = "parts"
        case hours = "hours"
        case biomet = "biomet"
    }
}

// MARK: - Biomet
struct Biomet: Decodable {
    let index: Int?
    let condition: String?

    enum CodingKeys: String, CodingKey {
        case index = "index"
        case condition = "condition"
    }
}

// MARK: - Hour
struct Hour: Decodable {
    let hour: String?
    let hourTs: Int?
    let temp: Int?
    let feelsLike: Int?
    let tempWater: Int?
    let icon: String?
    let condition: String?
    let cloudness: Double?
    let precType: Int?
    let precStrength: Double?
    let isThunder: Bool?
    let windDir: String?
    let windSpeed: Double?
    let windGust: Double?
    let pressureMm: Int?
    let pressurePa: Int?
    let humidity: Int?
    let uvIndex: Int?
    let precMm: Double?
    let precPeriod: Int?
    let precProb: Int?

    enum CodingKeys: String, CodingKey {
        case hour = "hour"
        case hourTs = "hour_ts"
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempWater = "temp_water"
        case icon = "icon"
        case condition = "condition"
        case cloudness = "cloudness"
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case isThunder = "is_thunder"
        case windDir = "wind_dir"
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity = "humidity"
        case uvIndex = "uv_index"
        case precMm = "prec_mm"
        case precPeriod = "prec_period"
        case precProb = "prec_prob"
    }
}

// MARK: - Parts
struct Parts: Decodable {
    let evening: Day?
    let night: Day?
    let morning: Day?
    let dayShort: Day?
    let nightShort: Day?
    let day: Day?

    enum CodingKeys: String, CodingKey {
        case evening = "evening"
        case night = "night"
        case morning = "morning"
        case dayShort = "day_short"
        case nightShort = "night_short"
        case day = "day"
    }
}

// MARK: - Day
struct Day: Decodable {
    let source: String?
    let tempMin: Int?
    let tempAvg: Int?
    let tempMax: Int?
    let tempWater: Int?
    let windSpeed: Double?
    let windGust: Double?
    let windDir: String?
    let pressureMm: Int?
    let pressurePa: Int?
    let humidity: Int?
    let precMm: Double?
    let precProb: Int?
    let precPeriod: Int?
    let cloudness: Double?
    let precType: Int?
    let precStrength: Double?
    let icon: String?
    let condition: String?
    let uvIndex: Int?
    let feelsLike: Int?
    let daytime: String?
    let polar: Bool?
    let freshSnowMm: Int?
    let temp: Int?

    enum CodingKeys: String, CodingKey {
        case source = "_source"
        case tempMin = "temp_min"
        case tempAvg = "temp_avg"
        case tempMax = "temp_max"
        case tempWater = "temp_water"
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity = "humidity"
        case precMm = "prec_mm"
        case precProb = "prec_prob"
        case precPeriod = "prec_period"
        case cloudness = "cloudness"
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case icon = "icon"
        case condition = "condition"
        case uvIndex = "uv_index"
        case feelsLike = "feels_like"
        case daytime = "daytime"
        case polar = "polar"
        case freshSnowMm = "fresh_snow_mm"
        case temp = "temp"
    }
}

// MARK: - GeoObject
struct GeoObject: Decodable {
    let district: Country?
    let locality: Country?
    let province: Country?
    let country: Country?

    enum CodingKeys: String, CodingKey {
        case district = "district"
        case locality = "locality"
        case province = "province"
        case country = "country"
    }
}

// MARK: - Country
struct Country: Decodable {
    let id: Int?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

// MARK: - Yesterday
struct Yesterday: Decodable {
    let temp: Int?

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
    }
}
