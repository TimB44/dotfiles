function tf-check --description "Run tofu init, fmt, validate, and optionally plan in a Terraform directory"
    set -l original_dir $PWD
    set -l target_dir $original_dir

    if test (count $argv) -ge 1
        set target_dir $argv[1]
        if not test -d "$target_dir"
            echo "Error: Directory $target_dir does not exist"
            return 1
        end
    end

    builtin cd "$target_dir"
    or return 1

    lucid-tf-login
    or begin
        builtin cd "$original_dir"
        return 1
    end

    echo "Running tofu init..."
    tofu init -backend=false
    or begin
        builtin cd "$original_dir"
        return 1
    end

    echo "Running tofu fmt -recursive..."
    tofu fmt -recursive
    or begin
        builtin cd "$original_dir"
        return 1
    end

    echo "Running tofu validate..."
    tofu validate
    or begin
        builtin cd "$original_dir"
        return 1
    end

    if string match -q "*/stacks/*" $PWD
        tf-plan
        or begin
            builtin cd "$original_dir"
            return 1
        end
    end

    builtin cd "$original_dir"
end

complete -c tf-check -a "(__fish_complete_directories)"
