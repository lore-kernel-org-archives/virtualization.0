From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 27/31] virtio: console: Add throttling support to prevent
	flooding ports
Date: Tue, 22 Dec 2009 20:04:37 +0530
Message-ID: <1261492481-19817-28-git-send-email-amit.shah@redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-2-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-3-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-5-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-6-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-7-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-8-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-9-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-10-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-11-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-12-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-13-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-14-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-15-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-16-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-17-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-18-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-19-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-20-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-21-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-22-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-23-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-24-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-25-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-26-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-27-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-27-git-send-email-amit.shah@redhat.com>
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
index 4fefa4d..2409330 100644
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
@@ -540,6 +543,9 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 
 	port = filp->private_data;
 
+	if (port->host_throttled)
+		return -ENOSPC;
+
 	return send_buf(port, ubuf, count, true);
 }
 
@@ -554,7 +560,7 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
 	ret = 0;
 	if (port->inbuf)
 		ret |= POLLIN | POLLRDNORM;
-	if (port->host_connected)
+	if (port->host_connected && !port->host_throttled)
 		ret |= POLLOUT;
 	if (!port->host_connected)
 		ret |= POLLHUP;
@@ -861,6 +867,18 @@ static void handle_control_message(struct ports_device *portdev,
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
 
@@ -962,6 +980,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->cons.hvc = NULL;
 
 	port->host_connected = port->guest_connected = false;
+	port->host_throttled = false;
 
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 8e85045..4bd57c8 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -41,6 +41,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_RESIZE		2
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
+#define VIRTIO_CONSOLE_THROTTLE_PORT	5
 
 /*
  * This struct is put at the start of each data buffer that gets
-- 
1.6.2.5
