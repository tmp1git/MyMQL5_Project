# How to ahte by Login with Google.

## `gemini auth`を実行
１．認証アクセス用のURLが表示されるのでコピー
２．コピーしたURLにローカルのブラウザからアクセス
３．Googleログイン、Gemini CLIへのログインをする
４．127.0.0.1:xxxxxx にredirectされるが、コンテナへのマッピングされてないのでERR_CONNECTION_REFUSEDになる
５．この時、ブラウザに表示されているURLをコピーする。
６．コンテナ側で、gemini認証中とは別のターミナルを立ち上げて下記コマンドを投入
```bash
# [URL] の部分に、さっきコピーした「エラーになったURL」をダブルクォートで囲って貼り付け
curl -s "[コピーしたURL]"
```
７．Done ahtuser=0　と返ってくれば成功


## こっちが実際に認証成功したコマンド
```
NO_BROWSER=true gemini
```
環境にブラウザが無い前提でアクセス先URLが出てくるので、ローカルのブラウザでこのURLにアクセス
出てきた認証コードをgeminiに返して認証成功


## 1. Chrome を Sandbox なしで起動する設定
Docker コンテナ内では、Chrome の標準機能である「Sandbox」が権限不足でエラー（Operation not permitted）になります。これを無効化して起動するように仕向けます。
ターミナルで以下を実行し、google-chrome コマンド自体を「常に --no-sandbox を付けて起動する」ように上書きします。
### エイリアスを設定
echo 'alias google-chrome="google-chrome --no-sandbox --disable-dev-shm-usage"' >> ~/.bashrc
source ~/.bashrc

```
# 1. 前回の BROWSER 設定を一度クリア（xdg-settings を動かすため）
unset BROWSER

# 2. Chrome の起動設定ファイルを直接編集して --no-sandbox を追加
# (sed コマンドを使って、Exec 行の末尾にオプションを強制挿入します)
sudo sed -i 's|Exec=/usr/bin/google-chrome-stable|Exec=/usr/bin/google-chrome-stable --no-sandbox --disable-dev-shm-usage|g' /usr/share/applications/google-chrome.desktop

# 3. 再度、既定のブラウザとして登録
xdg-settings set default-web-browser google-chrome.desktop

# 4. 
export BROWSER=/usr/bin/xdg-open

# 5. テスト
xdg-open https://google.com
```