Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 0
Config.TimerBeforeNewRob    = 1800 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 20   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
	["paleto_twentyfourseven"] = {
		position = { x = 1734.6629638672, y = 6420.6142578125, z = 35.037258148193 },
		reward = math.random(125000, 200000),
		nameOfStore = "24/7. (Paleto Bay)",
		secondsRemaining = 450, -- seconds
		lcdbbed = 0
	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1961.24, y = 3749.46, z = 32.34 },
		reward = math.random(125000, 200000),
		nameOfStore = "24/7. (Sandy Shores)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { x = -709.77783203125, y = -904.10211181641, z = 19.215591430664},
		reward = math.random(125000, 200000),
		nameOfStore = "24/7. (Little Seoul)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["bar_one"] = {
		position = { x = 1990.57, y = 3044.95, z = 47.21 },
		reward = math.random(125000, 200000),
		nameOfStore = "Yellow Jack. (Sandy Shores)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["ocean_liquor"] = {
		position = { x = -2959.4916992188, y = 387.22326660156, z = 14.043260574341 },
		reward = math.random(125000, 200000),
		nameOfStore = "Robs Liquor. (Great Ocean Highway)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["ocean_liquor2"] = {
		position = { x = -3047.8620605469, y = 585.61303710938, z = 7.9089322090149 },
		reward = math.random(125000, 200000),
		nameOfStore = "Robs Liquor. (Great Ocean Highway)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["ocean_liquor3"] = {
		position = { x = -3249.8752441406, y = 1004.3237915039, z = 12.83071231842 },
		reward = math.random(125000, 200000),
		nameOfStore = "Robs Liquor. (Great Ocean Highway)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["rancho_liquor"] = {
		position = { x = 1126.80, y = -980.40, z = 45.41 },
		reward = math.random(125000, 200000),
		nameOfStore = "Robs Liquor. (El Rancho Blvd)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["sanandreas_liquor"] = {
		position = {x = -1220.6580810547, y = -915.85186767578, z = 11.32629776001},
		reward = math.random(125000, 200000),
		nameOfStore = "Robs Liquor. (San Andreas Avenue)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["grove_ltd"] = {
		position = { x = -43.374992370605, y = -1748.4464111328, z = 29.421010971069},
		reward = math.random(125000, 200000),
		nameOfStore = "LTD Gasoline. (Grove Street)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["mirror_ltd"] = {
		position = { x = 1159.5926513672, y = -313.98226928711, z = 69.205055236816 },
		reward = math.random(125000, 200000),
		nameOfStore = "LTD Gasoline. (Mirror Park Boulevard)",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},

	["ADD"] = {
		position = { x = 28.271953582764, y = -1339.3951416016, z = 29.497024536133 },
		reward = math.random(125000, 200000),
		nameOfStore = "Twenty Four Seven.",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},

	["ADD1"] = {
		position = { x = 378.10913085938, y = 333.26577758789, z = 103.56636810303 },
		reward = math.random(125000, 200000),
		nameOfStore = "Twenty Four Seven.",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},

	["ADD2"] = {
		position = { x = -1479.1003417969, y = -375.38891601562, z = 39.163391113281 },
		reward = math.random(125000, 200000),
		nameOfStore = "Liquor Store",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},

	["ADD3"] = {
		position = { x = -1829.1999511719, y = 798.83715820312, z = 138.19065856934 },
		reward = math.random(125000, 200000),
		nameOfStore = "Twenty Four Seven",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["ADD4"] = {
		position = { x = 546.40454101562, y = 2663.0812988281, z = 42.156536102295 },
		reward = math.random(125000, 200000),
		nameOfStore = "Twenty Four Seven",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["ADD6"] = {
		position = { x = 2672.9338378906, y = 3286.5134277344, z = 55.241142272949 },
		reward = math.random(125000, 200000),
		nameOfStore = "Twenty Four Seven",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["Juwelier"] = {
		position = { x = -622.1388, y = -230.9098, z = 38.0570 },
		reward = math.random(250000, 1000000),
		nameOfStore = "Juwelier",
		secondsRemaining = 600, -- seconds
		lcdbbed = 0
	},

	["kledingwinkel1"] = {
		position = { x = -709.0560, y = -151.4288, z = 37.4152 },
		reward = math.random(250000, 1000000),
		nameOfStore = "Kledingwinkel",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["kledingwinkel2"] = {
		position = { x = -822.0356, y = -183.2591, z = 37.5690 },
		reward = math.random(250000, 1000000),
		nameOfStore = "Kledingwinkel",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["kledingwinkel3"] = {
		position = { x = -1193.8147, y = -766.7519, z = 17.3160 },
		reward = math.random(250000, 1000000),
		nameOfStore = "Kledingwinkel",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["winkel"] = {
		position = { x = 168.6465, y = 6644.7651, z = 31.7106 },
		reward = math.random(250000, 500000),
		nameOfStore = "Winkel",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["tattoshop"] = {
		position = { x = -165.1737, y = -303.4370, z = 39.7333 },
		reward = math.random(250000, 500000),
		nameOfStore = "Tattoshop",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
	["kapper"] = {
		position = { x = 1324.7059, y = -1650.2587, z = 52.2751 },
		reward = math.random(250000, 500000),
		nameOfStore = "Kapper",
		secondsRemaining = 400, -- seconds
		lcdbbed = 0
	},
}
