From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 3/4] virtio: console: Send SIGIO to processes that request it
	for host events
Date: Thu, 26 Aug 2010 10:34:07 +0530
Message-ID: <1b98d9f027ca6ce8ed114d5ceddc20d3d109c066.1282798831.git.amit.shah@redhat.com>
References: <cover.1282798831.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1282798831.git.amit.shah@redhat.com>
In-Reply-To: <cover.1282798831.git.amit.shah@redhat.com>
References: <cover.1282798831.git.amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a34f40e..b74d097 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -187,6 +187,9 @@ struct port {
 	/* The 'name' of the port that we expose via sysfs properties */
 	char *name;
 
+	/* We can notify apps of host connect / disconnect events via SIGIO */
+	struct fasync_struct *async_queue;
+
 	/* The 'id' to identify the port with the Host */
 	u32 id;
 
@@ -719,6 +722,14 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 	return 0;
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
@@ -732,6 +743,7 @@ static const struct file_operations port_fops = {
 	.write = port_fops_write,
 	.poll  = port_fops_poll,
 	.release = port_fops_release,
+	.fasync = port_fops_fasync,
 };
 
 /*
@@ -1011,6 +1023,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->name = NULL;
 	port->inbuf = NULL;
 	port->cons.hvc = NULL;
+	port->async_queue = NULL;
 
 	port->cons.ws.ws_row = port->cons.ws.ws_col = 0;
 
@@ -1234,6 +1247,13 @@ static void handle_control_message(struct ports_device *portdev,
 		spin_lock_irq(&port->outvq_lock);
 		reclaim_consumed_buffers(port);
 		spin_unlock_irq(&port->outvq_lock);
+
+		/*
+		 * If the guest is connected, it'll be interested in
+		 * knowing the host connection state changed.
+		 */
+		if (port->async_queue && port->guest_connected)
+			kill_fasync(&port->async_queue, SIGIO, POLL_OUT);
 		break;
 	case VIRTIO_CONSOLE_PORT_NAME:
 		/*
-- 
1.7.2.2
