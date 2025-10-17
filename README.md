# coverage-lualine

Component for [lualine](https://github.com/nvim-lualine/lualine.nvim) that
displays coverage percentage for the file in current buffer or total coverage of
the project.

## Requirements

- Neovim 0.11+
- [lualine](https://github.com/nvim-lualine/lualine.nvim)
- [nvim-coverage](https://github.com/andythigpen/nvim-coverage)
- [NerdFonts](https://www.nerdfonts.com/#home) -- For default icons,

## Installation

Using Lazy

```lua
{ 'hsanson/coverage-lualine' }
```

## Usage

The following configuration add the lualine-coverage component with total scope
to the status line and with file scope to the winbar.

```lua
lualine.setup({
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_x = {
            {
                "lualine-coverage",
                scope = "total",
            },
        },
    },
    winbar = {
        lualine_y = {
            {
                "lualine-coverage",
                scope = "file",
            },
        },
    },
})
```

Default configuration is shown below, feel free to adapt to your liking:

```lua
lualine.setup({
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_x = {
            {
                "lualine-coverage",
                hl = {
                  bad = "#FF0000",
                  ok  = "#00FFFF",
                  good = "#00FF00",
                },
                icon = " ",
                percent_icon = " ",
                scope = "total",
            },
        },
    },
    winbar = {
        lualine_y = {
            {
                "lualine-coverage",
                hl = {
                  bad = "#FF0000",
                  ok  = "#00FFFF",
                  good = "#00FF00",
                },
                icon = " ",
                percent_icon = " ",
                scope = "file",
            },
        },
    },
})
```
