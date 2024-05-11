
Config = {}

Config.RangeDrawMarker = 6.0 -- number or false

Config.RangeActive = 1.5

Config.OxTarget = false

Config.Preview_OxTarget_CreateVault = true

Config.Debug_OxTarget = true

Config.Debug_Print = 'true' --true, false or traceback

Config.LockpickItems = "stethoscope"

Config.Props = {
	{value = "prop_ld_int_safe_01", label = "Petit coffre avec dorure en or"}, 
	{value = "h4_prop_h4_safe_01a", label = "Grand coffre avec dorure en or"}, 
	{value = "sf_prop_v_43_safe_s_gd_01a", label = "Grand coffre doré"}, 
	{value = "sf_prop_v_43_safe_s_bk_01a", label = "Grand coffre noir"},
	{value = "p_v_43_safe_s", label = "Grand Coffre classique"}, 
	{value = "xm3_prop_xm3_safe_01a", label = "Grand coffre gris"},
	{value = "h4_prop_h4_chest_01a", label = "Petite malle"},
	{value = nil, label = "Aucun"}  
}

Config.Lang = {


	--FR

	-- --[[


	--Client

	Help_notif = "~INPUT_PICKUP~ pour ouvrir le coffre.",

	HackLabel = '~INPUT_SCRIPT_PAD_LEFT~/~INPUT_VEH_MOVE_RIGHT_ONLY~ Pour tourner le Cadran Codé\n~INPUT_JUMP~ pour validé la combinaison',

	Menu_name = "Menu Gestion",
	Stash = "Coffre",

	filter = "Filtre",

	filter_alpha = "Filtre Alphabetique",
	filter_num = "Filtre Numerique",

	filterArray1 = "~HC_45~Se téléporter~s~",
	filterArray2 = "~HC_45~Modifier le label~s~",
	filterArray3 = "~HC_45~Modifier le mot de passe~s~",
	filterArray4 = "~HC_45~Ouvrir~s~",
	filterArray5 = "~r~Supprimer le casier~s~",

	filterArray_main1 = "~HC_45~Ouvrir~s~",
	filterArray_main2 = "~HC_45~Modifier le mot de passe~s~",
	filterArray_main3 = "~HC_45~Modifier le label~s~",
	filterArray_crack_open = "~r~Forer le coffre~s~",

	New_Mdp_imput = "Nouveaux mot de passe du coffre",
	New_label_imput = "Nouveaux Nom du coffre",
	MDP = 'Mot de passe',

	Create_Menu = "🔨  Crée un coffre",
	Gestion_Menu = "⚙️  Géstion des coffre",

	Name_stash = "🏷️  Nom du coffre",
	Name_stash_imput = "Nom du Coffre",

	Add_point = "🔨  Ajouter un coffre",
	Add_point_desc = "",

	Name_point_imput = "Nom du point",
	Name_Label_imput = "Label du coffre",
	Name_Mdp_imput = "Mot de passe du coffre",

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


	--Server

	Create_vault = "Vous avez créé un coffre:",
	Create_locker = "Vous créé le casier:",

	Delet_vault = "Vous avez supprimé un le coffre:",
	Delet_locker = "Vous avez supprimé un le casier:",

	Edit_locker_name = "Vous créé le casier:",
	Edit_locker_mdp = "Vous avez modifié le (MDP) du coffre !",
	Edit_locker_props = "Vous avez modifié le (Prop) du coffre !",
	Edit_locker_menu = "Vous avez modifié la (Position) du menu !",
	Edit_locker_prop = "Vous avez modifié la (Position) du coffre !",


	--]]
}