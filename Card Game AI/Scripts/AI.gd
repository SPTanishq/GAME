extends Node

func play_card():
	# Get AI energy and last round status
	var ai_energy = Global.total_energy
	var last_turn = Global.last_round
	
	# Evaluate the best move based on AI's hand and current game state
	var best_card = evaluate_best_card(Global.ai_hand, ai_energy, last_turn)

	# If there's a card to play
	if best_card != null:
		print("AI playing:", best_card)
		emit_signal("cardMoved", best_card, "ai")
		Global.ai_hand.erase(best_card)
	else:
		print("AI can't play any card this turn.")

# Function to evaluate the best card to play based on current board state
func evaluate_best_card(ai_hand, energy, last_turn):
	var best_card = null
	var best_score = -1
	
	for card_name in ai_hand:
		var card = Global.itemData[card_name]
		
		# Check if AI has enough energy to play the card
		if card.e <= energy:
			# Calculate the score based on card effect and board state
			var score = calculate_card_score(card_name, card, last_turn)
			
			# If the score is better than the current best, select this card
			if score > best_score:
				best_card = card_name
				best_score = score
	
	return best_card

# Function to calculate score for each card based on board state
func calculate_card_score(card_name, card, last_turn):
	var score = 0
	
	# Power scaling based on the stage of the game
	if card_name == "kaboom":
		# Kaboom is more effective in later turns when there are more cards
		if last_turn:
			score += 100  # Maximize priority for last rounds
		else:
			score += 10 * len(Global.location_data["tundra"]["player_cards"]) + 10 * len(Global.location_data["gl"]["player_cards"])
	
	elif card_name == "resupply":
		# Resupply is more effective when there are many ally cards on the board
		score += 20 * len(Global.location_data["tundra"]["ai_cards"]) + 20 * len(Global.location_data["gl"]["ai_cards"])

	elif card_name == "overcharge":
		# Overcharge doubles the power at the location
		score += Global.location_data["tundra"]["ai_power"] * 2
		score += Global.location_data["gl"]["ai_power"] * 2
	
	elif card_name == "copycat":
		# Copycat gains power when the opponent places a card
		score += 30 * (len(Global.location_data["tundra"]["player_cards"]) + len(Global.location_data["gl"]["player_cards"]))

	elif card_name == "bunker":
		# Bunker is a solid defensive card but has low power
		score += card.p * 10  # Prioritize based on its power
	
	elif card_name == "sniper":
		# Sniper transmits power across the board, consider locations with a large AI lead
		score += Global.location_data["tundra"]["ai_power"]
		score += Global.location_data["gl"]["ai_power"]
	
	return score

func _on_game_ai_turn():
	play_card()
