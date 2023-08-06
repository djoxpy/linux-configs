function fish_prompt --description 'Write out the prompt'
    set -l laststatus $status

    set -l git_info
    if set -l git_branch (git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
        set git_branch (set_color -o blue)"$git_branch"
        set git_info "$git_branch"(set_color white)""
    end

    # Disable PWD shortening by default.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    set_color -b black
    printf '%s%s%s%s%s%s%s%s%s%s%s%s%s' (set_color -o white) '❰' (set_color green) $USER (set_color white) '❙' (set_color yellow) (prompt_pwd) (set_color white) $git_info (set_color white) '❱' (set_color white)
    if test $laststatus -eq 0
        printf "%s✔%s≻%s " (set_color -o green) (set_color white) (set_color normal)
    else
        printf "%s✘%s≻%s " (set_color -o red) (set_color white) (set_color normal)
    end
end
