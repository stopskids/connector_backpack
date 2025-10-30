local registeredStashes = {}
local ox_inventory = exports.ox_inventory


local function GenerateText(num) -- Thnx Linden
	local str
	repeat str = {}
		for i = 1, num do str[i] = string.char(math.random(65, 90)) end
		str = table.concat(str)
	until str ~= 'POL' and str ~= 'EMS'
	return str
end

local function GenerateSerial(text) -- Thnx Again
	if text and text:len() > 3 then
		return text
	end
	return ('%s%s%s'):format(math.random(100000,999999), text == nil and GenerateText(3) or text, math.random(100000,999999))
end

RegisterServerEvent('connector_backpack:openBackpack')
AddEventHandler('connector_backpack:openBackpack', function(identifier)
	if not registeredStashes[identifier] then
        ox_inventory:RegisterStash('bag_'..identifier, 'Backpack', Config.BackpackStorage.slots, Config.BackpackStorage.weight, false)
        registeredStashes[identifier] = true
    end
end)

lib.callback.register('connector_backpack:getNewIdentifier', function(source, slot)
	local newId = GenerateSerial()
	ox_inventory:SetMetadata(source, slot, {identifier = newId})
	ox_inventory:RegisterStash('bag_'..newId, 'Backpack', Config.BackpackStorage.slots, Config.BackpackStorage.weight, false)
	registeredStashes[newId] = true
	return newId
end)

CreateThread(function()
	while GetResourceState('ox_inventory') ~= 'started' do Wait(500) end
	local swapHook = ox_inventory:registerHook('swapItems', function(payload)
		local start, destination, move_type = payload.fromInventory, payload.toInventory, payload.toType
		local count_bagpacks = ox_inventory:GetItem(payload.source, 'backpack', nil, true)
	
		if string.find(destination, 'bag_') then
			TriggerClientEvent('ox_lib:notify', payload.source, {type = 'error', title = 'Action Incomplete', description = "You can't place a backpack within another!"}) 
			return false
		end
		if Config.OneBagInInventory then
			if (count_bagpacks > 0 and move_type == 'player' and destination ~= start) then
				TriggerClientEvent('ox_lib:notify', payload.source, {type = 'error', title = 'Action Incomplete', description = 'You can only have 1x backpack!'}) 
				return false
			end
		end
		
		return true
	end, {
		print = false,
		itemFilter = {
			backpack = true,
		},
	})
	
	local createHook
	if Config.OneBagInInventory then
		createHook = exports.ox_inventory:registerHook('createItem', function(payload)
			local count_bagpacks = ox_inventory:GetItem(payload.inventoryId, 'backpack', nil, true)
			if count_bagpacks and count_bagpacks > 0 then
				TriggerClientEvent('ox_lib:notify', payload.inventoryId, {type = 'error', title = 'Action Incomplete', description = 'You can only have 1x backpack!'})
				return false
			end
			return true
		end, {
			print = false,
			itemFilter = {
				backpack = true
			}
		})
	end
	
	AddEventHandler('onResourceStop', function()
		ox_inventory:removeHooks(swapHook)
		if Config.OneBagInInventory then
			ox_inventory:removeHooks(createHook)
		end
	end)
end)
