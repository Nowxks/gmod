include("sh_conf.lua")

local function convertulx(str)
    local lines = ULib.explode("\r?\n", str)
    local parent_tables = {} -- Traces our way to root
    local current_table = {}
    local is_insert_last_op = false

    for i, line in ipairs(lines) do
        local tmp_string = string.char(01, 02, 03) -- Replacement
        local tokens = ULib.splitArgs((line:gsub("\\\"", tmp_string)))

        for i, token in ipairs(tokens) do
            tokens[i] = ULib.unescapeBackslash(token):gsub(tmp_string, "\"")
        end

        local num_tokens = #tokens

        if num_tokens == 1 then
            local token = tokens[1]

            if token == "{" then
                local new_table = {}

                if is_insert_last_op then
                    current_table[table.remove(current_table)] = new_table
                else
                    table.insert(current_table, new_table)
                end

                is_insert_last_op = false
                table.insert(parent_tables, current_table)
                current_table = new_table
            elseif token == "}" then
                is_insert_last_op = false
                current_table = table.remove(parent_tables)
                if current_table == nil then return nil, "Mismatched recursive tables on line " .. i end
            else
                is_insert_last_op = true
                table.insert(current_table, tokens[1])
            end
        elseif num_tokens == 2 then
            is_insert_last_op = false

            if convert and tonumber(tokens[1]) then
                tokens[1] = tonumber(tokens[1])
            end

            current_table[tokens[1]] = tokens[2]
        elseif num_tokens > 2 then
            return nil, "Bad input on line " .. i
        end
    end

    if #parent_tables ~= 0 then return nil, "Mismatched recursive tables" end

    -- If we caught a stupid garry-wrapper
    if table.Count(current_table) == 1 and type(current_table.Out) == "table" then
        current_table = current_table.Out
    end

    return current_table
end

if slots_reserves.typekick == 1 then
    local function SlotsFunction(ply)
        if not slots_reserves.bypassgroups[ply:GetUserGroup()] then
            if #player.GetAll() >= slots_reserves.maxnorm then
                ply:Kick(slots_reserves.reason)
            end
        end
    end

    hook.Add("PlayerInitialSpawn", "slots_reserves_par_lp", SlotsFunction)
elseif slots_reserves.typekick == 2 then
    gameevent.Listen("player_connect")

    hook.Add("player_connect", "slots_reserves_par_lp:CHECKRANK", function(data)
        if #player.GetAll() >= slots_reserves.maxnorm then
            local sid = data.networkid
            local tble = file.Read("ulib/users.txt", "DATA")
            local tbl = convertulx(tble)

            if not slots_reserves.bypassgroups[tbl[sid]["group"]] then
                ply:Kick(slots_reserves.reason)
            end
        end
    end)
end

if slots_reserves.msgConsoles then
    print("\nLe script des Slots Réservés par Pilot2 est chargé.\n")
end
