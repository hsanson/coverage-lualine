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

> [!NOTE]
> You must load the coverage report using `CoverageLoad` after running the
> tests for the coverage information to be shown in the statusline and winbar.
> You may also want to show coverage signs by
> executing `Coverage`.

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

Depending on the `min_coverage` configured in [nvim-coverage](https://github.com/andythigpen/nvim-coverage) plugin the color of the coverage will change to the `bad` highlight if coverage is less than the `min_coverage`, `ok` highlight if larger than `min_coverage` but less than 100%, and `good` highlight if it is 100%.
