# SGキャンプ第3回 ザッハトルテ 後半アプリ開発

## 画像クイズアプリ
加工された画像をクイズ形式で出題する

## 環境構築

```
# リポジトリからプロジェクトをクローン
git clone https://github.com/SonicGardenCamp/quiz_app.git
# プロジェクトに移動
cd quiz_app
# production のgemはインストールしないように設定
bundle _2.3.14_ config set --local without 'production'
# gemのインストール
bundle _2.3.14_ install
```