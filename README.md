# connector_backpack

This resource was created as a updated backpack script from wasabi_backpack.

## Installation

- Download this script
- Add backpack to inventory `ox_inventory/data/items.lua`
- Add backpack image to inventory `ox_inventory/web/images`
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


