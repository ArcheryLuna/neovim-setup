local presence = require("presence")

presence.setup({
    auto_update = true,
    neovim_image_text = "Coding a bunch of projects",
    mainimage = "neovim",
    log_level = nil,
    debounce_timeout = 10,
    enable_line_number = false,
    blacklist = {},
    buttons = true,
    file_assets = {},
    show_time = true,

    editing_text = "Editing %s",
    file_explorer_text = "Browsing %s",
    git_commit_text = "Commiting Changes",
    plugin_manager_text = "Managing packer",
    reading_text = "Learning and reading the code base on %s",
    workspace_text = "Working on %s",
    line_number_text = "%s out of %s"
})
