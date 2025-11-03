--- IMPORTANT: check out client/editables/editables.lua, add your vehicle locking logic there, check out route making tool and so on!
-- Make sure to check out qb or esx setup installation if you are one of those frameworks
-- Ensure the script in your script.cfg

Config = {}

-- Type in 'esx' or 'qbcore' depending on your framework
-- Type in '' if you are using standalone version
Config.framework = 'esx'

Config.target = {
    enabled = true,
    system = 'ox_target'
}

Config.job = {
    jobOnly = false,
    name = 'Trucker'
}

Config.debug = false

-- The vehicle model that the pilot player will be using
-- Changing pilot vehicle model will lose custom livery
Config.pilotVehicleModel = 'dorado'

-- How much time the script waits for the player to move from the vehicle spawn location
-- When time is up, the player is cancelled and the vehicles inside the spawn location are deleted
Config.waitTime = 90 --seconds

Config.units = 'metric' -- metric or imperial

Config.qbSettings = {
    account = 'bank' -- bank or cash
}

Config.esxSettings = {
    account = 'bank', -- bank or money
    useNewESXExport = true
}

Config.keybinds = {
    interact = 'E'
}

Config.hq = {
    laptopCoords = vector4(2681.3, 3507.7, 53.24, 250.0),
    tableCoords = vector4(2681.3, 3507.7, 52.4, 250.0),

    blip = {
        showBlip = true, -- whether or not to show the location blip on the map
        blipColor = 25,
        blipIcon = 477,
        blipLabel = 'Trucking Job'
    }
}

Config.missionVehicleSpawnLocTable = {
    {
        isTaken = false,
        ['truck1'] = {
            x = 2642.95,
            y = 3530.2,
            z = 53.5,
            w = 156.0
        },
        ['truck2'] = {
            x = 2653.2,
            y = 3529.2,
            z = 53.5,
            w = 154.38
        },
        ['pilot'] = {
            x = 2658.2,
            y = 3530.6,
            z = 52.49,
            w = 156.0
        }
    },
    {
        isTaken = false,
        ['truck1'] = {
            x = 2629.4,
            y = 3500.2,
            z = 54.21,
            w = 156.0
        },
        ['truck2'] = {
            x = 2631.9,
            y = 3495.3,
            z = 54.56,
            w = 155.1
        },
        ['pilot'] = {
            x = 2636.5,
            y = 3491.6,
            z = 54.1,
            w = 156.0
        }
    },
}

-- Coordinates of where players will be standing in the lobby
Config.lobbyCoords = {
    ['firstPlayer'] = {
        x = 2667.0,
        y = 3511.0,
        z = 53.0,
        w = 335.0
    },
    ['secondPlayer'] = {
        x = 2665.5,
        y = 3510.0,
        z = 53.0,
        w = 335.0
    },
    ['thirdPlayer'] = {
        x = 2668.5,
        y = 3510.0,
        z = 53.0,
        w = 335.0
    }
}

Config.sellerPed = {
    message = 'Deliver cargo',
    pedModel = 'g_m_m_mexboss_01',
    duration = 2000, -- selling duration in ms

    blip = {
        showBlip = true, -- whether or not to show the location blip on the map
        blipColor = 25,
        blipIcon = 431,
        blipLabel = 'Cargo Delivery'
    }
}

--Add your own brand logos in ls_trucking/images folder and paste the name of the image there
--Make sure to do "refresh" in F8 console and restart the script
Config.brandLogoNames = {
    'champion.jpg',
    'flying-pig.jpg',
    'landau-construction.jpg',
    'last-mile.jpg',
    'royal.jpg',
    'joe-hardwood.jpg',
    'ColdGecko.png',
    'EdgeKart.png',
    'Pastel&Co.png',
    'OmegaMillion.png'
}

