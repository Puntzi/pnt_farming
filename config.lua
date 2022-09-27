Config = Config or {}

Config.UseOxInventory = true
Config.Locale = 'en'

Config.DrawDistance  = 5.0
Config.MarkerType    = 1
Config.MarkerSize    = {x = 2.5, y = 2.5, z = 0.5}
Config.MarkerColor   = {r = 60, g = 179, b = 113, a = 255}

Config.DistanceToInteract = 2.0
Config.TimeToRecolect = 5000 --- In miliseconds

Config.Farms = {

    Pears = {
        Blip = {
            active  = true,
            coords  = vec3(351.46, 6517.95, 28.50),
			sprite  = 267,
			display = 4,
			scale   = 1.0,
			color   = 43,
        },

        Zones = {
            vec3(378.035980, 6506.322754, 27.973440),
            vec3(370.367401, 6506.351074, 28.415234),
            vec3(363.324951, 6506.181641, 28.538013),
            vec3(377.708008, 6517.453613, 28.377829),
            vec3(370.464752, 6517.319824, 28.371506),
            vec3(363.062225, 6517.530273, 28.280197),
            vec3(369.404419, 6531.218750, 28.403795),
            vec3(361.861145, 6531.040039, 28.361210),
            vec3(354.234741, 6530.559570, 28.375805)
        },

        ItemName = 'pear',
    },

    Apples = {
        Blip = {
            active  = true,
            coords  = vec3(240.529846, 6514.275879, 31.154852),
			sprite  = 76,
			display = 4,
			scale   = 1.0,
			color   = 1,
        },

        Zones = {
            vec3(281.807098, 6507.239746, 30.139278),
            vec3(272.954132, 6508.000488, 30.428947),
            vec3(264.099579, 6506.519043, 30.673151),
            vec3(281.082306, 6519.305664, 30.169016),
            vec3(272.947998, 6519.351563, 30.428093),
            vec3(262.759827, 6516.696289, 30.703266),
            vec3(280.078278, 6530.406738, 30.203974),
            vec3(271.060577, 6530.471680, 30.484163),
            vec3(262.028931, 6527.436035, 30.726730)
        },

        ItemName = 'apple',
    }
}
