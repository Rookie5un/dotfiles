set -g fish_greeting

set -gx HOMEBREW_PIP_INDEX_URL https://pypi.mirrors.ustc.edu.cn/simple
set -gx HOMEBREW_API_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles/api
set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.ustc.edu.cn/homebrew-bottles

if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

set -gx JAVA_HOME /opt/homebrew/opt/openjdk@17
if test -d $JAVA_HOME/bin
    fish_add_path -gP $JAVA_HOME/bin
end

set -gx NVM_DIR $HOME/.nvm
if test -s /opt/homebrew/opt/nvm/nvm.sh
    function __nvm_refresh --description "Sync fish PATH with the active nvm Node version"
        set -l clean_path
        for path_entry in $PATH
            if not string match -q -- "$NVM_DIR/versions/node/*/bin" $path_entry
                set clean_path $clean_path $path_entry
            end
        end
        set -gx PATH $clean_path

        set -l current_node (bash -lc "export NVM_DIR=\"$NVM_DIR\"; source /opt/homebrew/opt/nvm/nvm.sh; nvm which current 2>/dev/null" | string trim)
        if string match -q -- "$NVM_DIR/versions/node/*/bin/node" $current_node
            fish_add_path -gP (dirname $current_node)
        end
    end

    function nvm --description "Run nvm and sync the active Node version into fish"
        set -l nvm_args (string join " " -- (string escape -- $argv))
        bash -lc "export NVM_DIR=\"$NVM_DIR\"; source /opt/homebrew/opt/nvm/nvm.sh; nvm $nvm_args"
        set -l nvm_status $status
        __nvm_refresh
        return $nvm_status
    end

    __nvm_refresh
end

if test -x /Users/rookie/miniconda3/bin/conda
    eval (/Users/rookie/miniconda3/bin/conda shell.fish hook 2>/dev/null)
end

if status is-interactive
    alias ll="ls -lah"
    alias la="ls -la"
    alias gs="git status -sb"
end
