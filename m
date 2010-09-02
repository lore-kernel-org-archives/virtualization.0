From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/3] virtio: console: Send SIGIO to processes that request it
	for host events
Date: Thu,  2 Sep 2010 18:47:52 +0530
Message-ID: <f4db5a44ed5f70930968f99b1da6c05b13b44e20.1283433264.git.amit.shah@redhat.com>
References: <cover.1283433264.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283433264.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283433264.git.amit.shah@redhat.com>
References: <cover.1283433264.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

A process can request for SIGIO on host connect / disconnect events
using the O_ASYNC file flag using fcntl().

If that's requested, and if the guest-side connection for the port is
open, any host-side open/close events for that port will raise a SIGIO.
The process can then use poll() within the signal handler to find out
which port triggered the signal.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 793817b..afbbc54 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -196,6 +196,9 @@ struct port {
 	/* The 'name' of the port that we expose via sysfs properties */
 	char *name;
 
+	/* We can notify apps of host connect / disconnect events via SIGIO */
+	struct fasync_struct *async_queue;
+
 	/* The 'id' to identify the port with the Host */
 	u32 id;
 
@@ -800,6 +803,14 @@ out:
 	return ret;
 }
 
+static int port_fops_fasync(int fd, struct file *filp, int mode)
+{
+	struct port *port;
+
+	port = filp->private_data;
+	return fasync_helper(fd, filp, mode, &port->async_queue);
+}
+
 /*
  * The file operations that we support: programs in the guest can open
  * a console device, read from it, write to it, poll for data and
@@ -813,6 +824,7 @@ static const struct file_operations port_fops = {
 	.write = port_fops_write,
 	.poll  = port_fops_poll,
 	.release = port_fops_release,
+	.fasync = port_fops_fasync,
 };
 
 /*
@@ -1071,6 +1083,12 @@ static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
 	return nr_added_bufs;
 }
 
+static void send_sigio_to_port(struct port *port)
+{
+	if (port->async_queue && port->guest_connected)
+		kill_fasync(&port->async_queue, SIGIO, POLL_OUT);
+}
+
 static int add_port(struct ports_device *portdev, u32 id)
 {
 	char debugfs_name[16];
@@ -1093,6 +1111,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->name = NULL;
 	port->inbuf = NULL;
 	port->cons.hvc = NULL;
+	port->async_queue = NULL;
 
 	port->cons.ws.ws_row = port->cons.ws.ws_col = 0;
 
@@ -1347,6 +1366,12 @@ static void handle_control_message(struct ports_device *portdev,
 		spin_lock_irq(&port->outvq_lock);
 		reclaim_consumed_buffers(port);
 		spin_unlock_irq(&port->outvq_lock);
+
+		/*
+		 * If the guest is connected, it'll be interested in
+		 * knowing the host connection state changed.
+		 */
+		send_sigio_to_port(port);
 		break;
 	case VIRTIO_CONSOLE_PORT_NAME:
 		/*
-- 
1.7.2.2
