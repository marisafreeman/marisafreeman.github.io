#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

#define SERVER_IP "127.0.0.1"
#define SERVER_PORT 8080
#define BUFFER_SIZE 1024

int main() {
    int sockfd;
    struct sockaddr_in server_addr;
    char buffer[BUFFER_SIZE];
    fd_set readfds;
    struct timeval timeout;

    // 创建套接字
    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        perror("Socket creation failed");
        exit(EXIT_FAILURE);
    }

    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(SERVER_PORT);

    if (inet_pton(AF_INET, SERVER_IP, &server_addr.sin_addr) <= 0) {
        perror("Invalid address");
        exit(EXIT_FAILURE);
    }

    // 连接到服务器
    if (connect(sockfd, (struct sockaddr *)&server_addr, sizeof(server_addr)) == -1) {
        perror("Connection failed");
        close(sockfd);
        exit(EXIT_FAILURE);
    }

    printf("Connected to the server. Type messages to send...\n");

    while (1) {
        // 设置超时和读取套接字
        FD_ZERO(&readfds);
        FD_SET(0, &readfds);  // 标准输入
        FD_SET(sockfd, &readfds);  // 套接字连接

        timeout.tv_sec = 1;  // 设置1秒超时
        timeout.tv_usec = 0;

        // 使用select来监听输入
        int activity = select(sockfd + 1, &readfds, NULL, NULL, &timeout);
        
        if (activity < 0) {
            perror("Select error");
            break;
        }

        // 如果标准输入有数据，发送消息
        if (FD_ISSET(0, &readfds)) {
            printf("You: ");
            fgets(buffer, sizeof(buffer), stdin);
            buffer[strcspn(buffer, "\n")] = 0;  // 去除换行符

            // 如果输入是 "exit"，退出客户端
            if (strcmp(buffer, "exit") == 0) {
                break;
            }

            // 发送消息到服务器
            send(sockfd, buffer, strlen(buffer), 0);
        }

        // 如果服务器有数据发送，接收并显示
        if (FD_ISSET(sockfd, &readfds)) {
            int bytes_received = recv(sockfd, buffer, sizeof(buffer) - 1, 0);
            if (bytes_received > 0) {
                buffer[bytes_received] = '\0';  // 确保字符串结束符
                printf("Server: %s\n", buffer);
            }
        }
    }

    close(sockfd);
    return 0;
}
