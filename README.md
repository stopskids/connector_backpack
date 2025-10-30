# connector_backpack

This resource was created as a better backpack for servers as people could have more then 1 backpack with wasabi_backpacks.

<b>Features:</b>
- 0.0 ms Usage
- Backpack Prop from wasabi_backpack remains
- Combatible for all frameworks using ox_inventory

## Installation

- Download this script
- Add backpack to inventory `ox_inventory/data/items.lua` - [item code found in `connector_backpack/inventory/item.lua`]
- Add backpack image to inventory `ox_inventory/web/images` - [image found in `connector_backpack/inventory/backpack.png`]
- Put script in a folder somewhere in your `resources` directory
- ensure `connector_backpack` *after* `ox_lib` but *before* `ox_inventory`

# Dependencies
 - ox_inventory

## Backpack Item
Item to add to `ox_inventory/data/items.lua`
```
    ['backpack'] = {
        label = 'Backpack',
        weight = 220,
        stack = false,
        consume = 0,
        client = {
            export = 'connector_backpack.openBackpack'
        }
    },
```


# Support
<a href='https://discord.gg/mysterium'>![Discord Banner 2](https://discordapp.com/api/guilds/1423613579017326704/widget.png?style=banner2)</a>

