
local Interval = 50
local BPEvents_Actor

function split(str, sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    str:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
 end

AddEvent("OnPackageStart", function()
    local loaded = LoadPak("LuaEvents", "/LuaEvents/", "../../../OnsetModding/Plugins/LuaEvents/Content")
    if not loaded then
        print("[BPEvents] : pak loading failed")
    else
        print("[BPEvents] : pak loaded")
        BPEvents_Actor = GetWorld():SpawnActor(UClass.LoadFromAsset("/LuaEvents/LuaEvents_Actor"), FVector(0, 0, 0), FRotator(0, 0, 0))
    end
    if BPEvents_Actor then
        CreateTimer(function()
            local pending_events = BPEvents_Actor:ProcessEvent("GetPendingEvents")
            if pending_events ~= "" then
                --AddPlayerChat(pending_events)
                for i, v in ipairs(split(pending_events, ";")) do
                    local splited_v = split(v, ":")
                    CallEvent(splited_v[1], splited_v[2])
                end
            end
        end,Interval)
    end
end)

