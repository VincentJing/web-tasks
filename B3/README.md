# Rails 博客应用

## 数据表结构设计

### posts表
字段名|类型|字段解释
-----|---|-------
id   |int|主键
title|varchar(20)|标题
text |text|文章内容
admin_id|int|管理员id
created_at|datetime|创建时间
updated_at|datetime|修改时间
type|varchar(15)|文章分类

### comments表  
字段名|类型|字段解释
-----|---|-------
id   |int|主键
post_id|int|所属文章id
content|varchar(100)|评论内容
created_at|datetime|创建时间
author|varchar(15)|评论者姓名
email|varchar(30)|评论者邮箱
author_id|int|评论者id(可空)
status|int|留言是否通过审核(0 1表示)

### feedbacks表
字段名|类型|字段解释
-----|---|-------
id|int|主键
content|varchar(100)|反馈内容
author|varchar(15)|反馈者姓名
email|varchar(30)|反馈者邮箱
author_id|int|评论者id(可空)

### admins表
字段名|类型|字段解释
-----|---|-------
id|int|主键
name|varchar(15)|管理员账户名
password|varchar(30)|管理员密码

### users表
字段名|类型|字段解释
-----|---|-------
id|int|主键
name|varchar(15)|用户名
password|varchar(30)|用户密码
email|varchar(30)|用户邮箱
