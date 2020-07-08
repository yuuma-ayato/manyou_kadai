# タスク管理システム

## 説明
このアプリはタスク管理システムです。終了期限、優先順位をつけて管理する事が出来ます。
またタスク名、ラベルから検索が可能です。ラベル機能を利用する際はコンソールからラベルの作成をお願いします。

## バージョン情報
-ruby 2.6.5p114<br>
-Rails 5.2.4.3<br>
-psql (PostgreSQL) 12.3<br>
<br>
<br>
### Taskテーブル
|  Column  |  Type  |
| ---- | ---- |
|  title  |  string  |
|  content  |  text  |
|  user_id  |  index  |

### Userテーブル
|  Column  |  Type  |
| ---- | ---- |
|  name  |  string  |
|  email  |  string  |
|  password_digest  |  string  |

### Labelテーブル
|  Column  |  Type  |
| ---- | ---- |
|  task_id  |  integer  |
|  user_id  |  integer  |


## Herokuへのデプロイ方法

1.Herokuにログインする。
```
heroku login
```

2.Herokuに新しいアプリケーションを作成
```
heroku create アプリ名
```


## Herokuへのデプロイ方法

1.Herokuにログインする。
```
heroku login
```

2.Herokuに新しいアプリケーションを作成
```
heroku create アプリ名
```

3.プリコンパイル
```
rails assets:precompile RAILS_ENV=production
```

4.Herokuにデプロイ
```
git add -A
git commit -m "任意のコメント"
git push heroku master
```
