1.
請說明 rails g scaffold xxx 功能的壞處為何？
Ans:
scaffold 快速建立鷹架因為太過方便
在細處無法一步一步手動實際建立
不容易全盤了解所有細節跟流程與相呼應的檔案和語法

2.
若今天需要為 Project 和 Issue 這兩個 Model 建立一對多的關係，
請寫出實作上所需要的 migratiion 和 model 檔案

Ans:
model:
class Project < ActiveRecord::Base
  has_many :issues
end
 
class Issue < ActiveRecord::Base
  belongs_to :project
end

migration:
class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.timestamps
    end
 
    create_table :issues do |t|
      t.string :name
      t.timestamps 
    end
  end
end


3.
若今天我有以下 model 檔：

class User < ActiveRecord::Base
  has_many :groups_users
  has_many :groups, through: :groups_users 
end
請寫出和這個 model 檔相關連的 model 檔，
以及這些 model 檔所需要的資料庫欄位
Ans:
model:
 
class Groups_users < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end

class Group < ActiveRecord::Base
  has_many :groups_users
  has_many :users, through: :groups_users
end

migration:
class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.timestamps
    end
 
    create_table :users do |t|
      t.string :name
      t.timestamps 
    end
 
    create_table :group_users do |t|
      t.belongs_to :user
      t.belongs_to :group
      
      t.timestamps 
    end
  end
end
 
4.
延續第3題，如果需要讓一個叫 "Bob" 的使用者產生一個名字叫做
 "Rails is Fun" 的社團，
應該如何在 rails console 裡實作出來？
Ans:
不太確定
  User.create('Bob')
  Group.create('Rails is Fun')

5.
延續第4題，請寫一段程式碼確保使用者在建立新社團時社團名字不可以是空白，而且不能超過50個字
Ans:

class Group < ActiveRecord::Base
validates :title, presence: true, length:{maxinum: 50}
end

6.
請列出兩種方法檢查在 routes.rb 裡面設定的路由
Ans:
1.在終端機(Rails console)輸入rake routes
2.在browser輸入localhost:3000/rails/info/routes

7.
請列出在一個 rails 專案裡使用 bootstrap 套件的步驟
Ans:
-安裝 gem 
先使用ruby 函式庫 (gem) 將 Bootstrap 裝進專案裡
在專案裡的gemfile 中加上一行：
gem 'bootstrap-sass'
存檔

-下指令：bundle install

-把 		app/assets/stylesheets/application.css 
更名為 	app/assets/stylesheets/application.scss

-app/assets/stylesheets/application.scss內
最下方加上
@import "bootstrap";
存檔 

-在app/assets/javascripts/application.js內 
最後一行//= require_tree 之前 加上
//= require bootstrap

存檔 並重開 rails s


8.
請說明在 .erb 檔案裡 <%= %> 與 <% %> 這兩種 tag 的差別
Ans:
ERB 的全名是 Embedded Ruby。
View資料夾內的資料 會產生 HTML 來顯示在瀏覽器,
而View資料夾內是 .erb檔案，是一種樣板語言（Template Language），
裡面是 HTML 加上內嵌的 Ruby 程式碼。
View 裡面的 Ruby 的變數即是當使用者要瀏覽該頁面的時候，所要填入的內容。
寫註解時格式為： <%# 註解內容 %>

<%= %>會執行，並顯示或輸出中間的Ruby程式執行結果

<% %>則只執行 Ruby code 但不輸出結果，通常用在if或迴圈條件中。

以下面程式舉例：

<% if errors %>                 <%# 如果出現錯誤，條件 不顯示 %>
    <ul style="color: red">
    <% errors.each do |error| %>
        <li><%= error %></li>   <%# 會出現"錯誤"字樣，會顯示 %>
    <% end %>
    </ul>
<% end %>
