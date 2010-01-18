From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 26/32] virtio: console: Add throttling support to prevent
	flooding ports
Date: Mon, 18 Jan 2010 19:15:20 +0530
Message-ID: <1263822326-24208-27-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-4-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-5-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-6-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-7-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-8-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-9-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-10-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-11-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-12-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-13-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-14-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-15-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-16-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-17-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-18-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-19-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-20-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-21-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-22-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-23-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-24-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-25-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-26-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-26-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rogue processes on guests could pump in data to hosts and cause an OOM
condition on the host. The host can indicate when to stop and start
sending data via control messages.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   21 ++++++++++++++++++++-
 include/linux/virtio_console.h |    1 +
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e76eacf..7154224 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -187,6 +187,9 @@ struct port {
 
 	/* We should allow only one process to open a port */
 	bool guest_connected;
+
+	/* Does the Host not want to accept more data currently?  */
+	bool host_throttled;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -517,6 +520,9 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 
 	port = filp->private_data;
 
+	if (port->host_throttled)
+		return -ENOSPC;
+
 	return send_buf(port, ubuf, count, true);
 }
 
@@ -531,7 +537,7 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
 	ret = 0;
 	if (port->inbuf)
 		ret |= POLLIN | POLLRDNORM;
-	if (port->host_connected)
+	if (port->host_connected && !port->host_throttled)
 		ret |= POLLOUT;
 	if (!port->host_connected)
 		ret |= POLLHUP;
@@ -842,6 +848,18 @@ static void handle_control_message(struct ports_device *portdev,
 				err);
 
 		break;
+	case VIRTIO_CONSOLE_THROTTLE_PORT:
+		/*
+		 * Hosts can govern some policy to disallow rogue
+		 * guest processes writing indefinitely to ports
+		 * leading to OOM situations.  If we receive this
+		 * message here, it means the Host side of the port
+		 * either reached its max. limit to cache data or
+		 * signal to us that the host is ready to accept more
+		 * data.
+		 */
+		port->host_throttled = cpkt->value;
+		break;
 	}
 }
 
@@ -944,6 +962,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->cons.hvc = NULL;
 
 	port->host_connected = port->guest_connected = false;
+	port->host_throttled = false;
 
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 13e56c8..c096eb2 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -41,6 +41,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_RESIZE		2
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
+#define VIRTIO_CONSOLE_THROTTLE_PORT	5
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
