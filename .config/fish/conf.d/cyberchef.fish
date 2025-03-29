#!/usr/bin/env fish

function cyberchef
    cd $HOME/.local/share/CyberChef
    python3 -m http.server
end
