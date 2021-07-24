|  tasks             | 
| ----------------   | 
|  title:string      |  
|  user_id: integer  | 

|  users             | 
| ----------------   | 
|  -name:string      |  
|  -email:string     | 
|    -pw: ~~         | 

|  labels            | 
| ----------------   | 
|  -name:string      |     

|  labelings         |      
| ----------------   |
|  -task_id          |  
|  -label_id         | 

# Herokuへのデプロイ方法
`heroku create`
`rails assets:precompile RAILS_ENV=production`
Gemfileのruby '2.6.5'となっている行をコメントアウトする。
`git add -A`
`git commit -m "init"`
`git push heroku master`
`heroku buildpacks:set heroku/ruby`
`heroku buildpacks:add --index 1 heroku/nodejs`
下記のstep2の部分はブランチ名ごとに分ける
`git push heroku step2:master`

