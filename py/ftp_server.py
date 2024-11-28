import os
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer

# 修改为你想要的共享目录路径
root_directory = 'C:\\Users\\Administrator\\Desktop\\ftp_directory'

# 如果目录不存在，则创建它
if not os.path.exists(root_directory):
    os.makedirs(root_directory)

# 创建授权器对象，负责认证
authorizer = DummyAuthorizer()

# 设置匿名访问目录权限
authorizer.add_anonymous(root_directory, perm='elradfmw')  # 权限：e = 查看目录，l = 查看目录列表，r = 读取文件，a = 添加文件，d = 删除文件，f = 改名文件，m = 创建目录，w = 写入文件

# 创建 FTP 处理器
handler = FTPHandler
handler.authorizer = authorizer

# 配置 FTP 服务器地址与端口（例如 2121）
server = FTPServer(('0.0.0.0', 2121), handler)

# 启动 FTP 服务器
print("Starting FTP server on port 2121...")
server.serve_forever()
