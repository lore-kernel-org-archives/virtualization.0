From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 09/14] virtio: console: open: Use a common path for error
	handling
Date: Thu,  2 Sep 2010 18:11:48 +0530
Message-ID: <19bc55e93639c45bb01334be698692903b71975d.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
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

Just re-arrange code for future patches.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 0c4ee9b1..d689c76 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -696,6 +696,7 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 {
 	struct cdev *cdev = inode->i_cdev;
 	struct port *port;
+	int ret;
 
 	port = container_of(cdev, struct port, cdev);
 	filp->private_data = port;
@@ -704,14 +705,17 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 	 * Don't allow opening of console port devices -- that's done
 	 * via /dev/hvc
 	 */
-	if (is_console_port(port))
-		return -ENXIO;
+	if (is_console_port(port)) {
+		ret = -ENXIO;
+		goto out;
+	}
 
 	/* Allow only one process to open a particular port at a time */
 	spin_lock_irq(&port->inbuf_lock);
 	if (port->guest_connected) {
 		spin_unlock_irq(&port->inbuf_lock);
-		return -EMFILE;
+		ret = -EMFILE;
+		goto out;
 	}
 
 	port->guest_connected = true;
@@ -730,6 +734,8 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 	send_control_msg(filp->private_data, VIRTIO_CONSOLE_PORT_OPEN, 1);
 
 	return 0;
+out:
+	return ret;
 }
 
 /*
-- 
1.7.2.2
