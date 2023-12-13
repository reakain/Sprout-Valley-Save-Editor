extends Node

var wizard_hat = preload("res://assets/cosmetics/hats/wizard_hat.png")
var beanie = preload("res://assets/cosmetics/hats/beanie.png")
var beret = preload("res://assets/cosmetics/hats/beret.png")
var bowler_hat = preload("res://assets/cosmetics/hats/bowler_hat.png")
var cap = preload("res://assets/cosmetics/hats/cap.png")
var cap_with_visor = preload("res://assets/cosmetics/hats/cap_with_visor.png")
var cat_headphones = preload("res://assets/cosmetics/hats/cat_headphones.png")
var chef_hat = preload("res://assets/cosmetics/hats/chef_hat.png")
var crown = preload("res://assets/cosmetics/hats/crown.png")
var helicopter_hat = preload("res://assets/cosmetics/hats/helicopter_hat.png")
var jester_hat = preload("res://assets/cosmetics/hats/jester_hat.png")
var top_hat = preload("res://assets/cosmetics/hats/top_hat.png")
var viking_hat = preload("res://assets/cosmetics/hats/viking_hat.png")
var pirate_hat = preload("res://assets/cosmetics/hats/pirate_hat.png")

func get_hat_texture(hat_id):
	match hat_id:
		ItemsDb.wizard_hat_id:
			return wizard_hat
		"IpA58":
			return beanie
		"QcxN7":
			return beret
		"TYef0":
			return bowler_hat
		"pYd3t":
			return cap
		"Ppnfz":
			return cap_with_visor
		"aB5II":
			return cat_headphones
		"dJupK":
			return chef_hat
		"oEkZr":
			return crown
		"dMdCj":
			return helicopter_hat
		"AvNOo":
			return jester_hat
		"jPdsw":
			return top_hat
		"bZWHA":
			return viking_hat
		"6krR3":
			return pirate_hat

	return null
