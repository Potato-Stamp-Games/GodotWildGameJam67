extends Node

const ICON_PATH = "res://Assets/UpgradeTextures/"
const WEAPON_PATH = "res://Assets/WeaponUpgradeTextures/"
const UPGRADES = {
	"nailgun1": {
		"icon": WEAPON_PATH + "NailgunUpgrade.png",
		"displayname": "Nail Gun",
		"details": "Fires a Nail towards a random enemy",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"nailgun2": {
		"icon": WEAPON_PATH + "NailgunUpgrade.png",
		"displayname": "Nail Gun",
		"details": "Fires a Nail towards a random enemy",
		"level": "Level: 2",
		"prerequisite": ["nailgun1"],
		"type": "weapon"
	},
	"nailgun3": {
		"icon": WEAPON_PATH + "NailgunUpgrade.png",
		"displayname": "Nail Gun",
		"details": "Fires a Nail towards a random enemy",
		"level": "Level: 3",
		"prerequisite": ["nailgun2"],
		"type": "weapon"
	},
	"nailgun4": {
		"icon": WEAPON_PATH + "NailgunUpgrade.png",
		"displayname": "Nail Gun",
		"details": "Fires a Nail towards a random enemy",
		"level": "Level: 4",
		"prerequisite": ["nailgun3"],
		"type": "weapon"
	},
	"sixpack1": {
		"icon": WEAPON_PATH + "SixPackUpgrade.png",
		"displayname": "Six Pack",
		"details": "Chuck a beer in the direction you are facing",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"sixpack2": {
		"icon": WEAPON_PATH + "SixPackUpgrade.png",
		"displayname": "Six Pack",
		"details": "Chuck a beer in the direction you are facing",
		"level": "Level: 2",
		"prerequisite": ["sixpack1"],
		"type": "weapon"
	},
	"sixpack3": {
		"icon": WEAPON_PATH + "SixPackUpgrade.png",
		"displayname": "Six Pack",
		"details": "Chuck a beer in the direction you are facing",
		"level": "Level: 3",
		"prerequisite": ["sixpack2"],
		"type": "weapon"
	},
	"sixpack4": {
		"icon": WEAPON_PATH + "SixPackUpgrade.png",
		"displayname": "Six Pack",
		"details": "Chuck a beer in the direction you are facing",
		"level": "Level: 4",
		"prerequisite": ["sixpack3"],
		"type": "weapon"
	},
	"measuringtape1": {
		"icon": WEAPON_PATH + "TapeMeasureUpgrade.png",
		"displayname": "Measuring Tape",
		"details": "Line of Measuring Tape will follow you attacking enemys in a straight line",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"measuringtape2": {
		"icon": WEAPON_PATH + "TapeMeasureUpgrade.png",
		"displayname": "Measuring Tape",
		"details": "Line of Measuring Tape will follow you attacking enemys in a straight line",
		"level": "Level: 2",
		"prerequisite": ["measuringtape1"],
		"type": "weapon"
	},
	"measuringtape3": {
		"icon": WEAPON_PATH + "TapeMeasureUpgrade.png",
		"displayname": "Measuring Tape",
		"details": "Line of Measuring Tape will follow you attacking enemys in a straight line",
		"level": "Level: 3",
		"prerequisite": ["measuringtape2"],
		"type": "weapon"
	},
	"measuringtape4": {
		"icon": WEAPON_PATH + "TapeMeasureUpgrade.png",
		"displayname": "Measuring Tape",
		"details": "Line of Measuring Tape will follow you attacking enemys in a straight line",
		"level": "Level: 4",
		"prerequisite": ["measuringtape3"],
		"type": "weapon"
	},
	"antibody1": {
		"icon": ICON_PATH + "ArmorUpgrade.png",
		"displayname": "Antibody Serum",
		"details": "Reduces Damage By 1 Point",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"antibody2": {
		"icon": ICON_PATH + "ArmorUpgrade.png",
		"displayname": "Antibody Serum",
		"details": "Reduces Damage By an additional 1 Point",
		"level": "Level: 2",
		"prerequisite": ["antibody1"],
		"type": "upgrade"
	},
	"antibody3": {
		"icon": ICON_PATH + "ArmorUpgrade.png",
		"displayname": "Antibody Serum",
		"details": "Reduces Damage By an additional 1 Point",
		"level": "Level: 3",
		"prerequisite": ["antibody2"],
		"type": "upgrade"
	},
	"antibody4": {
		"icon": ICON_PATH + "ArmorUpgrade.png",
		"displayname": "Antibody Serum",
		"details": "Reduces Damage By an additional 1 Point",
		"level": "Level: 4",
		"prerequisite": ["antibody3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": ICON_PATH + "MoveSpeedUpgrade.png",
		"displayname": "Speed Boots",
		"details": "Movement Speed Increased By 50% of base speed",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "MoveSpeedUpgrade.png",
		"displayname": "Speed Boots",
		"details": "Movement Speed Increased By an additional 50% of base speed",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "MoveSpeedUpgrade.png",
		"displayname": "Speed Boots",
		"details": "Movement Speed Increased By an additional 50% of base speed",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "MoveSpeedUpgrade.png",
		"displayname": "Speed Boots",
		"details": "Movement Speed Increased By an additional 50% of base speed",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"damage1": {
		"icon": ICON_PATH + "DamageUpgrade.png",
		"displayname": "Damage Upgrade",
		"details": "Increases the damage of all weapons by 10%",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"damage2": {
		"icon": ICON_PATH + "DamageUpgrade.png",
		"displayname": "Damage Upgrade",
		"details": "Increases the damage of all weapons by an additional 10%",
		"level": "Level: 2",
		"prerequisite": ["damage1"],
		"type": "upgrade"
	},
	"damage3": {
		"icon": ICON_PATH + "DamageUpgrade.png",
		"displayname": "Damage Upgrade",
		"details": "Increases the damage of all weapons by an additional 10%",
		"level": "Level: 3",
		"prerequisite": ["damage2"],
		"type": "upgrade"
	},
	"damage4": {
		"icon": ICON_PATH + "DamageUpgrade.png",
		"displayname": "Damage Upgrade",
		"details": "Increases the damage of all weapons by an additional 10%",
		"level": "Level: 4",
		"prerequisite": ["damage3"],
		"type": "upgrade"
	},
	"attackspeed1": {
		"icon": ICON_PATH + "AtkSpeedUpgrade.png",
		"displayname": "Attack Speed",
		"details": "Increases the attack speed of all weapons by 10%",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"attackspeed2": {
		"icon": ICON_PATH + "AtkSpeedUpgrade.png",
		"displayname": "Attack Speed",
		"details": "Increases the attack speed of all weapons by an additional 10%",
		"level": "Level: 2",
		"prerequisite": ["attackspeed1"],
		"type": "upgrade"
	},
	"attackspeed3": {
		"icon": ICON_PATH + "AtkSpeedUpgrade.png",
		"displayname": "Attack Speed",
		"details": "Increases the attack speed of all weapons by an additional 10%",
		"level": "Level: 3",
		"prerequisite": ["attackspeed2"],
		"type": "upgrade"
	},
	"attackspeed4": {
		"icon": ICON_PATH + "AtkSpeedUpgrade.png",
		"displayname": "Attack Speed",
		"details": "Increases the attack speed of all weapons by an additional 10%",
		"level": "Level: 4",
		"prerequisite": ["attackspeed3"],
		"type": "upgrade"
	},
	"shrinkray1": {
		"icon": ICON_PATH + "ShrinkRay.png",
		"displayname": "Shrink Ray",
		"details": "Increases the size of all attacks by 10% of their base size",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"shrinkray2": {
		"icon": ICON_PATH + "ShrinkRay.png",
		"displayname": "Shrink Ray",
		"details": "Increases the size of all attacks by an additional 10% of their base size",
		"level": "Level: 2",
		"prerequisite": ["shrinkray1"],
		"type": "upgrade"
	},
	"shrinkray3": {
		"icon": ICON_PATH + "ShrinkRay.png",
		"displayname": "Shrink Ray",
		"details": "Increases the size of all attacks by an additional 10% of their base size",
		"level": "Level: 3",
		"prerequisite": ["shrinkray2"],
		"type": "upgrade"
	},
	"shrinkray4": {
		"icon": ICON_PATH + "ShrinkRay.png",
		"displayname": "Shrink Ray",
		"details": "Increases the size of all attacks by an additional 10% of their base size",
		"level": "Level: 4",
		"prerequisite": ["shrinkray3"],
		"type": "upgrade"
	},
	"horsedewormer": {
		"icon": ICON_PATH + "MaxHealthUpgrade.png",
		"displayname": "Horse De Wormer",
		"details": "Heals you for 20 health",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	},
}
