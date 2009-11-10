From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 11/15] virtio_console: Ensure only one process can have a port
	open at a time
Date: Tue, 10 Nov 2009 15:11:37 +0530
Message-ID: <1257846101-23258-12-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-4-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-5-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-6-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-7-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-8-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-9-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-10-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-11-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-11-git-send-email-amit.shah@redhat.com>
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

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c3498ec..8c9bac8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -138,6 +138,9 @@ struct virtio_console_port {
 
 	/* Is the host device open */
 	bool host_connected;
+
+	/* We should allow only one process to open a port */
+	bool guest_connected;
 };
 
 struct virtio_console_struct virtconsole;
@@ -455,6 +458,10 @@ static int virtconsole_release(struct inode *inode, struct file *filp)
 	send_buf(filp->private_data, (char *)&cpkt, sizeof(cpkt),
 		 VIRTIO_CONSOLE_ID_CONTROL, false);
 
+	spin_lock(&port->readbuf_list_lock);
+	port->guest_connected = false;
+	spin_unlock(&port->readbuf_list_lock);
+
 	return 0;
 }
 
@@ -474,6 +481,15 @@ static int virtconsole_open(struct inode *inode, struct file *filp)
 	if (port->hvc)
 		return -ENXIO;
 
+	/* Allow only one process to open a particular port at a time */
+	spin_lock(&port->readbuf_list_lock);
+	if (port->guest_connected) {
+		spin_unlock(&port->readbuf_list_lock);
+		return -EMFILE;
+	}
+	port->guest_connected = true;
+	spin_unlock(&port->readbuf_list_lock);
+
 	/* Notify host of port being opened */
 	cpkt.event = VIRTIO_CONSOLE_PORT_OPEN;
 	cpkt.value = 1;
@@ -639,6 +655,7 @@ int init_port_console(struct virtio_console_port *port)
 		port->hvc = NULL;
 	} else {
 		port->vtermno = port->vcon->hvc_vtermno++;
+		port->guest_connected = true;
 	}
 	return ret;
 }
-- 
1.6.2.5
