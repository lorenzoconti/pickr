asm Pickr_NuSMV_b4MA

import libraries/StandardLibrary
import libraries/CTLlibrary
import libraries/LTLlibrary

signature:

	enum domain Lobby = { LEAVE | INVITE }

	enum domain Operazione = { JOIN | LOGOUT }

	enum domain Azione = { DROP | PICK }

	enum domain Stato = { MENU | WAITING_PLAYERS | PLAYING | LOGGED_OUT }

	abstract domain Utente

	domain Card subsetof Integer

	domain NumPlayers subsetof Integer

	dynamic controlled stato : Stato
	dynamic controlled hand : Utente -> Card
	dynamic controlled numOfPlayers : NumPlayers
	dynamic controlled joined : Boolean

	dynamic monitored operazione : Operazione
	dynamic monitored lobby : Lobby
	dynamic monitored azione : Azione

	static lorenzo : Utente
	
	derived utenteAttivo : Utente

	derived getHand : Card

//

definitions:

	domain Card = { 0, 1, 2, 3, 4, 5 }

	domain NumPlayers = { 0, 1, 2, 3, 4, 5}

	function getHand = hand(utenteAttivo)
	
	function utenteAttivo = lorenzo

//

macro rule r_menu =
	if( stato = MENU ) then
		par
			if ( operazione = JOIN ) then
				if ( numOfPlayers < 4) then
					par
						stato := WAITING_PLAYERS
						numOfPlayers := numOfPlayers + 1
						joined := true
						hand(utenteAttivo) := 4
					endpar
				else					
					par
						stato := PLAYING
						joined := true
					endpar
				endif
			else skip
			endif

			if( operazione = LOGOUT ) then
				stato := LOGGED_OUT
			else skip
			endif
		endpar
	else skip
	endif

macro rule r_waiting_room =
	if ( stato = WAITING_PLAYERS ) then
		par
			if ( lobby = INVITE )  then
				if ( numOfPlayers < 4) then
					par
						stato := WAITING_PLAYERS
						numOfPlayers := numOfPlayers + 1
					endpar
				else
					if ( numOfPlayers = 4 ) then
						par
							stato := PLAYING
							numOfPlayers := numOfPlayers + 1
						endpar
					else skip
					endif			
				endif
			else skip
			endif

			if ( lobby = LEAVE and joined) then
				par
					joined := false
					stato := MENU
					hand(utenteAttivo) := 0
					numOfPlayers := numOfPlayers -1
				endpar
			else skip
			endif
		endpar
	else skip
	endif

//

macro rule r_Playing =
	if ( stato = PLAYING) then
		if (azione = DROP ) then
			if (hand(utenteAttivo) > 1) then
				par
					stato := PLAYING
					hand(utenteAttivo) := hand(utenteAttivo) - 1
				endpar
			else
				par
					hand(utenteAttivo) := 0
					numOfPlayers := 0
					stato := MENU
					joined := false
				endpar
			endif
		else skip
		endif
	else skip
	endif

	CTLSPEC ag (numOfPlayers <= 5)

	CTLSPEC ag (stato = PLAYING implies numOfPlayers = 5)

	CTLSPEC ef (stato = MENU and joined implies getHand = 0)

	CTLSPEC ag ((lobby = INVITE and numOfPlayers > 1) implies ex(lobby = LEAVE and numOfPlayers > 0 ))

	CTLSPEC ag ((numOfPlayers >0 and joined) implies not(stato = MENU))

main rule r_Main =
	par
		r_menu[]
		r_waiting_room[]
		r_Playing[]
	endpar

//

default init s0:
	function stato = MENU

	function hand($u in Utente) = 4
	function numOfPlayers = 0
	function joined = false

