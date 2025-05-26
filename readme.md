## 01. What Is PostgreSQL

PostgreSQL হচ্ছে একটা অবজেক্ট রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম সফটওয়্যার। মানে এখানে ডাটাগুলো টেবিলের মধ্যে column(কলাম) এবং row (সারি) আকারে সাজানো থাকে। এই সফটওয়ারের মাধ্যমে আমারা আমাদের কম্পিউটের ডিস্ক স্পেসকে একটা ডাটাবেসে রূপান্তরিত করতে পারি। আমাদের এই ডাটাবেসে ডাটা কিভাবে ইন্সার্ট হবে, আপডেট হবে এবং ডাটাগুলো ঠিক কিভাবে সাজানো থাকবে সেটা PostgreSQL তারমতো করে ঠিক করে নেয়। এটা নিয়ে আমাদের আলাদা করে ভাবতে হয় না।

PostgreSQL বাদেও আরো অনেক রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম রয়েছে। তবে বাকি গুলো থেকে PostgreSQL কে যেই জিনিসগুলো আলাদা করে সেগুলো হলো

- ৩৫ বছরের বেশি সময় একটিভ ডেভেলপমেন্টে থাকা।
- বিশাল কমিউনিটি সাপোর্ট
- ওপেন - সোর্স সফটওয়্যার কাজেই যে কেউ ব্যবহার করতে পারে
- বেশিরভাগ স্টার্টআপ তাদের ডাটাবেস হিসেবে এটাকে বেছে নেয় তাই PostgreSQL ডেভেলপারদের চাহিদা অনেক ।

PostgreSQL আমাদেরকে মূলত SQL নামের একটা query language ব্যবহার করে ডাটা ম্যানুপুলেটে করার সুযোগ দেয়। SQL হচ্ছে একটা English-like query language. যার ফুল ফর্ম হচ্ছে Standardized Query Language. যেমন :

```sql
--students নামের একটা টেবিল তৈরী করা হবে ।  যার ID আর student_name নামের দুইটা কলাম থাকবে।
--যেখানে নামটা ৫০  ক্যারেক্টার এর বেশি দেয়া যাবে না।
    CREATE TABLE students (ID BIGSERIAL PRIMARY KEY, student_name VARCHAR(50));
-- যাই টেবিল এর নাম দেয়া হবে সেখান থেকে সব কলাম এর সব ডাটা সিলেক্ট করা হবে।
     SELECT * FROM students;
```

## 02. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

Primary Key: Primary Key হচ্ছে একটা টেবিলের মধ্যে থাকা এমন একটা কলাম যেটা কিনা ওই row বা সারিটাকে uniquely identify করে। আরো সহজ ভাষায় বললে primary key হচ্ছে এমন একটা কলাম যেটার মধ্যে যাই value গুলো থাকে ঐটা ওই সারিটাকে বাকি সারিগুলো থেকে আলাদা করে। Primary key একটা টেবিলে কখনো দুইটা থাকতে পারবে না।

| ID  | name  | location  |
| --- | ----- | --------- |
| 1   | smith | colarodo  |
| 2   | jane  | texas     |
| 3   | anna  | new jersy |

এই টেবিলের মধ্যে ID একটা primary key হতে পারে কারণ ইটা প্রত্যেক সারির জন্য আলাদা। আর এই Primary Key আমরাই আমাদের টেবিলের জন্য সিলেক্ট করে থাকি । যদি আমরা এই টেবিলের জন্য ID তাকে Primary Key হিসেবে select করি তাহলে আমরা টেবিল create করার সময় বলে দিতে পারি।

```sql
    CREATE TABLE students (ID BIGSERIAL PRIMARY KEY, "name" VARCHAR(50));
```

Serial Constraint টা use করার কারণে এই ID এর value প্রত্যেকবার নতুন ডাটা insert করার সময় অটোমেটিক বাড়তে থাকবে। যদি টেবিলে already ৩ তা ডাটা থেকে থাকে তাহলে ৪ নম্বর ডাটা insert করার সময় ID এর ভ্যালু হয়ে যাবে ৪ । ঐটা আমাদের ম্যানুয়ালি ইনক্রিমেন্ট করা লাগবে না।

Foreign Key : যখন এক টেবিলের Primary Key ঐ টেবিলের কোনো specific row কে নির্দেশ করতে অন্য টেবিল এ ব্যবহৃত হয় তখন আমরা সেটাকে বলি Foreign Key। এভাবে দুইটা টেবিলের মধ্যে relation তৈরী হয়। Foreign Key যে শুধু দুইটা টেবিলের মধ্যে relation তৈরী করে বিষয়টা এমন না। Foreign Key ব্যবহারের মাধ্যমে আমরা আমাদের টেবিলে data redundancy দূর করতে পারি এবং একই সাথে অনেকটা space ও বাচাতে পারি।

