if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

function setup_devkitpro
    set -gx DEVKITPRO "/opt/devkitpro"
    set -gx DEVKITARM "/opt/devkitpro/devkitARM"
    set -gx DEVKITPPC "/opt/devkitpro/devkitPPC"
end

setup_devkitpro
