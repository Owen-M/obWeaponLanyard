syncedRopes = {}

RegisterNetEvent("obWeaponLanyard:createlanyard")
AddEventHandler("obWeaponLanyard:createlanyard", function()
    TriggerClientEvent("obWeaponLanyard:createlanyard", -1, source)
end)

RegisterNetEvent("obWeaponLanyard:removelanyard")
AddEventHandler("obWeaponLanyard:removelanyard", function()
    TriggerClientEvent("obWeaponLanyard:removelanyard", -1, source)
end)