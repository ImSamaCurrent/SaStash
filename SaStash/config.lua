
Config = {}

Config.Settings = {



	RangeDrawMarker = 6.0, -- number or false

	RangeActive = 1.5,

	UseGizmo = true,

	OxTarget = true,

	Debug_OxTarget = false,

	Debug_Print = 'true', --true, false or traceback

	SendWebhooksPlayerlockpick = true,

	WaitSend_SendWebhooksPlayerlockpick = 1*60*1000, -- in millisecond

	LockpickItems = "stethoscope",

	RemoveLockpickItemsFail = false, -- false or number to remove

	LockpickNumber = 6,


	RegisterCommand = 'SaStash',

	Refresh_Interval = 5, --in minute

	License = {
	    'license:xxxxxxxx',
    	'license:xxxxxxxx',
    	'license:xxxxxxxx'
	},

}

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
	Avatar = "https://cdn.discordapp.com/attachments/1190090809484251258/1197939245332045875/team_jsaipa2.png?ex=66458a1c&is=6644389c&hm=aaedd1e64781b016c037169f93d00f72ced9c01e48c19f03e36d6123dab5ffa9&",
	Kick_player_Webhook = "WEBHOOK_LINK", -- Logs for bypass trigger 
}

Config.Props = { -- Use "Gizmo_axe_x" to adjust prop height (for gizmo)
	{value = "prop_ld_int_safe_01", label = "Petit coffre avec dorure en or", Gizmo_ajust = "+", Gizmo_axe_x =  0.50,}, 
	{value = "h4_prop_h4_safe_01a", label = "Grand coffre avec dorure en or", Gizmo_ajust = "+", Gizmo_axe_x =  0.99,}, 
	{value = "sf_prop_v_43_safe_s_gd_01a", label = "Grand coffre doré", Gizmo_ajust = "+", Gizmo_axe_x =  0.20,}, 
	{value = "sf_prop_v_43_safe_s_bk_01a", label = "Grand coffre noir", Gizmo_ajust = "+", Gizmo_axe_x =  0.20,},
	{value = "p_v_43_safe_s", label = "Grand Coffre classique", Gizmo_ajust = "+", Gizmo_axe_x =  0.20,}, 
	{value = "xm3_prop_xm3_safe_01a", label = "Grand coffre gris", Gizmo_ajust = "+", Gizmo_axe_x =  0.99,},
	{value = "h4_prop_h4_chest_01a", label = "Petite malle", Gizmo_ajust = "+", Gizmo_axe_x =  0.99,}, 
	{value = nil, label = "Aucun", Gizmo_ajust = "+", Gizmo_axe_x =  0.0,}  
}

