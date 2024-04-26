this is Script

echo "# script" >> README.md 
git init 
git add README.md 
git commit -m "第一次提交" 

# 设置全局用户名
git config --global user.name "AdminAce"

# 设置全局电子邮件地址
git config --global user.email "1048359499@qq.com"

# 查看远程仓库
git remote -v
#查看所有分支
git branch -a
#推送
git push -u origin master
git push origin master

gitbranch -M main 
git远程添加origin git@github.com:zengxiaobo1996/script.git
 git push -u origin主要的



 #添加秘钥

 ssh-keygen -t ed25519 -C "1048359499@qq.com"
 eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519  # 或者你的新 RSA 密钥的路径
