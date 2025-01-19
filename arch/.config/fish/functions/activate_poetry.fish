function activate_poetry
    set venv_path (poetry env info --path)
    source $venv_path/bin/activate.fish
end
