From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 21/28] virtio: console: Ensure only one process can have a
	port open at a time
Date: Sat, 28 Nov 2009 12:20:44 +0530
Message-ID: <1259391051-7752-22-git-send-email-amit.shah@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-21-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 66875d6..3a305f8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -168,6 +168,9 @@ struct port {
 
 	/* Is the host device open */
 	bool host_connected;
+
+	/* We should allow only one process to open a port */
+	bool guest_connected;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -471,6 +474,8 @@ static int port_fops_release(struct inode *inode, struct file *filp)
 	/* Notify host of port being closed */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
 
+	port->guest_connected = false;
+
 	return 0;
 }
 
@@ -489,6 +494,15 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 	if (is_console_port(port))
 		return -ENXIO;
 
+	/* Allow only one process to open a particular port at a time */
+	spin_lock_irq(&port->readbuf_list_lock);
+	if (port->guest_connected) {
+		spin_unlock_irq(&port->readbuf_list_lock);
+		return -EMFILE;
+	}
+	port->guest_connected = true;
+	spin_unlock_irq(&port->readbuf_list_lock);
+
 	/* Notify host of port being opened */
 	send_control_msg(filp->private_data, VIRTIO_CONSOLE_PORT_OPEN, 1);
 
@@ -656,6 +670,7 @@ int init_port_console(struct port *port)
 	pdrvdata.next_vtermno++;
 	list_add_tail(&port->cons.list, &pdrvdata.consoles);
 	spin_unlock_irq(&pdrvdata_lock);
+	port->guest_connected = true;
 
 	return 0;
 }
-- 
1.6.2.5
