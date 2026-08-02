function tf-plan --description "Run spacectl local-preview for a Terraform stack"
    set -l dir .
    if set -q argv[1]
        set dir $argv[1]
    end

    set -l stack_info "$dir/.lucid_stack_info"
    if not test -f "$stack_info"
        echo "Error: .lucid_stack_info not found in $dir"
        return 1
    end

    set -l stack_id (jq -r '.id' "$stack_info")
    if test -z "$stack_id" -o "$stack_id" = null
        echo "Error: Could not read 'id' from .lucid_stack_info"
        return 1
    end

    lucid-tf-login
    or return 1

    echo "Running local preview for stack: $stack_id"
    spacectl stack local-preview -id "$stack_id" --prioritize-run
end