Foreign Key ও Primary Key এর কন্সেপ্টটা একটা উদহারণ দিয়ে বুঝার চেষ্টা করি :

ধরেন , আপনি একটা online business manage করছেন । আপনার বিভিন্ন জায়গা থেকে অর্ডার আশা শুরু করেছে আপনি ওই অর্ডার গুলো store করতে একটা টেবিল create করলেন যেখানে একজন গ্রাহক এর ঠিকানা এবং অর্ডার এর ইনফর্মেশন আছে ।

| ID  | customer_name | customer_location       | orders   |
| --- | ------------- | ----------------------- | -------- |
| 1   | ricky         | 57th street, NYC        | \_\_\_\_ |
| 2   | shawn         | 7th street , washington | \_\_\_   |
| 3   | micheal       | 28th street, new jersey | \_\_\_\_ |

এই পর্যন্ত সব ঠিক আছে এখন ধরেন ricky নামের কাস্টমার আবার কয়েকটা অর্ডার প্লেস করলো|

| ID  | customer_name | customer_location       | orders        |
| --- | ------------- | ----------------------- | ------------- |
| 1   | ricky         | 57th street, NYC        | Nescafe 500mg |
| 2   | shawn         | 7th street , washington | \_\_\_        |
| 3   | micheal       | 28th street, new jersey | \_\_\_\_      |
| 4   | ricky         | 57th street, NYC        | 1kg orange    |
| 5   | ricky         | 57th street, NYC        | Nescafe 500mg |

এখন টেবিলে একই data বার বার রিপিট হচ্ছে । এবং anomalies বা data এর মধ্যে অসঙ্গতি সৃষ্টি হওয়ার একটা প্রবণতা দেখা যাচ্ছে এখন এইটা resolve করা যায় order নামের একটা টেবিল create করে ঐ টেবিলে কাস্টমার ID একটা Foreign Key হিসেবে add করে ।

<table>
<tr><th>Order Table </th><th>Customer Table</th></tr>
<tr><td>

| order_id(Primary Key) | customer_id (Foreign Key) | orders   |
| --------------------- | ------------------------- | -------- |
| 1                     | 1                         | \_\_\_\_ |
| 2                     | 1                         | \_\_\_\_ |
| 3                     | 2                         | \_\_\_   |

</td><td>

| customer_id(Primary Key) | customer_name | location                |
| ------------------------ | ------------- | ----------------------- |
| 1                        | Rickey        | 57th street, NYC        |
| 2                        | Shawn         | 7th street, Washington  |
| 3                        | Micheal       | 28th street, New Jersey |

</td></tr> </table>
এখন আমরা চাইলে কাস্টোমারদের  অর্ডারের ডাটা কালেক্ট করতে পারি তাদের ID এর মাধ্যমে।  কারণ ID  এর মাধ্যমে customer টেবিল ও order  টেবিলের মধ্যেই একটা one to many relation তৈরি হয়েছে।
Order টেবিলটা create করার সময় তার মধ্যে যে একটা Foreign Key থাকবে সেটা তাকে বলে দিতে হবে, আর কোন টেবিল থেকে Foreign Key তা আসবে সেটাও Reference করে দিতে হবে।

```sql
CREATE TABLE order
(order_id BIGSERIAL PRIMARY KEY,
--এখানে customer_id একটা Foreign Key  যেটা customer টেবিলের customer_id কে রেফার করে
customer_id INTEGER REFERENCES customer(customer_id),
orders VARCHAR(200));
```

## 03 .Explain the purpose of the WHERE clause in a SELECT statement

একটা SELECT Statement এর মধ্যে WHERE clause মুলত filter এর মতো কাজ করে। SELECT Statement আপনাকে কিছু ডাটা রিটার্ন করবে, হতে পারে একটা টেবিলের কলাম, হতে পারে একটি সম্পূর্ণ টেবিল তারপর আপনি যখন WHERE clause use করবেন তখন আপনি একটা condition বা শর্ত add করতে পারবেন, যেই ডাটাগুলো আপনার দেয়া condition Full-Fill করবে তারা বাদে বাকি সব ডাটা filter out হয়ে যাবে।

```sql
--এই query টা  শুধুমাত্র ঐসব ডাটাই রিটার্ন করবে যেখানে কাস্টমার এর first_name Jake
SELECT * FROM customers WHERE first_name = 'Jake';
```

ধরেন আমাদের একটা student টেবিল আছে যার মধ্যে একটা age নামের কলাম আছে যেখান থেকে আমরা চাচ্ছি ঐসব student দেরকে খুঁজতে যাদের বয়স ১৮ বা তার বেশি। তাহলে আমার এভাবে একটা query লিখতে পারি।

```sql
    SELECT * FROM students WHERE age >= 18;
```

## 04. Explain the GROUP BY clause and its role in aggregation operations

GROUP BY clause মূলত ডাটাগুলোকে গ্রপ করে আমাদেরকে দেখায়। আমরা আমাদের SELECT clause এর মধ্যে বলে দিতে পারি যে কোন কলাম বা কিসের ভিত্তেতে গ্রুপিং টা করা হবে। যেমন :

