FROM mcr.microsoft.com/devcontainers/base:ubuntu

# 1. 基本パッケージと日本語フォント・ロケールのインストール
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    rsync \
    wget \
    gnupg \
    ca-certificates \
    xdg-utils \
    locales \
    fonts-noto-cjk \
    curl \
    && locale-gen ja_JP.UTF-8 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Google Chrome のインストールと設定変更
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    # ランチャーの引数に --no-sandbox を追加 (元の postCreateCommand の処理)
    && sed -i 's|Exec=/usr/bin/google-chrome-stable|Exec=/usr/bin/google-chrome-stable --no-sandbox --disable-dev-shm-usage|g' /usr/share/applications/google-chrome.desktop \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 3. Node.js (v20) と gemini-cli のインストール
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g @google/gemini-cli \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 環境変数の設定
ENV LANG=ja_JP.UTF-8
ENV LANGUAGE=ja_JP:ja
ENV LC_ALL=ja_JP.UTF-8