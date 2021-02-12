SecurityCamConfig = {}

SecurityCamConfig.DebugMode = false
SecurityCamConfig.HideRadar = true

SecurityCamConfig.Locations = {
    {
        camBox = {label = "Pacific Standard Bank", x = 283.67, y = 264.41, z = 105.80},
        cameras = {
            {label = "Camera 1", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = false},
            {label = "Camera 2", x = 269.66, y = 223.67, z = 113.23, r = {x = -30.0, y = 0.0, z = 111.29}, canRotate = false},
            {label = "Camera 3", x = 241.64, y = 233.83, z = 111.48, r = {x = -35.0, y = 0.0, z = 120.46}, canRotate = false},
            {label = "Camera 4", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = false},
            {label = "Camera 5", x = 261.50, y = 218.08, z = 107.95, r = {x = -25.0, y = 0.0, z = -149.49}, canRotate = false},
            {label = "Camera 6", x = 261.98, y = 217.92, z = 113.25, r = {x = -40.0, y = 0.0, z = -159.49}, canRotate = false},
            {label = "Camera 7", x = 258.44, y = 204.97, z = 113.25, r = {x = -30.0, y = 0.0, z = 10.50}, canRotate = false},
            {label = "Camera 8", x = 235.53, y = 227.37, z = 113.23, r = {x = -35.0, y = 0.0, z = -160.29}, canRotate = false},
            {label = "Camera 9", x = 254.72, y = 206.06, z = 113.28, r = {x = -35.0, y = 0.0, z = 44.70}, canRotate = false},
            {label = "Camera 10", x = 269.89, y = 223.76, z = 106.48, r = {x = -35.0, y = 0.0, z = 112.62}, canRotate = false},
            {label = "Camera 11", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = false},
            {label = "Camera 12", x = 251.65, y = 218.66, z = 104.5, r = {x = 0.0, y = 0.0, z = -20.0}, canRotate = true}
        },
        allowedModels = {}
    },
    -- {
        -- camBox = {label = "Fleeca Bank - Algonquin", x = 261.46, y = 203.65, z = 110.28},
        -- cameras = {
            -- {label = "Camera 1", x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.91}},
            -- {label = "Camera 2", x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}},
            -- {label = "Camera 3", x = 261.50, y = 218.08, z = 107.95, r = {x = -25.0, y = 0.0, z = -149.49}}, 
            -- {label = "Camera 4", x = 241.64, y = 233.83, z = 111.48, r = {x = -35.0, y = 0.0, z = 120.46}},
            -- {label = "Camera 5", x = 269.66, y = 223.67, z = 113.23, r = {x = -30.0, y = 0.0, z = 111.29}},
            -- {label = "Camera 6", x = 261.98, y = 217.92, z = 113.25, r = {x = -40.0, y = 0.0, z = -159.49}},
            -- {label = "Camera 7", x = 258.44, y = 204.97, z = 113.25, r = {x = -30.0, y = 0.0, z = 10.50}},
            -- {label = "Camera 8", x = 235.53, y = 227.37, z = 113.23, r = {x = -35.0, y = 0.0, z = -160.29}},
            -- {label = "Camera 9", x = 254.72, y = 206.06, z = 113.28, r = {x = -35.0, y = 0.0, z = 44.70}},
            -- {label = "Camera 10", x = 269.89, y = 223.76, z = 106.48, r = {x = -35.0, y = 0.0, z = 112.62}},
            -- {label = "Camera 11", x = 252.27, y = 225.52, z = 103.99, r = {x = -35.0, y = 0.0, z = -74.87}}
        -- },
        -- allowedModels = {}
     -- },
    {
        camBox = {label = "Blaine County Savings Bank", x = -116.84, y = 6479.87, z = 31.45},
        cameras = {
			{label = "(Front Entrance)", x = -107.9, y = 6462.71, z = 33.63, r = {x = -25.0, y = 0.0, z = 2.48}},
            {label = "(Front Entrance 2)", x = -115.13, y = 6472.32, z = 33.63, r = {x = -25.0, y = 0.0, z = 219.82}},
            {label = "(Front Entrance 3)", x = -103.95, y = 6467.66, z = 33.63, r = {x = -25.0, y = 0.0, z = 118.11}},
            {label = "(Bank Vault)", x = -103.63, y = 6467.98, z = 33.63, r = {x = -25.0, y = 0.0, z = 17.38}},
            {label = "(Bank Vault 2)", x = -107.14, y = 6476.21, z = 33.63, r = {x = -35.0, y = 0.0, z = 202.47}},
            {label = "(Bank Vault 3)", x = -104.53, y = 6479.56, z = 33.63, r = {x = -35.0, y = 0.0, z = 170.28}}    
        },
        allowedModels = {}
     },
    {
        camBox = {label = "Fleeca - Alta District", x = 322.03, y = -305.47, z = 52.64},
        cameras = {
			{label = "(Front Entrance)", x = 317.56, y = -280.43, z = 56.16, r = {x = -25.0, y = 0.0, z = 46.14}},
            {label = "(Front Entrance 2)", x = 308.32, y = -278.96, z = 56.16, r = {x = -25.0, y = 0.0, z = 330.22}},
            {label = "(Bank Vault)", x = 307.85, y = -280.62, z = 56.16, r = {x = -25.0, y = 0.0, z = 231.89}},
            {label = "(Bank Vault 2)", x = 309.22, y = -281.71, z = 56.16, r = {x = -35.0, y = 0.0, z = 228.29}}    
        },
        allowedModels = {}
     },
    {
        camBox = {label = "Fleeca - Great Ocean Highway", x = -2955.74, y = 473.10, z = 15.46},
        cameras = {
			{label = "(Front Entrance)", x = -2962.29, y = 486.5, z = 17.7, r = {x = -25.0, y = 0.0, z = 166.98}},
            {label = "(Front Entrance 2)", x = -2960.61, y = 477.29, z = 17.7, r = {x = -25.0, y = 0.0, z = 78.66}},
            {label = "(Bank Vault)", x = -2959.25, y = 477.27, z = 17.7, r = {x = -25.0, y = 0.0, z = 329.05}},
            {label = "(Bank Vault 2)", x = -2958.73, y = 478.95, z = 17.7, r = {x = -35.0, y = 0.0, z = 322.71}}    
        },
        allowedModels = {}
     },
    {
        camBox = {label = "Fleeca - Rockford Hills District", x = -1201.43, y = -338.50, z = 38.08},
        cameras = {
			{label = "(Front Entrance)", x = -1209.28, y = -329.26, z = 39.78, r = {x = -25.0, y = 0.0, z = 98.61}},
            {label = "(Front Entrance 2)", x = -1216.75, y = -335.03, z = 39.78, r = {x = -25.0, y = 0.0, z = 14.93}},
            {label = "(Bank Vault)", x = -1215.92, y = -336.37, z = 39.78, r = {x = -25.0, y = 0.0, z = 271.6}},
            {label = "(Bank Vault 2)", x = -1214.29, y = -335.98, z = 39.78, r = {x = -35.0, y = 0.0, z = 261.12}}   
        },
        allowedModels = {}
     },
    {
        camBox = {label = "Fleeca - Pillbox Hill District", x = 146.17, y = -1058.67, z = 30.18},
        cameras = {
			{label = "(Front Entrance)", x = 153.12, y = -1042.16, z = 31.37, r = {x = -25.0, y = 0.0, z = 53.46}},
            {label = "(Front Entrance 2)", x = 143.93, y = -1040.56, z = 31.37, r = {x = -25.0, y = 0.0, z = 330.8}},
            {label = "(Bank Vault)", x = 143.33, y = -1042.5, z = 31.37, r = {x = -25.0, y = 0.0, z = 220.36}},
            {label = "(Bank Vault 2)", x = 144.95, y = -1043.17, z = 31.37, r = {x = -35.0, y = 0.0, z = -160.29}}   
        },
        allowedModels = {}
     },
    {
        camBox = {label = "Fleeca - Burton District", x = -344.72, y = -79.18, z = 45.66},
        cameras = {
			{label = "(Front Entrance)", x = -347.58, y = -51.21, z = 51.04, r = {x = -25.0, y = 0.0, z = 50.0}},
            {label = "(Front Entrance 2)", x = -356.82, y = -49.61, z = 51.04, r = {x = -25.0, y = 0.0, z = 320.00}},
            {label = "(Bank Vault)", x = -357.39, y = -51.53, z = 51.04, r = {x = -25.0, y = 0.0, z = 220.0}},
			{label = "(Bank Vault 2)", x = -355.84, y = -52.39, z = 51.04, r = {x = -35.0, y = 0.0, z = 213.08}}   
        },
        allowedModels = {}
    }
}