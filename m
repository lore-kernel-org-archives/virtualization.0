From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/2] virtio: console: Fix crash when hot-unplugging a port and
	read is blocked
Date: Thu, 27 May 2010 13:24:39 +0530
Message-ID: <712d1fa57175fb900ca6ebb133849497f4c2448b.1274946878.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

When removing a port we don't check if a program was blocked for read.
This leads to a crash when SIGTERM is sent to the program after
hot-unplugging the port.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8c99bf1..e3fb529 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1099,6 +1099,13 @@ static int remove_port(struct port *port)
 {
 	struct port_buffer *buf;
 
+	if (port->guest_connected) {
+		port->guest_connected = false;
+		port->host_connected = false;
+		wake_up_interruptible(&port->waitqueue);
+		send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
+	}
+
 	spin_lock_irq(&port->portdev->ports_lock);
 	list_del(&port->list);
 	spin_unlock_irq(&port->portdev->ports_lock);
@@ -1120,9 +1127,6 @@ static int remove_port(struct port *port)
 		hvc_remove(port->cons.hvc);
 #endif
 	}
-	if (port->guest_connected)
-		send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
-
 	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
 	device_destroy(pdrvdata.class, port->dev->devt);
 	cdev_del(&port->cdev);
-- 
1.7.0.1
