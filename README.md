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