Config.Lang = {


	--FR

	-- --[[



	Help_notif = "~INPUT_PICKUP~ pour ouvrir le coffre.",

	HackLabel = '~INPUT_SCRIPT_PAD_LEFT~/~INPUT_VEH_MOVE_RIGHT_ONLY~ Pour tourner le Cadran Codé\n~INPUT_JUMP~ pour validé la combinaison',

	Menu_name = "Menu Gestion",
	Stash = "Coffre",

	filter = "Filtre",

	filter_alpha = "Filtre Alphabetique",
	filter_num = "Filtre Numerique",

	filterArray1 = "~HC_45~Ouvrir~s~",
	filterArray2 = "~HC_45~Se téléporter~s~",
	filterArray3 = "~HC_45~Modifier le label~s~",
	filterArray4 = "~HC_45~Modifier le mot de passe~s~",
	filterArray5 = "~HC_45~Modifier le nombre de slot~s~",
	filterArray6 = "~HC_45~Modifier le poids~s~",
	filterArray7 = "~r~Supprimer le casier~s~",

	filterArray_main1 = "~HC_45~Ouvrir~s~",
	filterArray_main2 = "~HC_45~Modifier le mot de passe~s~",
	filterArray_main3 = "~HC_45~Modifier le label~s~",
	filterArray_crack_open = "~r~Forcer le coffre~s~",

	New_Mdp_imput = "Nouveaux mot de passe du casier",
	New_label_imput = "Nouveaux Nom du casier",
	MDP = 'Mot de passe',

	slot = 'Nombre de slot',
	weight = 'Poids',

	AddWebhooks = 'Ajouter un webhook au coffre',
	AddWebhooks_desc = 'Ajouter un webhook au coffre pour les joueurs',

	Create_Menu = "🔨  Crée un coffre",
	Gestion_Menu = "⚙️  Géstion des coffre",

	Name_stash = "🏷️  Nom du coffre",
	Name_stash_imput = "Nom du Coffre",

	Add_point = "🔨  Ajouter un coffre",
	Add_point_desc = "",

	Name_point_imput = "Nom du point",
	Name_Label_imput = "Label du coffre",
	Name_Mdp_imput = "Mot de passe du casier",
	Name_slot_imput = "Slot max du casier",
	Name_weight_imput = "poids max du casier (1Kg = 1000)",

	Nil_point = "📌  Aucun coffre défini",
	Loading = "🔁  Chargement en cours (~r~Aucun coffre enregistrer~s~)",

	Save = "💾  Enregistrer",
	Delete = "🗑️  Supprimer le Coffre",
	Del_valide = "Pour accepter la suppresion",
	Delete_point = "~r~Supprimer le point~s~",
	

	Pos_menu_label = "Position du menu",
	Pos_props_label = "Position du props",
	Props_type = "Props",

	PreviewOxTarget = "Preview OxTarget",

	Draw_Coffre = "Coffre: ",
	Draw_Total = "Nombre de casier: ",
	Draw_ID = "ID du coffre: ",


	Yes = "Oui",
	No = "Non",


	Create_vault = "Vous avez créé un coffre:",
	Create_locker = "Vous créé le casier:",

	Delet_vault = "Vous avez supprimé un le coffre:",
	Delet_locker = "Vous avez supprimé un le casier:",

	Edit_locker_name = "Vous créé le casier:",
	Edit_locker_mdp = "Vous avez modifié le (MDP) du coffre !",
	Edit_locker_props = "Vous avez modifié le (Prop) du coffre !",
	Edit_locker_menu = "Vous avez modifié la (Position) du menu !",
	Edit_locker_prop = "Vous avez modifié la (Position) du coffre !",


	Webhooks_CreateCoffre_title = "Creation de **coffre**",
	Webhooks_CreateCoffre = "__%s__ a crée le coffre: **%s** \nPosition: **%s**",

	Webhooks_CreateStash_title = "Creation de **casier**",
	Webhooks_CreateStash = "__%s__ a crée le casier: **%s** \nCoffre du casier: **%s**",

	Webhooks_Open_title = "Ouverture de **casier**",
	Webhooks_Open = "__%s__ a ouvert le casier: **%s**",
	Webhooks_Open2 = "__%s__ a ouvert le casier: **%s** \nCoffre: **%s**",

	Webhooks_UpdateStash_title = "Modification de **label**",
	Webhooks_UpdateStash = "__%s__ a modifié le nom du casier: **%s**",
	Webhooks_UpdateStash2 = "__%s__ a modifié le nom du casier: **%s** \nCoffre du casier: **%s**",

	Webhooks_UpdatePassword_title = "Modification de **mot de pass**",
	Webhooks_UpdatePassword = "__%s__ a modifié le mot de pass du casier: **%s**",
	Webhooks_UpdatePassword2 = "__%s__ a modifié le mot de pass du casier: **%s** \nCoffre du casier: **%s**" ,

	Webhooks_UpdateSlot_title = "Modification de **slot**",
	Webhooks_UpdateSlot = "__%s__ a modifié les slot (max) du casier: **%s** \nCoffre du casier: **%s**" ,

	Webhooks_UpdateWeight_title = "Modification de **poids**",
	Webhooks_UpdateWeight = "__%s__ a modifié le poids (max) du casier: **%s** \nCoffre du casier: **%s**",

	Webhooks_UpdateProps_title = "Modification de **prop**",
	Webhooks_UpdateProps = "__%s__ a modifié le props du coffre: **%s**",

	Webhooks_UpdateCoords_title = "Modification de **coordonnées du menu / target**",
	Webhooks_UpdateCoords = "__%s__ a changer la position du menu du coffre: **%s** \nNouvelle position: **%s**",

	Webhooks_UpdatePropsCoords_title = "Modification de **coordonnées du prop**",
	Webhooks_UpdatePropsCoords = "__%s__ a changer la position du props du coffre: **%s** \nNouvelle position: **%s**",

	Webhooks_UpdateWebhooks_title = "Modification de **Webhooks**",
	Webhooks_UpdateWebhooks = "__%s__ a changer le webhook du coffre: **%s**",

	Webhooks_DeleteVault_title = "Suppression de **coffre**",
	Webhooks_DeleteVault = "__%s__ a supprimer le coffre: **%s**",

	Webhooks_DeleteStash_title = "Suppression de **casier**",
	Webhooks_DeleteStash = "__%s__ a supprimer le casier: **%s** \nCoffre: **%s**",

	Webhooks_ForceStash_title = "Lockpicking de **casier**",
	Webhooks_ForceStash = "__%s__ a Forer le casier: **%s** Coffre: **%s**" ,
	Webhooks_ForceStash2 = "Une personne a Forer le casier: **%s**",


	--]]
}