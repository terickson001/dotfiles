directory='./dependencies'

pacaur_install () {
    echo "Installing pacaur..."

    mkdir -p /tmp/pacaur_install
    cd /tmp/pacaur_install

    sudo pacman -S binutils make gcc fakeroot --noconfirm --needed

    sudo pacman -S expac yajl git --noconfirm --needed

    curl -o PKGBUILD https://aur.archlinux.org/cower.git
    makepkg PKGBUILD --skippgpcheck
    sudo pacman -U cower*.tar.xz --noconfirm --needed

    curl -o PKGBUILD https://aur.archlinux.org/pacaur.git
    makepkg PKGBUILD
    sudo pacman -U pacaur*.tar.xz --noconfirm --needed

    cd $(dirname "$0")
    rm -r /tmp/pacaur_install
    echo "Done"
}

test_command () {
    echo $1
    $1 bash &>/dev/null
    if [[ $? -ne 0 ]]; then
        echo "Provided command is invalid, exiting..."
        exit
    fi
}

arch_install () {
    readarray required_packages < ./dependencies/arch
    readarray optional_packages < ./dependencies/arch.opt
    echo "Updating system packages..."
    sudo pacman -Syu
    if [ ! -x /usr/bin/pacaur ]; then
        echo -n "Pacaur not found, would you like to:\n\n    1) Install pacaur (recommended)\n    2) Use your own AUR helper\nEnter your choice: "
        read choice
        case $choice in
            1) pacaur_install; command="pacaur -S --noconfirm --needed";;
            2) echo -n "\nPlease enter your AUR helper's install command ('--noconfirm' and '--needed' or their equivalent are reccomended): "; read command;;
            *) echo "\n Invalid option '$choice', exiting...(I'm lazy)";;
        esac
    else
        command="pacaur -S --noconfirm --needed"
    fi
    test_command "$command"
    echo "Installing mandatory packages .."
    for p in ${required_packages[@]}; do
        if [[ "${command:0:6}" == "pacaur" && "$(pacaur -Qs $p | grep local/$p)" != "" ]]; then
            continue
        else
            echo "| -- Installing '$p' .."
            sleep 0.5
            $command $p
            echo "    | -- Done"
        fi
    done
    echo "Installing optional packages .."
    for p in ${optional_packages[@]}; do
        skip=false
        if [[ "${command:0:6}" == "pacaur" && "$(pacaur -Qs $p | grep local/$p)" != "" ]]; then
            continue
        else
            while true; do
                read -p "Would you like to install '$p'? [Y/n]: " install_opt
                case $install_opt in
                    [Yy]*) echo "\n| -- Installing '$p' .."; break;;
                    [Nn]*) echo ""; skip=true; break;;
                    *) echo "Please answer [Y]es or [N]o .."
                esac
            done
            if $skip; then
                continue
            fi
            sleep 0.5
            $command $p
            echo "    | -- Done"
        fi
    done

}


other_install () {
    echo "Automated dependency installation is not yet implemented for your distribution"
}

case "$(uname -r | tr '[:lower:]' '[:upper:]')" in
    *ARCH*) arch_install;;
    *) other_install;;
esac
