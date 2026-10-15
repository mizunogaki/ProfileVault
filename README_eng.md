# WoW Forever Settings Mod — ProfileVault

A World of Warcraft addon for saving graphics settings and keybinds in WoW Forever. Create separate profiles that store your settings, including advanced graphics options such as vegetation density and terrain object draw distance.

**English** | [Русский](README.md)

## Installation

1. Download and extract [ProfileVault.zip](https://github.com/mizunogaki/ProfileVault/releases)
2. Copy the `ProfileVault` folder into your `Interface/AddOns` directory
3. After configuring your graphics and keybinds, save a profile using `/pv save [name]`, then make sure to reload the UI with `/reload` so the profile is written to disk.

## Useful Commands

`/pv save [name]` — saves a profile to the addon's memory.  
Reload the UI with `/reload` to write the profile to the addon's saved files.

`/pv load [name]` — loads a previously saved profile.

You can manage profiles here: **Settings → AddOns → ProfileVault**

For a guide on console commands for advanced graphics settings, see [COMMANDS.md](COMMANDS.md).

## How to Transfer Profiles from Beta to Live WoW Forever

Saved profiles are stored in the addon's SavedVariables file.

Example path: `Warcraft_classic_beta_\WTF\Account\1403721991#1\SavedVariables\ProfileVault.lua`

Profiles are created per account — they are not tied to a specific character.

**Important:** The file is not overwritten at the moment of `/pv save`, but on logout, `/reload` (UI reload), or relogging. Until then, the new profile only exists in memory. For `/pv load` to work correctly, always do a `/reload` or relog after saving a profile.

`.bak` is the previous version of the file (an automatic client backup made on overwrite).

To transfer profiles to another client or account, simply copy `ProfileVault.lua` into the same `SavedVariables` folder of the target client.
