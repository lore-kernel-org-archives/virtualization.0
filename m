From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 24/32] virtio: console: Ensure only one process can have a
	port open at a time
Date: Mon, 18 Jan 2010 19:15:18 +0530
Message-ID: <1263822326-24208-25-git-send-email-amit.shah@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-24-git-send-email-amit.shah@redhat.com>
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

Add a guest_connected field that ensures only one process
can have a port open at a time.

This also ensures we don't have a race when we later add support for
dropping buffers when closing the char dev and buffer caching is turned
off for the particular port.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 30cdaf3..49cd185 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -181,6 +181,9 @@ struct port {
 
 	/* Is the host device open */
 	bool host_connected;
+
+	/* We should allow only one process to open a port */
+	bool guest_connected;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -542,6 +545,8 @@ static int port_fops_release(struct inode *inode, struct file *filp)
 	/* Notify host of port being closed */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
 
+	port->guest_connected = false;
+
 	return 0;
 }
 
@@ -560,6 +565,16 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 	if (is_console_port(port))
 		return -ENXIO;
 
+	/* Allow only one process to open a particular port at a time */
+	spin_lock_irq(&port->inbuf_lock);
+	if (port->guest_connected) {
+		spin_unlock_irq(&port->inbuf_lock);
+		return -EMFILE;
+	}
+
+	port->guest_connected = true;
+	spin_unlock_irq(&port->inbuf_lock);
+
 	/* Notify host of port being opened */
 	send_control_msg(filp->private_data, VIRTIO_CONSOLE_PORT_OPEN, 1);
 
@@ -723,6 +738,7 @@ int init_port_console(struct port *port)
 	pdrvdata.next_vtermno++;
 	list_add_tail(&port->cons.list, &pdrvdata.consoles);
 	spin_unlock_irq(&pdrvdata_lock);
+	port->guest_connected = true;
 
 	/* Notify host of port being opened */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 1);
@@ -870,7 +886,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->inbuf = NULL;
 	port->cons.hvc = NULL;
 
-	port->host_connected = false;
+	port->host_connected = port->guest_connected = false;
 
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
-- 
1.6.2.5
