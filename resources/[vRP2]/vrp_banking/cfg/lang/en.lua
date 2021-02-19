
local lang = {
	main = {
		bank = {
			title = "Bank",
		},
		atm = {
			title = "ATM",
		},
		veh = {
			error = "Du kan ikke være i et køretøj",
		},
	},
	error = {
		not_enough = "~r~Ikke nok penge.",
		invalid_value = "~r~ugyldig værdi.",
	},
	atm = {
		deposit = "~g~${1} ~s~deponeret.",
		withdraw = "~g~${1} ~s~Hæv.",
		w_not_enough = "~r~Du har ikke penge nok i din bank.",
		b_not_enough = "~r~Du har ikke nok penge i din tegnebog.",
	},
	transfer = {
		error = "~r~Du kan ikke overføre penge alene.",
		not_enough = "~r~Du har ikke penge nok i din bank.",
		no_player = "~r~Bruger er ikke på.",
		sent = "~g~du har sendt ${1} til {2}",
		recieved = "~g~du fik ${1} fra {2}",
	},
}

return lang