Config.contractCargo = {
    ['vehicles'] = {
        --Utility
        {
            trailers = {
                'freighttrailer',
                'armytrailer'
            },
            freight = {
                {
                    model = 'tractor2',
                    label = 'Tractors'
                }
            },
            descriptions = {
                'Deliver this tractor to a family eagerly awaiting their new addition from AgriLife.',
                'Make sure these tractors arrive without delay, ready to assist with the day’s work on the field.',
                'Get these tractors to their new home smoothly.',
                'Handle and deliver these tractors securely, making sure they’re positioned correctly for farm operations.',
                'Transport this tractor to a local entrepreneur who’s ready to use their new Landcraft equipment.',
            }
        },
        --Normal vehicles
        {
            trailers = {
                'freighttrailer',
                'armytrailer'
            },
            freight = {
                {
                    model = 'club',
                    label = 'Small Hatchbacks',
                },
                {
                    model = 'dilettante',
                    label = 'Cheap EVs',
                },
                {
                    model = 'panto',
                    label = 'Smart Cars'
                }
            },
            descriptions = {
                'Transport these economical vehicles to a small business; they’re needed to start a new delivery service using their fresh Fleetline models.',
                'Drop off these affordable rides to a new driver; they’re thrilled to get started with their first car from AutoTrend.',
                'Deliver these cost-effective vehicles to a community group; they’re gearing up for their new project with their latest budget-friendly models from CityCruiser.',
                'Get these economical cars to the enthusiastic buyers who can’t wait to start driving their new vehicles from ValueDrive.',
                'Make sure these economical cars arrive safely; they’re needed for a community car-sharing program.',
            },
        },
        --Sports vehicles
        {
            trailers = {
                'freighttrailer',
                'armytrailer'
            },
            freight = {
                {
                    model = 'gt500',
                    label = 'Muscle cars'
                },
                {
                    model = 'torero',
                    label = 'Sports classics'
                },
                {
                    model = 'tornado6',
                    label = 'Retro cars'
                }
            },
            descriptions = {
                'Customer\'s vehicle shipment has arrived. Transport these exotics with care.',
                'A new wave of Italian classics have arrived. Deliver these sports classics for an up-coming car meet.',
                'A Chinese scalper has won the auction and needs your help to deliver mechanical wonders.'
            },
        },
        -- Caravan
        {
            trailers = {
                'freighttrailer',
            },
            freight = {
                {
                    model = 'proptrailer',
                    label = 'Caravan',
                },
            },
            descriptions = {
                'Help this family move their caravan to their new address.',
                'The caravan had better days, but its all they can afford. So help them move it to their new plot.'
            },
        },
    },

    ['cargo'] = {
        {
            trailers = {
                'freighttrailer',
            },
            freight = {
                {
                    model = 'ls_blade',
                    label = 'Wind Turbine blade'
                },
            },
            descriptions = {
                'Storm has ripped and destroyed a wind turbine. Transport the blade to help them reconstruct the mill',
                'A new park of sustainable energy is being built. Delivery the wind turbine blade to them.'
            },
        },
        {
            trailers = {
                'freighttrailer',
            },
            freight = {
                {
                    model = 'sf_prop_sf_gas_tank_01a',
                    label = 'Gas Tank'
                },
                {
                    model = 'prop_staticmixer_01',
                    label = 'Static Mixer'
                },
            },
            descriptions = {
                'New projects are being built, delivery of industrial equipment is needed',
                'Real Estate is booming, transport this heavy duty equipment!'
            },
        },
        {
            trailers = {
                'freighttrailer',
            },
            freight = {
                {
                    model = 'prop_rub_buswreck_06',
                    label = 'Bus Wreckage',
                },
            },
            descriptions = {
                'Deliver this wreckage for scrapping, you do not have to be gentle'
            },
        },
    }
}