ধরেন আমাদের একটা students টেবিল আছে যেখানে name , age , country , course নামের কয়েকটা কলাম আছে। এখন যদি আমরা চাই যে আমরা আমাদের student দেরকে তাদের country wise গ্রুপ করে দেখবো তাহলে তাহলে আমরা এই query টা use করবো।

```sql
    SELECT country FROM students GROUP BY country;
```

এই query টা আমাদেরকে এই ধরণের রেজাল্ট দিবে।

| country |
| ------- |
| USA     |
| Mexico  |
| UK      |
| Japan   |

GROUP BY clause Aggregate function এর সাথে ভালোভাবে কাজ করে। Group by clause আমরা aggregate function এর সাথেই বেশি ব্যবহার করি।

GROUP BY এর সাথে aggregate function যেভাবে কাজ করে ঐ procedure টার একটা নাম আছে সেটা হলে Split, Combine, Apply। এটা যদি আমরা একটা উদাহরণের মাধ্যমে বুঝার চেষ্টা করি :

xy Table:

| x   | y   |
| --- | --- |
| a   | 20  |
| a   | 15  |
| b   | 30  |
| b   | 20  |

এখন আমার যদি এই টেবিলে sum function এর মাধ্যমে দেখতে চাই যে a এবং b এর সমষ্টি কত ? তাহলে আমার এই query টা run করতে পারি।

```sql
SELECT x, SUM(y) FROM xy GROUP BY x; --output a -> 35 b-> 50
```

এখন এই query টা টেবিল টাকে দুই ভাগে ভাগ করবে তারপর প্রত্যেকটা ভাগে sum function আলাদা আলাদা ভাবে Run করা হবে তারপর সেগুলো combine করে রেজাল্টটা দেখাবে ।

<table> 
<tr> 
<td>
a
</td>
<td>20 </td>
</tr>
<tr> 
<td>
a
</td>
<td>15 </td>
</tr>
</table>

<br>
<table> 
<tr> 
<td>
b
</td>
<td>30 </td>
</tr>
<tr> 
<td>
b
</td>
<td>10 </td>
</tr>
</table>

এখন যদি আমরা আমাদের আগের example এ ফেরত যাই এবং এই বার আমরা চাই যে কোন দেশে আমাদের কত জন student আছে ঐটা দেখতে তাহলে আমরা count নামের aggregate function টা ব্যবহার করতে পারি ।

```sql
SELECT country, COUNT(*) FROM students GROUP BY country;
```

এখানেও প্রথমে সবাইকে তাদের country অনুযায়ী split করে তারপর Count function টা ঐ split করা টেবিলেরগুলোর উপর Run হবে তারপর সবগুলো টেবিল combine করে রেজাল্ট দেখানো হবে ।

## 05. What is the difference between the VARCHAR and CHAR data types?

CHAR বা character datatype হচ্ছে একটা fixed-length datatype আপনি যদি একটা কলাম কে ২০ char specify করে বলে দেন তাহলে যেটা হবে যে আপনি যদি ঐ কলাম এ ডাটা রাখার সময় আপনার ডাটার length যতটুকুই হোক না কেন সে ২০ ক্যারেক্টার স্পেস পুরো দখল করে নিবে। ধরেন আপনি ২০ ক্যারেক্টার এর জায়গায় ব্যবহার করছেন ৬ ক্যারেক্টার তাহলে সে বাকি ১৪ ক্যারেক্টার empty space দিয়ে ভরাট করে দিবে। অন্যদিকে ,

VARCHAR হচ্ছে একটি variable datatype যেখানে আপনি একটা নির্দিষ্ট length বলে দিবেন এর মধ্যে যদি ডাটা insert করার পর কোনো empty space থাকে না। তার যতটুকু space প্রয়োজন সে ততটুকুই নেয়। আপনি যদি কোনো কলাম কে VARCHAR(২০) বলে দেন তাহলে এর মানে হলে কলাম এর ক্যারেক্টার এর length ১ থেকে ২০ এর মধ্যে যেকোনো ক্যারেক্টার এর হতে পারে।

এখানে উল্লেখ্য যে CHAR এবং VARCHAR দুইটাই প্রত্যেক character ডাটা store করার জন্য ১ byte পরিমান স্পেস দখল করে তবে VARCHAR length এর information store করার জন্য আরো এক্সট্রা কিছু স্পেস দখল করে।

```sql
    CREATE TABLE persons (first_name CHAR(10),  last_name VARCHAR(20));
    --এখানে Jon ৩ character এর হওয়া সত্ত্বেও first_name পুরো 10 character নিবে
    --তবে last_name 20 character হওয়া সত্ত্বেও নিবে শুধুমাত্র 7 character
    INSERT INTO persons ('Jon', 'Stewart');
```
