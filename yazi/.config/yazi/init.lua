require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

require("gvfs"):setup({
	blacklist_devices = {
		{ name = "Wireless Device", scheme = "mtp" },
		{ scheme = "file" },
	},
	input_position = { "center", y = 0, w = 60 },
	password_vault = "keyring",
	save_password_autoconfirm = true,
})
