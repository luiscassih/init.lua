kitten ssh root@...
ip link #to see mac address
apt-get install tmux zsh fzf nginx certbot python3-certbot-nginx
curl -sS https://starship.rs/install.sh | sh
chsh -s /bin/zsh
chmod +x /usr/bin/ts
certbot --nginx
certbot certonly --manual -d "*.luisc.dev"


# min zsh

```zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/l/.zshrc'
 
autoload -Uz compinit
compinit
 
alias v=nvim
alias t=tmux
alias so="source .zshrc"
alias tmuxsource="tmux source ~/.config/tmux/tmux.conf"
alias ta="tmux a -t"
tnew() {
  if [ -z "$1" ]; then
    echo "No session name provided."
    return 1
  fi
 
  # Check if tmux session exists
  if tmux has-session -t $1 2>/dev/null; then
    echo "Session $1 already exists."
  else
    tmux new-session -s $1
  fi
}
eval "$(starship init zsh)"`
```
sites-enabled/luisc.dev
```
server {
        listen 80;
        server_name vite.luisc.dev;

        location / {
            return 301 https://$host$request_uri;
        }
}
server {
        listen 443 ssl; # managed by Certbot
        server_name vite.luisc.dev;
        ssl_certificate /etc/letsencrypt/live/luisc.dev/fullchain.pem; # managed by Certbot
        ssl_certificate_key /etc/letsencrypt/live/luisc.dev/privkey.pem; # managed by Certbot
        include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
        ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

        location / {
            proxy_pass http://localhost:5000;
            include /etc/nginx/fragments/common-headers;
        }
}

```
/etc/nginx/fragments/common-headers
```
proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
```


