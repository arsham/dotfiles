local palette = { ---{{{
    name           = 'arsham',
    base0          = '#232627',
    base1          = '#211F22',
    base2          = '#2A2D30',
    base3          = '#2E323C',
    base4          = '#333842',
    base5          = '#4d5154',
    base6          = '#72696A',
    base7          = '#B1B1B1',
    accent         = '#537196',
    aqua           = '#99DFE8',
    black          = '#000000',
    blue           = '#3884D6',
    blue_dark      = '#213E5D',
    blue_pale      = '#588DC4',
    blue_light     = '#3B6085',
    border         = '#A1B5B1',
    brown          = "#6D3717",
    color_column   = '#2B2828',
    darkred        = 'darkred',
    diff_add_bg    = '#3D5213',
    diff_add_fg    = '#B0C781',
    diff_change_bg = '#537196',
    diff_change_fg = '#7AA6DA',
    diff_remove_bg = '#803C52',
    diff_remove_fg = '#4A0F23',
    diff_text_bg   = '#73D2DE',
    diff_text_fg   = '#000000',
    error          = '#C46476',
    green          = '#BFDCA1',
    green_dark     = '#4F6752',
    grey           = '#72696A',
    grey_light     = '#DDDDDD',
    orange         = '#FC9867',
    pink           = '#FFA1B8',
    purple         = '#B5A9F2',
    red            = '#DE7185',
    sidebar_bg     = '#202324',
    warning        = '#FC9867',
    white          = '#FFF1F3',
    yellow         = '#EBCF7F',

    bold           = 'bold',
    bold_italic    = 'bold,italic',
    italic         = 'italic',
    none           = 'NONE',
    reverse        = 'reverse',
    undercurl      = 'undercurl',
    underline      = 'underline',
}
---}}}
require('arsham').setup(palette, 'arsham_light')
