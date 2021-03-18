# 如果blog丢失，需要从 user.github.io.git 恢复的话...
# get trans_md.py from http://www.aaronsw.com/2002/html2text/html2text.py

rm -f text_path
find 2020 -name index.html >> text_path
find 2021 -name index.html >> text_path # 找到所有的index
mkdir _posts # cwd 'shaorui0.github.io'
cd _posts
cat text_path | awk -F"/" '{print "mkdir "$4 }' | sh # 创建同名文件夹，用于存放 images
cat text_path | awk -F"/" '{print "python3 trans_md.py "$0 "> _posts/"$4".m"}' | sh # .m 为临时文件
ls *.m | awk -F"/" '{print "head -n -10 "$0 " > "$0"d"}' | sh # 删除尾部无效信息，还存在tag之类的信息需要转换
rm *.m # 删除临时信息
sed -i '1,11d' *.md # 删除开头无效信息


# 处理images
cd ..
rm -f images_path
# TODO 迭代处理图片格式（可能会漏掉其他格式）
find 2020 -name *png >> images_path
find 2021 -name *png >> images_path
find 2020 -name *jpeg >> images_path
find 2021 -name *jpeg >> images_path
find 2020 -name *jpg >> images_path
find 2021 -name *jpg >> images_path
cat images_path | awk -F"/" '{print "mv "$0 " ./_posts/"$4 }' | sh # 创建同名文件夹，用于存放 images

# TODO 文章还需要进一步处理，如果不需要tag信息，可以写个脚本删掉 ‘(/tags/’ 以后的信息。比如通过python逐行写入直至发现指定字符串