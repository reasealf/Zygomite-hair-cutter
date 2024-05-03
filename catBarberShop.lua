--[[
    Script: Barber shop
    Description: Start a barber shop today by starting at scruffy zygomites location !

    Author: Cat.
    Version: 1.0
    Release Date: 2024-26-04

    Release Notes:
    - Version 1.0 : First Release and probably the last one too btw
]]


local API                   = require('api')
local afk                   = os.time()
local MAX_IDLE_TIME_MINUTES = 15

API.SetDrawTrackedSkills(true)

local function idleCheck()
    local timeDiff = os.difftime(os.time(), afk)
    local randomTime = math.random((MAX_IDLE_TIME_MINUTES * 60) * 0.6, (MAX_IDLE_TIME_MINUTES * 60) * 0.9)

    if timeDiff > randomTime then
        API.PIdle2()
        afk = os.time()
    end
end

local function openInv()
    if (not API.OpenInventoryInterface2()) then
        --API.KeyboardPress32(0x4D, 0)
        API.DoAction_Interface(0x31, 0xffffffff, 1, 1431, 0, 9, API.OFF_ACT_GeneralInterface_route); --make sure this tab is open
        API.RandomSleep2(200, 200, 200)
    end
end


local function isAnimating(tick)
    local test1 = API.CheckAnim(3)
    API.Count_ticks(tick)
    local test2 = API.CheckAnim(3)
    API.Count_ticks(tick)
    return (test1 == test2)
end

local function openBarberShop()

    if isAnimating(1) then
        API.DoAction_NPC_str(0xCD, API.OFF_ACT_InteractNPC_route, { 'Scruffy zygomite' }, 2)       
    end

end

while API.Read_LoopyLoop() do
    API.DoRandomEvents()
    idleCheck()
    openInv()

    if API.ReadPlayerMovin2() or API.CheckAnim(40) then
        goto continue
    end

    openBarberShop()
    ::continue::
    API.RandomSleep2(600,200,400)
end
