From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 23/28] virtio: console: Add throttling support to prevent
	flooding ports
Date: Sat, 28 Nov 2009 12:20:46 +0530
Message-ID: <1259391051-7752-24-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-10-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-11-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-12-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-13-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-14-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-15-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-16-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-17-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-18-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-19-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-20-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-21-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-22-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-23-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-23-git-send-email-amit.shah@redhat.com>
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

Rogue processes on guests or hosts could pump in data
and cause an OOM condition. Add support for throttling
so that a limit to the number of outstanding buffers
can be specified.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   78 ++++++++++++++++++++++++++++++++++++++-
 include/linux/virtio_console.h |    2 +
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d0bdc18..fe8f14f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -169,11 +169,32 @@ struct port {
 	/* The 'id' to identify the port with the Host */
 	u32 id;
 
+	/*
+	 * The Host can set some limit to the number of outstanding
+	 * buffers we can have in the readbuf_head list before we
+	 * should ask the Host to stop any more data from coming in.
+	 * This is to not allow a rogue process on the Host to OOM the
+	 * entire guest.
+	 */
+	u32 buffer_limit;
+
+	/*
+	 * The actual number of buffers we have pending in the
+	 * readbuf_head list
+	 */
+	u32 nr_buffers;
+
 	/* Is the host device open */
 	bool host_connected;
 
 	/* We should allow only one process to open a port */
 	bool guest_connected;
+
+	/* Does the Host not want to accept more data currently?  */
+	bool host_throttled;
+
+	/* Have we sent out a throttle request to the Host? */
+	bool guest_throttled;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -383,6 +404,7 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 		if (buf->len - buf->offset == 0) {
 			spin_lock_irqsave(&port->readbuf_list_lock, flags);
 			list_del(&buf->list);
+			port->nr_buffers--;
 			spin_unlock_irqrestore(&port->readbuf_list_lock, flags);
 			kfree(buf->buf);
 			kfree(buf);
@@ -390,6 +412,10 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 		if (!out_count)
 			break;
 	}
+	if (port->guest_throttled && port->nr_buffers < port->buffer_limit) {
+		send_control_msg(port, VIRTIO_CONSOLE_THROTTLE_PORT, 0);
+		port->guest_throttled = false;
+	}
 	return out_offset;
 }
 
@@ -446,6 +472,9 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 
 	port = filp->private_data;
 
+	if (port->host_throttled)
+		return -ENOSPC;
+
 	return send_buf(port, ubuf, count, 0, true);
 }
 
@@ -460,7 +489,7 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
 	ret = 0;
 	if (!list_empty(&port->readbuf_head))
 		ret |= POLLIN | POLLRDNORM;
-	if (port->host_connected)
+	if (port->host_connected && !port->host_throttled)
 		ret |= POLLOUT;
 	if (!port->host_connected)
 		ret |= POLLHUP;
@@ -811,6 +840,35 @@ static void handle_control_message(struct port *port, struct port_buffer *buf)
 				err);
 
 		break;
+	case VIRTIO_CONSOLE_THROTTLE_PORT:
+		/*
+		 * Hosts can govern some policy to disallow rogue
+		 * processes write indefinitely to ports leading to
+		 * OOM situations.  If we receive this message here,
+		 * it means the Host side of the port either reached
+		 * its max. limit to cache data or signal to us that
+		 * the host is ready to accept more data.
+		 */
+		port->host_throttled = cpkt->value;
+		break;
+	case VIRTIO_CONSOLE_BUFFER_LIMIT:
+		/*
+		 * We can ask the Host to stop sending data to us in
+		 * case some rogue process on the Host injects data to
+		 * OOM the entire guest (as unread buffers keep piling
+		 * up in the kernel space). The Host, via this
+		 * message, can tell us the number of Mbytes to
+		 * buffer.
+		 *
+		 * The calculation is easy: we use 4K-sized pages in
+		 * our readbuf_head list. So on each buffer added to
+		 * the list, increment count by 1 (and decrement by 1
+		 * when one gets removed). So we just store the
+		 * (number-in-MB * 1024) / 4 to calculate the number of
+		 * buffers we can have in the list.
+		 */
+		port->buffer_limit = (u32)cpkt->value * 1024 / 4;
+		break;
 	}
 }
 
@@ -881,10 +939,24 @@ static void rx_work_handler(struct work_struct *work)
 		 */
 		port->host_connected = true;
 
+		if (port->guest_throttled) {
+			kfree(buf->buf);
+			kfree(buf);
+			continue;
+		}
 		spin_lock_irq(&port->readbuf_list_lock);
 		list_add_tail(&buf->list, &port->readbuf_head);
+		port->nr_buffers++;
 		spin_unlock_irq(&port->readbuf_list_lock);
-
+		/*
+		 * If we reached the throttle level, send out a
+		 * message to the host to ask it to stop sending us
+		 * any more data.
+		 */
+		if (port->nr_buffers >= port->buffer_limit) {
+			send_control_msg(port, VIRTIO_CONSOLE_THROTTLE_PORT, 1);
+			port->guest_throttled = true;
+		}
 		wake_up_interruptible(&port->waitqueue);
 
 		if (is_console_port(port))
@@ -974,6 +1046,8 @@ static int __devinit add_port(struct ports_device *portdev, u32 id)
 	port->portdev = portdev;
 	port->id = id;
 
+	port->buffer_limit = ~(u32)0;
+
 	cdev_init(&port->cdev, &port_fops);
 
 	devt = MKDEV(portdev->chr_major, id);
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index d65fdb5..2aa2b42 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -38,6 +38,8 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_RESIZE		2
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
+#define VIRTIO_CONSOLE_THROTTLE_PORT	5
+#define VIRTIO_CONSOLE_BUFFER_LIMIT	6
 
 /*
  * This struct is put at the start of each buffer that gets passed to
-- 
1.6.2.5
