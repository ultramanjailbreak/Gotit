#include <stdint.h>
#include <stddef.h>

// Tell the compiler these functions exist inside the PS4 SDK environment
void initKernel(void);
void initLibc(void);

// Exact PS4 OS structure for a notification request (Size must be exactly 0xC30 bytes)
typedef struct {
    int32_t type;                 // 0 = Standard popup notification
    int32_t req_id;               // Request identification number
    int32_t priority;             // Priority level inside the UI manager
    int32_t unk3;                 // System reserved property (Always set to 0)
    int32_t target_id;            // Target User ID (-1 broadcasts to the active user)
    int32_t use_icon_image_uri;   // Flag to determine if an icon path is used (1 = true)
    char message[1024];           // Buffer text array for the notification body string
    char uri[1024];               // Buffer path array pointing to the icon resource layout
    char unk_block[1056];         // Critical layout padding to hit the strict 3120-byte footprint
} SceNotificationRequest;

// Native kernel function pointer declaration used to talk to /dev/notification
int sceKernelSendNotificationRequest(int device, SceNotificationRequest *req, size_t size, int blocking);

// Custom helper function that configures the layout options and fires the request
void send_custom_popup(const char* msg_text) {
    SceNotificationRequest noti_buffer;
    
    // Safely zero out the entire memory structure to prevent garbage data crashes
    for(size_t i = 0; i < sizeof(noti_buffer); i++) {
        ((char*)&noti_buffer)[i] = 0;
    }

    // Assign required OS structural flags
    noti_buffer.type = 0;
    noti_buffer.unk3 = 0;
    noti_buffer.use_icon_image_uri = 1;
    noti_buffer.target_id = -1; 

    // Point to the built-in system notification graphic asset texture
    const char* default_icon = "cxml://psnotification/tex_icon_system";
    
    // Copy the default icon path string into the URI buffer
    int i = 0;
    while (default_icon[i] != '\0' && i < 1023) {
        noti_buffer.uri[i] = default_icon[i];
        i++;
    }
    noti_buffer.uri[i] = '\0';

    // Copy your custom message string into the notification message buffer [OSM-Made/PS4-Notify]
    int j = 0;
    while (msg_text[j] != '\0' && j < 1023) {
        noti_buffer.message[j] = msg_text[j];
        j++;
    }
    noti_buffer.message[j] = '\0';

    // Call the core function to broadcast the struct package straight to the UI sub-system
    sceKernelSendNotificationRequest(0, &noti_buffer, sizeof(noti_buffer), 0);
}

// The core entry point called when the payload binary runs on your console
int _main(void) {
    // Connect to the console base system calls
    initKernel();
    initLibc();

    // Trigger your popup instantly upon execution. Edit the text inside the quotes below!
    send_custom_popup("Success! Payload has been compiled and executed online.");

    return 0;
}
