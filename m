From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 27/32] virtio: console: Remove cached data on port close
Date: Mon, 18 Jan 2010 19:15:21 +0530
Message-ID: <1263822326-24208-28-git-send-email-amit.shah@redhat.com>
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
	<1263822326-24208-27-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-27-git-send-email-amit.shah@redhat.com>
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

Remove any data that we might have in a port's inbuf when closing a port
or when any data is received when a port is closed.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7154224..0be5562 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -325,6 +325,31 @@ static int add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
 	return ret;
 }
 
+/* Discard any unread data this port has. Callers lockers. */
+static void discard_port_data(struct port *port)
+{
+	struct port_buffer *buf;
+	struct virtqueue *vq;
+	unsigned int len;
+
+	vq = port->in_vq;
+	if (port->inbuf)
+		buf = port->inbuf;
+	else
+		buf = vq->vq_ops->get_buf(vq, &len);
+
+	if (!buf)
+		return;
+
+	if (add_inbuf(vq, buf) < 0) {
+		buf->len = buf->offset = 0;
+		dev_warn(port->dev, "Error adding buffer back to vq\n");
+		return;
+	}
+
+	port->inbuf = NULL;
+}
+
 static bool port_has_data(struct port *port)
 {
 	unsigned long flags;
@@ -554,8 +579,13 @@ static int port_fops_release(struct inode *inode, struct file *filp)
 	/* Notify host of port being closed */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
 
+	spin_lock_irq(&port->inbuf_lock);
 	port->guest_connected = false;
 
+	discard_port_data(port);
+
+	spin_unlock_irq(&port->inbuf_lock);
+
 	return 0;
 }
 
@@ -904,6 +934,16 @@ static void in_intr(struct virtqueue *vq)
 	spin_lock_irqsave(&port->inbuf_lock, flags);
 	port->inbuf = get_inbuf(port);
 
+	/*
+	 * Don't queue up data when port is closed.  This condition
+	 * can be reached when a console port is not yet connected (no
+	 * tty is spawned) and the host sends out data to console
+	 * ports.  For generic serial ports, the host won't
+	 * (shouldn't) send data till the guest is connected.
+	 */
+	if (!port->guest_connected)
+		discard_port_data(port);
+
 	spin_unlock_irqrestore(&port->inbuf_lock, flags);
 
 	wake_up_interruptible(&port->waitqueue);
-- 
1.6.2.5
