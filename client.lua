currentWeapon = `WEAPON_UNARMED`
syncedRopes = {} -- playerServerId = ropeid
hasLanyard = false

Citizen.CreateThread(function()
    while true do
        playerPed = PlayerPedId()
        playerWeapon = GetSelectedPedWeapon(playerPed)
        
        if currentWeapon ~= playerWeapon then
            if playerWeapon == `WEAPON_UNARMED` and hasLanyard then
                TriggerServerEvent("obWeaponLanyard:removelanyard")
                hasLanyard = false
            else
                if isWeaponAllowed(playerWeapon) and not hasLanyard then
                    TriggerServerEvent("obWeaponLanyard:createlanyard")
                    hasLanyard = true
                end
            end

            currentWeapon = playerWeapon
        end

        Citizen.Wait(100)
    end
end)

function isWeaponAllowed(weapon)
    for _, configWeapon in ipairs(Config.AcceptedWeapons) do
        if weapon == configWeapon then
            return true
        end
    end

    return false
end

RegisterNetEvent("obWeaponLanyard:createlanyard")
AddEventHandler("obWeaponLanyard:createlanyard", function(playerServerId)
    RopeLoadTextures()
    Citizen.Wait(250)

    player = GetPlayerPed(GetPlayerFromServerId(playerServerId))
    playerWeapon = GetCurrentPedWeaponEntityIndex(player)    
    playerCoords = GetEntityCoords(player)
    playerBone = GetEntityBoneIndexByName(player, 'SKEL_Pelvis')
    playerBoneCoords = GetPedBoneCoords(player, playerBone, vector3(0, 0, 0))
    playerBoneCoords = playerBoneCoords - playerCoords

    rope = AddRope(playerCoords, 0.0, 0.0, 0.0, 0.1, 5, 4.0, 0.001, 1.0, true, false, true, 1.0, false)
    AttachEntitiesToRope(rope, player, playerWeapon, playerBoneCoords, vector3(0,0,0), 3.0, 0, 0, 'SKEL_Pelvis', 'gun_gripr')

    syncedRopes[playerServerId] = rope
end)

RegisterNetEvent("obWeaponLanyard:removelanyard")
AddEventHandler("obWeaponLanyard:removelanyard", function(playerServerId)
    if syncedRopes[playerServerId] then
        DeleteRope(rope)
        syncedRopes[playerServerId] = nil
    end
end)