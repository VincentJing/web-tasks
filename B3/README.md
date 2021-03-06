# Rails 博客应用

gem install posix-spawn gem install yajl-ruby

配置sunspot用于全文搜索

rake sunspot:solr:start

rake sunspot:reindex

## 数据表结构设计

### posts表（关联comments表）

字段名        | 类型          | 字段解释
---------- | ----------- | -----
id         | int         | 主键
title      | varchar(20) | 标题
content    | text        | 文章内容
admin_id   | int         | 管理员id
created_at | datetime    | 创建时间
updated_at | datetime    | 修改时间

### categories表（关联posts表）

字段名   | 类型          | 字段解释
----- | ----------- | ----
id    | int         | 主键
title | varchar(20) | 分类名称

### categories_posts表（关联表：实现posts表与categorys表的多对多关联）

字段名         | 类型  | 字段解释
----------- | --- | --------
id          | int | 主键
post_id     | int | 文章id
category_id | int | 文章所属类型id

### comments表

字段名        | 类型           | 字段解释
---------- | ------------ | --------
id         | int          | 主键
post_id    | int          | 所属文章id
content    | varchar(100) | 评论内容
created_at | datetime     | 创建时间
email      | varchar(30)  | 评论者邮箱
status     | boolean      | 留言是否通过审核

### admins表

字段名      | 类型          | 字段解释
-------- | ----------- | ------
id       | int         | 主键
name     | varchar(15) | 管理员账户名
password | varchar(30) | 管理员密码
