

---

## FRAMEWORK required

* [ESX] (legacy)

* [OxLib](https://github.com/overextended/ox_lib)

* [OxInventory](https://github.com/overextended/ox_inventory)

#### For use target 

* [OxTarget](https://github.com/overextended/ox_target)



#### For use gizmo 

* [object_gizmo](https://github.com/Demigod916/object_gizmo)

---

## Language

* FR

---

## Config/Use (Create/Edit):

Add authorization (SaStash/Config.lua)
```
Config.License = {
    'license:xxxxxxxx',
    'license:xxxxxxxx',
    'license:xxxxxxxx'
}
```


Config Webhooks (SaStash/Config.lua)
```
Config.Webhooks = {
	Create_Webhook = "WEBHOOK_LINK",
	Delete_Webhook = "WEBHOOK_LINK",
	Open_Webhook = "WEBHOOK_LINK",
	LockpickOpen_Webhook = "WEBHOOK_LINK",
	Label_Webhook = "WEBHOOK_LINK",
	Password_Webhook = "WEBHOOK_LINK",
	Slot_Webhook = "WEBHOOK_LINK",
	Weight_Webhook = "WEBHOOK_LINK",
	Props_Webhook = "WEBHOOK_LINK",
	Coords_Webhook = "WEBHOOK_LINK",
	Coords_props_Webhook = "WEBHOOK_LINK",

	Username = "Logs SaStash",
	Avatar = "AVATAR_LINK",
	Kick_player_Webhook = "WEBHOOK_LINK", -- Logs for bypass trigger 
}
```



Add item for crack locker (SaStash/Config.lua)
```
Config.LockpickItems = "stethoscope"
```



Add prop on custom list (SaStash/Config.lua)
```
Config.Props = {
	{value = "prop_ld_int_safe_01", label = "Petit coffre avec dorure en or", Gizmo_ajust = "+", Gizmo_axe_x =  0.50,}, 
	{value = "h4_prop_h4_safe_01a", label = "Grand coffre avec dorure en or", Gizmo_ajust = "+", Gizmo_axe_x =  0.99,}, 
	{value = "sf_prop_v_43_safe_s_gd_01a", label = "Grand coffre doré", Gizmo_ajust = "+", Gizmo_axe_x =  0.20,}, 
	{value = "sf_prop_v_43_safe_s_bk_01a", label = "Grand coffre noir", Gizmo_ajust = "+", Gizmo_axe_x =  0.20,},
	{value = "p_v_43_safe_s", label = "Grand Coffre classique", Gizmo_ajust = "+", Gizmo_axe_x =  0.20,}, 
	{value = "xm3_prop_xm3_safe_01a", label = "Grand coffre gris", Gizmo_ajust = "+", Gizmo_axe_x =  0.99,},
	{value = "h4_prop_h4_chest_01a", label = "Petite malle", Gizmo_ajust = "+", Gizmo_axe_x =  0.99,},
	{value = nil, label = "Aucun", Gizmo_ajust = "+", Gizmo_axe_x =  0.0,}  
}
```

Command for open menu

```

Command: SaStash


```


## Links

* [Preview V1.0](https://youtu.be/fem26Jopmwg)
* [Preview V2.0 Coming Soon](https://youtu.be/)
* [Discord](https://discord.gg/FAZBexrgtx)



## Author

###### By ImSama

