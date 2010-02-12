From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/6] virtio: console: Ensure no memleaks in case of unused
	buffers
Date: Fri, 12 Feb 2010 10:32:15 +0530
Message-ID: <1265950939-12359-3-git-send-email-amit.shah@redhat.com>
References: <1265950939-12359-1-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1265950939-12359-2-git-send-email-amit.shah@redhat.com>
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

If unused data exists in in_vq, ensure we flush that first and then
detach unused buffers, which will ensure all buffers from the in_vq are
removed.

Also ensure we free the buffers after detaching them.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a3f1f73..69d2e61 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -838,6 +838,8 @@ static const struct file_operations port_debugfs_ops = {
 /* Remove all port-specific data. */
 static int remove_port(struct port *port)
 {
+	struct port_buffer *buf;
+
 	spin_lock_irq(&port->portdev->ports_lock);
 	list_del(&port->list);
 	spin_unlock_irq(&port->portdev->ports_lock);
@@ -851,14 +853,17 @@ static int remove_port(struct port *port)
 	if (port->guest_connected)
 		send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
 
-	while (port->in_vq->vq_ops->detach_unused_buf(port->in_vq))
-		;
-
 	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
 	device_destroy(pdrvdata.class, port->dev->devt);
 	cdev_del(&port->cdev);
 
+	/* Remove unused data this port might have received. */
 	discard_port_data(port);
+
+	/* Remove buffers we queued up for the Host to send us data in. */
+	while ((buf = port->in_vq->vq_ops->detach_unused_buf(port->in_vq)))
+		free_buf(buf);
+
 	kfree(port->name);
 
 	debugfs_remove(port->debugfs_file);
-- 
1.6.2.5
