# SGキャンプ第3回 後半アプリ開発

## 画像クイズアプリ
加工された画像をクイズ形式で出題するアプリです。

## 環境構築(mac)
```sh
# リポジトリからプロジェクトをクローン
$ git clone https://github.com/MakioShimomura/atero.git

# Railsのgemをインストール
$ sudo gem install rails

# プロジェクトに移動
$ cd quiz_app

# homebrewの更新
$ brew update

# postgresql を起動
$ brew services start postgresql@14

# postgresql が起動していることを確認
$ brew services list

# Imagemagick をインストール
$ brew install imagemagick

# gemのインストール
$ bundle install

# database.ymlを読み込み，database.ymlに基づいてデータベースを作成
$ rails db:create

# マイグレート
$ rails db:migrate

# シードの実行
$ rails db:seed

# Pumaの起動
$ rails server
```

## 環境構築(linux) cloud9での実装時

```sh
# リポジトリからプロジェクトをクローン
git clone https://github.com/SonicGardenCamp/quiz_app.git

# Railsのgemをインストール
$ sudo gem install rails

# プロジェクトに移動
$ cd quiz_app

# パッケージ一覧を更新(パッケージのリポジトリから、パッケージの名前やバージョン、依存関係を取得し、有効でインストール可能なパッケージの一覧を更新)
$ sudo apt update

# ImageMagickのヘッダとライブラリをインストール
$ sudo apt install libmagickcore-dev

# Postgresqlの開発ライブラリ「libpq-dev」をインストール
$ sudo apt install libpq-dev

# postgresqlのインストール
$ sudo apt install postgresql

# gemのインストール
$ bundle _2.3.14_ install

# 状態確認(postgresql導入直後に、サービスは開始された状態になる)
$ sudo service postgresql status

# ユーザー 【postgres】 に切り替え 
$ sudo -u postgres -i

# PostgreSQL との対話モードに切り替え(psql の部分のみ実行)
postgres@ip-XX-XX-XX-XX:~$ psql

# PostgreSQL で postgres に対し postgres の文字列でパスワードを設定
postgres=# \password(<-バックスラッシュを含め入力)
Enter new password for user "postgres": postgres (<-パスワードを入力)
Enter it again: postgres (<-再度パスワードを入力)

# PostgreSQL との対話モードを終了
postgres=# \q

# ユーザー 【postgres】 からログアウト
postgres@ip-XX-XX-XX-XX:~$ exit

# database.ymlを読み込み，そのファイルに基づいてデータベースを作成
$ rails db:create

# マイグレート
$ rails db:migrate

# シードの実行
$ rails db:seed
```