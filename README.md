# 札幌市中央区Ruby会議01 パンフレット

## 準備

    $ bundle install

### 参考

  * [Rabbit - Homebrewでインストール](http://rabbit-shocker.org/ja/install/homebrew.html)

## 修正

    $ vim timetable-and-introduction.rab.erb

## 講演詳細を同期し、PDFのソースファイルを生成

    $ rake generate

## 確認

    $ rake preview

## PDF生成

    $ rake pdf
