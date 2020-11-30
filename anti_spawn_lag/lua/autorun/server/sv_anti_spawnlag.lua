-- Addon made by Wasied#9999 for your best gmod servers
WASL.ModelsCache = WASL.ModelsCache or {}

--[[ Get a list of all vehicles model of the server ]]--
function WASL:GetVehiclesModelsList()

    local vehicles = list.Get("Vehicles")
    if not istable(vehicles) then return end
    if table.Count(vehicles) <= 0 then return end

    local onlyModels = {}
    for _, v in pairs(vehicles) do
        if not istable(v) then continue end
        if not isstring(v["Model"]) then continue end

        table.insert(onlyModels, v["Model"])
    end

    return onlyModels
end


--[[ Check if a vehicle model is whitelisted ]]--
function WASL:CheckWhitelisted(model)
    if not isstring(model) then return end

    for _, v in pairs(WASL.WhitelistedModels) do
        if not isstring(v) then continue end
        if string.match(string.lower(model), string.lower(v)) then
            WASL.ModelsCache[model] = true
            return true 
        end
    end
end


--[[ Initialize precaching script ]]--
function WASL:InitializeCache()

    local vehiclesModels = WASL:GetVehiclesModelsList()
    if not istable(vehiclesModels) then return print("[Wasied - AntiSpawnLag] Can't find any vehicle model !") end

    local nextCooldown = 0
    for _, v in ipairs(vehiclesModels) do
        if WASL.ModelsCache[v] then continue end
        if not WASL:CheckWhitelisted(v) then continue end

        timer.Simple(nextCooldown, function()
            util.PrecacheModel(v)
            print("[Wasied - AntiSpawnLag] Precaching vehicle model : '"..v.."' (time: "..os.time()..")") 
        end)

        nextCooldown = nextCooldown + WASL.Cooldown
    end

    print("[Wasied - AntiSpawnLag] Thanks for using this script ! All vehicles will soon be cached.")
end
hook.Add("InitPostEntity", "Beggin:DropToFloor", WASL.InitializeCache)


--[[ Get vehicle model ]]--
concommand.Add("vehmodel", function(ply)
    if not IsValid(ply) or not ply:Alive() then return end
    if not ply:IsAdmin() then return ply:PrintMessage(HUD_PRINTCONSOLE, "Vous n'êtes pas administrateur !") end

    local vehicle = ply:GetEyeTrace().Entity
    if not IsValid(vehicle) then return ply:PrintMessage(HUD_PRINTCONSOLE, "L'entité visée n'est pas valide.") end
    if not vehicle:IsVehicle() then return ply:PrintMessage(HUD_PRINTCONSOLE, "Vous ne visez pas un véhicule.") end

    local vehicleModel = vehicle:GetModel()
    if not isstring(vehicleModel) then return end
    if WASL:CheckWhitelisted(vehicleModel) then ply:PrintMessage(HUD_PRINTCONSOLE, "Attention ! Ce modèle est déjà ajouté à votre table, il n'est pas nécessaire de le faire.") end

    ply:PrintMessage(HUD_PRINTCONSOLE, "MODÈLE DU VÉHICULE À COPIER : "..vehicleModel)
end)