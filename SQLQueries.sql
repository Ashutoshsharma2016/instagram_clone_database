use instagram_clone ;
/*We want to reward our users who have been around the longest.  
Find the 5 oldest users.*/
SELECT top 5 * FROM users
ORDER BY created_at ;

/*find the 5 latest users*/
SELECT top 5 * FROM users
ORDER BY created_at desc ;


/*What day of the week do most users register on?
We need to figure out when to schedule an ad campgain*/
select * from users ;
SELECT top 1 count(*) as total_registration, DATENAME(WEEKDAY, created_at) AS DayOfWeek from users 
group by DATENAME(WEEKDAY, created_at);



/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo*/
select * from users ;
select * from photos ;
select distinct username, users.id from users left join photos on users.id=photos.user_id where user_id is null ;


/*We're running a new contest to see who can get the most likes on a single photo.
WHO WON??!!*/
select * from likes ;
select * from photos ;
select * from users ;
select  top 1 count(*) as no_of_likes , users.id , users.username from photos inner join likes on photos.id=likes.photo_id inner join users on users.id=photos.user_id
group by photos.id ,users.id ,users.username
order by count(*) desc ;



/*Our Investors want to know...
How many times does the average user post?*/
/*total number of photos/total number of users*/
select * from likes ;
select * from users ;
select (select count (*) from photos)*1.0/(select count(*) from users) as average



/*user ranking by postings higher to lower
method1*/

select * from users ;
select count(user_id) as no_of_posts, username from photos inner join users on photos.user_id=users.id 
group by user_id,username
order by no_of_posts desc;


/*user ranking by postings higher to lower
method2*/
select count(username) as no_of_posts , username, dense_rank() over(order by count(username) desc) as rnk from photos inner join users on photos.user_id=users.id 
group by user_id,username ;



/*Total Posts by users (longer versionof SELECT COUNT(*)FROM photos) */
select * from users ;
select * from photos ;
select count(*) as total_posts from users full join photos on users.id=photos.user_id 
where photos.id is not null;



/*total numbers of users who have posted at least one time */
with cte as
(select users.username ,photos.id , DENSE_RANK() over (partition by username order by photos.id) as rnk from users full join photos on users.id=photos.user_id 
where photos.id is not null)
select count(*) as no_of_users_post_atleat_one_post from cte group by rnk 
having rnk=1
;


SELECT COUNT(DISTINCT(users.id)) AS total_number_of_users_with_posts
FROM users
JOIN photos ON users.id = photos.user_id;


/*A brand wants to know which hashtags to use in a post
What are the top 5 most commonly used hashtags?*/

select top 5 tag_name, count(*) as no_of_times_used_tag from photo_tags inner join photos on photo_tags.photo_id=photos.id inner join tags on tags.id=photo_tags.tag_id
group by tag_name
order by count(*) desc




/*We have a small problem with bots on our site...
Find users who have liked every single photo on the site*/
select user_id ,username ,count(*) as no_of_photos_liked from likes inner join users on users.id=likes.user_id 
group by user_id ,username
having count(*)=(select count(*) from photos);



/*We also have a problem with celebrities
Find users who have never commented on a photo*/
select username , users.id  from comments full join users on users.id=comments.user_id
where comment_text is null
order by users.id;



/*Mega Challenges
Are we overrun with bots and celebrity accounts?
Find the percentage of our users who have either never commented on a photo or have commented on every photo*/

with cte as
(select count(comment_text) as no_of_users ,  users.id from comments full join users on users.id=comments.user_id
group by users.id
having count(comment_text)=0 or count(comment_text)=(select count(*) from photos)
)
select count(*)*1.0/(select count(*) from users)*100 as percentage_of_users from cte ;




/*Find users who have ever commented on a photo*/
select distinct user_id ,username from comments inner join users on comments.user_id=users.id
where comment_text is not null
order by user_id;
