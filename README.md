# shop_config_transfer

这个仓库主要提供一个文件中转的功能，使用luban配置的项目需要用到

# 用法1：导商店表
1.将luban导出目录Output下的Client/data/tbshop.json，复制到apps/项目名/ 目录下
2.提交到远程仓库
3.在钉钉的工具人小龙里面，选择商店导表，选择项目名，点击导出
4.通知服务器人员更新计费点

# 用法2：上传活动配置，因为活动配置要上传到s3，GM后台才能读取到，但是客户端人员普遍没有s3的操作权限，，所以这个步骤就放在了流水线里面去执行
1.将活动配置文件夹dataActivity，复制到apps/项目名 下面，没有项目目录，就新建一个
2.执行脚本：bash trigger_activity_upload.sh 项目名，等待钉钉通知