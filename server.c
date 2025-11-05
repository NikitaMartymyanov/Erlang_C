#include <zmq.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <assert.h>

int main (void)
{
    //  Socket to talk to clients
    void *context = zmq_ctx_new ();
    void *publisher = zmq_socket (context, ZMQ_PUB);
    int response = zmq_bind (publisher, "ipc:///tmp/msg");
    assert (response == 0); // Check if the response code indicates success

    for(;;) {
        zmq_msg_t message;
        zmq_msg_init_size(&message, 7);
        char *update = "world";
        memcpy(zmq_msg_data(&message), update, 7);
        zmq_msg_send(&message, publisher, 0);
        zmq_msg_close(&message);
    }
    zmq_close(publisher);
    zmq_ctx_destroy(context);
    return 0;
}