Config.contracts = {
    ['singlePlayer'] = {
        moneyMin = 2500,
        moneyMax = 5000,
        ['trucks'] = {
            'phantom',
            'packer',
        },

        ['routes'] = {
            {
                {x=2153.50,y=3011.30,z=44.68},
                {x=309.44,y=2645.61,z=43.88},
                {x=107.74,y=2283.55,z=97.55},
                {x=-130.43,y=1928.68,z=196.29},
            },
            {
                {x=2727.19,y=3291.86,z=55.13},
                {x=1715.73,y=1622.06,z=82.61},
                {x=1063.23,y=457.73,z=92.10},
                {x=1139.05,y=749.00,z=145.46},
                {x=482.52,y=873.34,z=197.46},
                {x=366.79,y=788.38,z=186.26},
            },
            {
                {x=2206.88,y=3703.46,z=37.27},
                {x=2478.80,y=4538.05,z=34.92},
                {x=1315.30,y=4370.30,z=41.31},
            },
            {
                {x=2075.02,y=2662.02,z=51.75},
                {x=1676.82,y=1383.82,z=86.90},
                {x=531.70,y=-331.90,z=43.59},
                {x=792.48,y=-1407.34,z=27.27},
                {x=723.74,y=-3008.36,z=9.04},
                {x=1246.56,y=-3295.19,z=5.80},
            },
            {
                {x=1345.42,y=2687.87,z=37.72},
                {x=-279.09,y=2895.49,z=45.72},
                {x=-1647.67,y=2432.59,z=26.94},
                {x=-3030.55,y=1898.42,z=28.94},
                {x=-3090.35,y=1343.61,z=20.24},
                {x=-3253.02,y=987.42,z=12.45},
            },
            {
                {x=2399.57,y=3207.00,z=47.38},
                {x=1835.99,y=3299.74,z=43.23},
                {x=740.38,y=3522.62,z=34.17},
                {x=-209.57,y=3820.32,z=38.43},
                {x=154.36,y=4418.37,z=75.78},
                {x=-596.89,y=5003.18,z=143.15},
                {x=-733.50,y=5197.59,z=104.48},
                {x=-665.49,y=5242.93,z=76.79},
                {x=-569.17,y=5256.91,z=70.47},
            },
            {
                {x=1860.53,y=2385.28,z=54.19},
                {x=2486.95,y=815.16,z=94.65},
                {x=2194.31,y=-765.68,z=68.91},
                {x=1762.63,y=-1396.51,z=111.45},
                {x=1719.89,y=-1731.48,z=112.49},
                {x=1708.63,y=-1661.63,z=112.47},
            },
        },
    },
    ['twoPlayer'] = {
        moneyMin = 5000,
        moneyMax = 10000,
        ['trucks'] = {
            --'phantom',
            'packer'
        },

        ['routes'] = {
            {
                {x=2669.62,y=3449.12,z=55.12},
                {x=1857.72,y=3211.85,z=44.55},
                {x=1191.09,y=2976.45,z=39.87},
                {x=491.32,y=3078.45,z=39.80},
                {x=-98.00,y=2982.72,z=36.58},
                {x=-724.25,y=2965.96,z=24.51},
                {x=-1627.90,y=2998.55,z=31.07},
            },
            {
                {x=2805.05,y=3396.02,z=55.30},
                {x=2780.65,y=4518.41,z=46.10},
                {x=2444.27,y=5691.90,z=44.53},
                {x=1424.14,y=6470.69,z=19.86},
                {x=458.43,y=6571.81,z=26.35},
                {x=148.27,y=6352.75,z=30.77},
            },
            {
                {x=1059.96,y=2686.37,z=39.14},
                {x=-168.39,y=1890.20,z=198.23},
                {x=-731.87,y=1149.50,z=262.64},
                {x=-385.25,y=1219.92,z=325.64},
            },
            {
                {x=2097.92,y=1381.84,z=75.56},
                {x=2359.29,y=-312.11,z=85.18},
                {x=1265.21,y=-1125.39,z=50.50},
                {x=1092.02,y=-1178.75,z=45.61},
                {x=1064.85,y=-1743.36,z=35.10},
                {x=957.73,y=-1700.31,z=28.91},
            },
            {
                {x=2214.84,y=3012.19,z=45.28},
                {x=306.91,y=2646.27,z=44.49},
                {x=-2098.31,y=2307.57,z=37.63},
                {x=-1918.28,y=2030.95,z=140.74},
            },
            {
                {x=2206.88,y=3703.46,z=37.27},
                {x=2478.80,y=4538.05,z=34.92},
                {x=1315.30,y=4370.30,z=41.31},
            },
            {
                {x=2075.02,y=2662.02,z=51.75},
                {x=1676.82,y=1383.82,z=86.90},
                {x=531.70,y=-331.90,z=43.59},
                {x=792.48,y=-1407.34,z=27.27},
                {x=723.74,y=-3008.36,z=9.04},
                {x=1246.56,y=-3295.19,z=5.80},
            },
            {
                {x=1345.42,y=2687.87,z=37.72},
                {x=-279.09,y=2895.49,z=45.72},
                {x=-1647.67,y=2432.59,z=26.94},
                {x=-3030.55,y=1898.42,z=28.94},
                {x=-3090.35,y=1343.61,z=20.24},
                {x=-3253.02,y=987.42,z=12.45},
            },
            {
                {x=2399.57,y=3207.00,z=47.38},
                {x=1835.99,y=3299.74,z=43.23},
                {x=740.38,y=3522.62,z=34.17},
                {x=-209.57,y=3820.32,z=38.43},
                {x=154.36,y=4418.37,z=75.78},
                {x=-596.89,y=5003.18,z=143.15},
                {x=-733.50,y=5197.59,z=104.48},
                {x=-665.49,y=5242.93,z=76.79},
                {x=-569.17,y=5256.91,z=70.47},
            },
            {
                {x=1860.53,y=2385.28,z=54.19},
                {x=2486.95,y=815.16,z=94.65},
                {x=2194.31,y=-765.68,z=68.91},
                {x=1762.63,y=-1396.51,z=111.45},
                {x=1719.89,y=-1731.48,z=112.49},
                {x=1708.63,y=-1661.63,z=112.47},
            },
            {
                {x=1312.30,y=2684.89,z=37.68},
                {x=207.59,y=2630.89,z=47.62},
                {x=-17.15,y=2083.15,z=156.77},
                {x=309.99,y=1033.93,z=210.64},
                {x=783.19,y=1280.57,z=360.30},
            },
            {
                {x=2936.34,y=3776.81,z=52.67},
                {x=2464.73,y=5665.03,z=45.07},
                {x=313.50,y=6580.69,z=29.32},
                {x=-747.31,y=5517.95,z=35.82},
                {x=-668.64,y=5789.26,z=17.33},
            },
            {
                {x=2123.25,y=3007.55,z=45.19},
                {x=324.35,y=2649.62,z=44.61},
                {x=285.73,y=2862.10,z=43.64},
            },
            {
                {x=2841.46,y=3476.25,z=54.96},
                {x=2817.63,y=4391.41,z=49.34},
                {x=3073.51,y=3988.65,z=73.33},
                {x=3416.44,y=3748.30,z=30.58},
                {x=3489.44,y=3685.10,z=33.88},
            },
            {
                {x=2921.07,y=3718.57,z=52.65},
                {x=2816.09,y=4396.78,z=49.25},
                {x=2805.72,y=4907.24,z=36.18},
                {x=3036.60,y=5036.28,z=26.06},
                {x=3299.06,y=5155.78,z=18.42},
            },
            {
                {x=2389.84,y=2964.42,z=49.07},
                {x=2601.79,y=2512.40,z=29.50},
                {x=2360.07,y=1181.94,z=60.26},
                {x=2427.97,y=687.55,z=132.37},
                {x=2209.41,y=132.37,z=226.91},
                {x=1789.67,y=-79.06,z=190.28},
                {x=1671.33,y=-64.13,z=173.78},
            },
            {
                {x=2140.68,y=3009.61,z=45.25},
                {x=328.21,y=2650.84,z=44.66},
                {x=-127.61,y=1923.99,z=197.31},
            },
            {
                {x=2448.89,y=2962.04,z=40.71},
                {x=2178.37,y=1262.16,z=75.97},
                {x=2552.21,y=419.51,z=108.46},
            },
            {
                {x=2353.74,y=3218.36,z=46.87},
                {x=1576.09,y=3104.95,z=40.89},
                {x=1124.75,y=2878.73,z=39.17},
                {x=1414.61,y=2312.61,z=74.69},
                {x=1263.59,y=1905.17,z=78.77},
            }
        }
    },

    ['threePlayer'] = {
        moneyMin = 10000,
        moneyMax = 20000,
        ['trucks'] = {
            'phantom',
            'packer'
        },

        ['routes'] = {
            {
                {x=2669.62,y=3449.12,z=55.12},
                {x=1857.72,y=3211.85,z=44.55},
                {x=1191.09,y=2976.45,z=39.87},
                {x=491.32,y=3078.45,z=39.80},
                {x=-98.00,y=2982.72,z=36.58},
                {x=-724.25,y=2965.96,z=24.51},
                {x=-1627.90,y=2998.55,z=31.07},
            },
            {
                {x=2805.05,y=3396.02,z=55.30},
                {x=2780.65,y=4518.41,z=46.10},
                {x=2444.27,y=5691.90,z=44.53},
                {x=1424.14,y=6470.69,z=19.86},
                {x=458.43,y=6571.81,z=26.35},
                {x=148.27,y=6352.75,z=30.77},
            },
            {
                {x=1059.96,y=2686.37,z=39.14},
                {x=-168.39,y=1890.20,z=198.23},
                {x=-731.87,y=1149.50,z=262.64},
                {x=-385.25,y=1219.92,z=325.64},
            },
            {
                {x=2097.92,y=1381.84,z=75.56},
                {x=2359.29,y=-312.11,z=85.18},
                {x=1265.21,y=-1125.39,z=50.50},
                {x=1092.02,y=-1178.75,z=45.61},
                {x=1064.85,y=-1743.36,z=35.10},
                {x=957.73,y=-1700.31,z=28.91},
            },
            {
                {x=2214.84,y=3012.19,z=45.28},
                {x=306.91,y=2646.27,z=44.49},
                {x=-2098.31,y=2307.57,z=37.63},
                {x=-1918.28,y=2030.95,z=140.74},
            },
            {
                {x=2206.88,y=3703.46,z=37.27},
                {x=2478.80,y=4538.05,z=34.92},
                {x=1315.30,y=4370.30,z=41.31},
            },
            {
                {x=2075.02,y=2662.02,z=51.75},
                {x=1676.82,y=1383.82,z=86.90},
                {x=531.70,y=-331.90,z=43.59},
                {x=792.48,y=-1407.34,z=27.27},
                {x=723.74,y=-3008.36,z=9.04},
                {x=1246.56,y=-3295.19,z=5.80},
            },
            {
                {x=1345.42,y=2687.87,z=37.72},
                {x=-279.09,y=2895.49,z=45.72},
                {x=-1647.67,y=2432.59,z=26.94},
                {x=-3030.55,y=1898.42,z=28.94},
                {x=-3090.35,y=1343.61,z=20.24},
                {x=-3253.02,y=987.42,z=12.45},
            },
            {
                {x=2399.57,y=3207.00,z=47.38},
                {x=1835.99,y=3299.74,z=43.23},
                {x=740.38,y=3522.62,z=34.17},
                {x=-209.57,y=3820.32,z=38.43},
                {x=154.36,y=4418.37,z=75.78},
                {x=-596.89,y=5003.18,z=143.15},
                {x=-733.50,y=5197.59,z=104.48},
                {x=-665.49,y=5242.93,z=76.79},
                {x=-569.17,y=5256.91,z=70.47},
            },
            {
                {x=1860.53,y=2385.28,z=54.19},
                {x=2486.95,y=815.16,z=94.65},
                {x=2194.31,y=-765.68,z=68.91},
                {x=1762.63,y=-1396.51,z=111.45},
                {x=1719.89,y=-1731.48,z=112.49},
                {x=1708.63,y=-1661.63,z=112.47},
            },
            {
                {x=1312.30,y=2684.89,z=37.68},
                {x=207.59,y=2630.89,z=47.62},
                {x=-17.15,y=2083.15,z=156.77},
                {x=309.99,y=1033.93,z=210.64},
                {x=783.19,y=1280.57,z=360.30},
            },
            {
                {x=2936.34,y=3776.81,z=52.67},
                {x=2464.73,y=5665.03,z=45.07},
                {x=313.50,y=6580.69,z=29.32},
                {x=-747.31,y=5517.95,z=35.82},
                {x=-668.64,y=5789.26,z=17.33},
            },
            {
                {x=2123.25,y=3007.55,z=45.19},
                {x=324.35,y=2649.62,z=44.61},
                {x=285.73,y=2862.10,z=43.64},
            },
            {
                {x=2841.46,y=3476.25,z=54.96},
                {x=2817.63,y=4391.41,z=49.34},
                {x=3073.51,y=3988.65,z=73.33},
                {x=3416.44,y=3748.30,z=30.58},
                {x=3489.44,y=3685.10,z=33.88},
            },
            {
                {x=2921.07,y=3718.57,z=52.65},
                {x=2816.09,y=4396.78,z=49.25},
                {x=2805.72,y=4907.24,z=36.18},
                {x=3036.60,y=5036.28,z=26.06},
                {x=3299.06,y=5155.78,z=18.42},
            },
            {
                {x=2389.84,y=2964.42,z=49.07},
                {x=2601.79,y=2512.40,z=29.50},
                {x=2360.07,y=1181.94,z=60.26},
                {x=2427.97,y=687.55,z=132.37},
                {x=2209.41,y=132.37,z=226.91},
                {x=1789.67,y=-79.06,z=190.28},
                {x=1671.33,y=-64.13,z=173.78},
            },
            {
                {x=2140.68,y=3009.61,z=45.25},
                {x=328.21,y=2650.84,z=44.66},
                {x=-127.61,y=1923.99,z=197.31},
            },
            {
                {x=2448.89,y=2962.04,z=40.71},
                {x=2178.37,y=1262.16,z=75.97},
                {x=2552.21,y=419.51,z=108.46},
            },
            {
                {x=2353.74,y=3218.36,z=46.87},
                {x=1576.09,y=3104.95,z=40.89},
                {x=1124.75,y=2878.73,z=39.17},
                {x=1414.61,y=2312.61,z=74.69},
                {x=1263.59,y=1905.17,z=78.77},
            }
        }
    }
}
