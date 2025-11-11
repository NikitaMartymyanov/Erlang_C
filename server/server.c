#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>
#define MAX 50
int main (void)
{
    //  Socket to talk to clients
    void *context = zmq_ctx_new ();
    void *publisher = zmq_socket (context, ZMQ_PUB);
    int response = zmq_bind (publisher, "tcp://*:5555");
    assert (response == 0); // Check if the response code indicates success

    for(;;) {
        printf("Введите сообщение: ");
        char value[MAX];
        fgets(value, MAX, stdin);
        int size = strlen(value);
        zmq_msg_t message;
        zmq_msg_init_size(&message, size);
        memcpy(zmq_msg_data(&message), value, size);
        zmq_msg_send(&message, publisher, 0);
        zmq_msg_close(&message);
    }
    zmq_close(publisher);
    zmq_ctx_destroy(context);
    return 0;
}