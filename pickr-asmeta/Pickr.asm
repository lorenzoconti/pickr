asm prova

import libraries/StandardLibrary

signature:

	enum domain Lobby = { LEAVE | INVITE }

	enum domain Operazione = { JOIN | LOGOUT }

	enum domain Azione = { DROP }

	enum domain Stato = { INSERISCI_USERNAME | INSERISCI_PASSWORD | MENU | WAITING_PLAYERS | PLAYING }

	abstract domain Utente

	domain Card subsetof Integer

	dynamic controlled print : Any
	dynamic controlled stato : Stato
	dynamic controlled utenteAttivo : Utente
	dynamic controlled hand : Utente -> Card
	dynamic controlled numOfPlayers : Integer
	dynamic controlled joined : Boolean

	dynamic monitored operazione : Operazione
	dynamic monitored lobby : Lobby
	dynamic monitored azione : Azione
	dynamic monitored username : Utente
	dynamic monitored password : String

	static lorenzo : Utente
	static admin : Utente

	derived getPassword : Utente -> String

//

definitions:

	domain Card = {0, 1, 2 , 4, 5, 6, 7 ,8}

	function getPassword($u in Utente) =
		switch($u)
			case lorenzo : "password"
			case admin : "admin"
		endswitch

//

macro rule r_inserisciUsername =
	if ( stato = INSERISCI_USERNAME ) then
		if ( exist $u in Utente with $u = username ) then
			par
				utenteAttivo := username
				stato := INSERISCI_PASSWORD
				print := "Inserire password"
			endpar
		endif
	endif

//

macro rule r_inserisciPassword =
	if ( stato = INSERISCI_PASSWORD ) then
		let ( $password = getPassword(utenteAttivo) ) in
			if ($password = password) then
				par
					stato := MENU
					print := "Benvenuto, seleziona l'operazione che vuoi eseguire"
				endpar
			else
				par
					stato := INSERISCI_USERNAME
					print := "Password sbagliata, riprova"
				endpar
			endif
		endlet
	endif

//

macro rule r_menu =
	if( stato = MENU ) then
		par
			if ( operazione = JOIN ) then
				if ( numOfPlayers < 4) then
					par
						stato := WAITING_PLAYERS
						numOfPlayers := numOfPlayers + 1
						print := "Sei entrato nella partita, in attesa di giocatori."
						joined := true
					endpar
				else
					if ( numOfPlayers = 4 ) then
						par
							stato := PLAYING
							print := "La partita è cominciata."
							joined := true
						endpar
					endif
				endif
			endif

			if( operazione = LOGOUT ) then
				par
					stato := INSERISCI_USERNAME
					print := "Logout effettuato con successo"
				endpar
			endif
		endpar
	endif

macro rule r_waiting_room =
	if ( stato = WAITING_PLAYERS ) then
		par
			if ( lobby = INVITE )  then
				if ( numOfPlayers < 4) then
					par
						stato := WAITING_PLAYERS
						numOfPlayers := numOfPlayers + 1
						print := "Sei entrato nella partita, in attesa di giocatori."
					endpar
				else
					if ( numOfPlayers = 4 ) then
						par
							stato := PLAYING
							print := "La partita è cominciata."
							numOfPlayers := numOfPlayers + 1
						endpar
					endif
				endif
			endif

			if ( lobby = LEAVE and joined) then
				par
					joined := false
					stato := MENU
					numOfPlayers := numOfPlayers -1
				endpar
			endif
		endpar
	endif

//

macro rule r_Playing =
	if ( stato = PLAYING) then
		if (azione = DROP ) then
			if (hand(utenteAttivo) > 1) then
				par
					stato := PLAYING
					print := "Hai scartato una carta"
					hand(utenteAttivo) := hand(utenteAttivo) - 1
				endpar
			else
				par
					stato := MENU
					print := "Partita Terminata"
					hand(utenteAttivo) := 0
					numOfPlayers := 0
					joined := false
				endpar
			endif
		endif
	endif


main rule r_Main =
	seq
		r_inserisciUsername[]
		par
			r_inserisciPassword[]
			r_menu[]
			r_waiting_room[]
			r_Playing[]
		endpar
	endseq

//

default init s0:
	function stato = INSERISCI_USERNAME
	function print = "Inserire username"
	function numOfPlayers = 0
	function joined = false
	function hand( $u in Utente ) = 4

