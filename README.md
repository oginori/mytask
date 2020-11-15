# README

model: user
|column|data type|
|----|----|
|id|integer|
|name|string|
|mail_address|string|
|password_digest|string|

model: task
|column|data type|
|----|----|
|id|integer|
|name|string|
|description|text|
|dead_line|date|
|priority|integer|
|status|string|

model: label
|column|data type|
|----|----|
|id|integer|
|task_id|integer|
|label_id|integer|


## Herokuへのデプロイ

1. 全てのフォルダやファイルを管理対象にすることを明示

`$ git add .`

2. 現在の状態をコメント付きで保存する(コミット)

`$ git commit -m "---"`

3. 現在の状態をherokuに送信

`$ git push heroku master`

4. heroku上にDBを作成する

`$ heroku run rails db:migrate`

5. アプリを確認する

`$ heroku open`
