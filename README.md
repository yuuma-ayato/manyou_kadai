# タスク管理システム

#バージョン情報
-ruby 2.6.5p114
-Rails 5.2.4.3
-psql (PostgreSQL) 12.3

Taskテーブル
|  Column  |  Type  |
| ---- | ---- |
|  title  |  string  |
|  content  |  text  |
|  user_id  |  index  |

Userテーブル
|  Column  |  Type  |
| ---- | ---- |
|  name  |  string  |
|  email  |  string  |
|  password_digest  |  string  |

Labelテーブル
|  Column  |  Type  |
| ---- | ---- |
|  task_id  |  integer  |
|  user_id  |  integer  |


#Herokuへのデプロイ方法
1.Herokuにログインする。
```heroku login```

2.Herokuに新しいアプリケーションを作成
```heroku create アプリ名```

3.プリコンパイル
```rails assets:precompile RAILS_ENV=production```

4.Herokuにデプロイ
```git add -A
git commit -m "任意のコメント"
git push heroku master```
