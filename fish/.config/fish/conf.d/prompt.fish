function fish_prompt
    set -l last_status $status
    set -l arrow_color a3be8c
    test $last_status -ne 0; and set arrow_color bf616a

    set_color 81a1c1
    echo -n (prompt_pwd)
    set_color $arrow_color
    echo -n ' ❯ '
    set_color normal
end
