# instagram_clone_database
This repository contains the database schema for an Instagram clone project. The database is designed to support basic Instagram-like functionality and includes 8 key tables.
database name - instagram_clone
## Database Schema
The database schema includes the following tables:
1. users : store information about the users
   columns:
   ID(int,primarykey,identity)
   username(varchar,notnull)
   created_at(datetime,default-getdate())
2. photos : store information about the uploaded photos.
   columns:
   id(int,primarykey)
   image_url(varchar,notnull)
   user_id(int,notnull,foreignkey(users-ID))
   created_at(datetime,default-getdate())
3. comments : store the comment information of users.
   columns:
   id(int,primarykey)
   comment_text(varchar,notnull)
   user_id(int,notnull,foreignkey(users-ID))
   photo_id(int,notnull,foreignkey(photos-id))
   created_at(datetime,default-getdate())
5. likes : store the information about the likes of a user.
   columns:
   id(int,primarykey)
   user_id(int,notnull,foreignkey(users-ID))
   photo_id(int,notnull,foreignkey(photos-id))
   created_at(datetime,default-getdate())
6. follows :
   columns :
   id(int,primarykey)
   follower_id(int,notnull,foreignkey(users-ID))
   followee_id(int,notnull,foreignkey(users-ID))
   created_at(datetime,default-getdate())
7. tags :
   columns :
   id(int,primarykey)
   tag_name(varchar,unique+notnull)
   created_at(datetime,default-getdate())
8. junction_table :
   columns :
   id(int,primarykey)
   photo_id(int,notnull,foreignkey(photos-id))
   tag_id(int,notnull,foreignkey(tags-id))
   
