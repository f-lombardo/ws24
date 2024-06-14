#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define MAX_USERNAME_SIZE 1024
#define MAX_PASSWORD_SIZE 256

// Function to calculate buffer size needed for username processing
uint32_t calculate_buffer_size(const char *username) {
    return strlen(username) * 2;
}

// Simulate processing the username
void process_username(char *buffer, uint32_t size) {
    // Here we just print the buffer contents to simulate some processing
    printf("Processing username: %.*s\n", size, buffer);
}

// Safe copy operation for password
void safe_copy_password(const char *src, char **dest, uint32_t size) {
    *dest = (char *)malloc(size + 1); // Ensure space for null terminator
    if (!(*dest)) {
        perror("Failed to allocate memory");
        exit(EXIT_FAILURE);
    }
    memcpy(*dest, src, size);
    (*dest)[size] = '\0'; // Ensure null termination
}

// Simulate processing the password
void process_password(char *buffer, uint32_t size) {
    // Here we just print the buffer contents to simulate some processing
    printf("Processing password: %.*s\n", size, buffer);
}

void handle_user_input(const char *username, const char *password) {
    // Step 1: Calculate the size for allocation
    uint32_t size = calculate_buffer_size(username);

    // Step 2: Calculate the total length to be allocated (vulnerable arithmetic)
    uint32_t len = size + 10;

    // Step 3: Allocate memory for the buffer
    char *buffer = (char *)malloc(len);
    if (!buffer) {
        perror("Failed to allocate memory");
        exit(EXIT_FAILURE);
    }

    // Step 4: Prepare some data to be copied
    char data[MAX_USERNAME_SIZE];
    strncpy(data, username, MAX_USERNAME_SIZE - 1);
    data[MAX_USERNAME_SIZE - 1] = '\0';  // Ensure null termination

    // Step 5: Vulnerable copy operation
    memcpy(buffer, data, size);

    // Step 6: Process the username
    process_username(buffer, size);

    // Step 7: Free the allocated memory
    free(buffer);

    // Safe copy operation for the password
    char *safe_password_buffer;
    safe_copy_password(password, &safe_password_buffer, strlen(password));

    // Process the password using the safe buffer
    process_password(safe_password_buffer, strlen(safe_password_buffer));

    // Free the safe password buffer
    free(safe_password_buffer);
}

int main() {
    // Simulate user input
    char username[MAX_USERNAME_SIZE];
    char password[MAX_PASSWORD_SIZE];
    
    printf("Enter your username: ");
    if (fgets(username, MAX_USERNAME_SIZE, stdin) == NULL) {
        perror("Failed to read username");
        exit(EXIT_FAILURE);
    }
    username[strcspn(username, "\n")] = '\0';

    printf("Enter your password: ");
    if (fgets(password, MAX_PASSWORD_SIZE, stdin) == NULL) {
        perror("Failed to read password");
        exit(EXIT_FAILURE);
    }
    password[strcspn(password, "\n")] = '\0';

    // Handle the user input
    handle_user_input(username, password);

    return 0;
}

