From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH 6/8] virtio: console: Add freeze and restore handlers to
	support S4
Date: Thu, 28 Jul 2011 20:05:11 +0530
Message-ID: <e07039ebeb115501adaaa86081423eb5851cb7a0.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Remove all vqs and associated buffers in the freeze callback which
prepares us to go into hibernation state.  On restore, re-create all the
vqs and populate the input vqs with buffers to get to the pre-hibernate
state.

Note: Any outstanding unconsumed buffers are discarded; which means
there's a possibility of data loss in case the host or the guest didn't
consume any data already present in the vqs.  This can be addressed in a
later patch series, perhaps in virtio common code.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   71 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a7dfd02..9648cea 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -25,6 +25,7 @@
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/pm.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -1801,6 +1802,72 @@ static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
+#ifdef CONFIG_PM
+static int virtcons_freeze(struct virtio_device *vdev)
+{
+	struct ports_device *portdev;
+	struct port *port;
+	struct port_buffer *buf;
+	unsigned int len;
+
+	portdev = vdev->priv;
+
+	if (use_multiport(portdev)) {
+		while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
+			free_buf(buf);
+
+		while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
+			free_buf(buf);
+	}
+	list_for_each_entry(port, &portdev->ports, list) {
+		/*
+		 * We'll ask the host later if the new invocation has
+		 * the port opened or closed.
+		 */
+		port->host_connected = false;
+		discard_port_data(port);
+		reclaim_consumed_buffers(port);
+
+		while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
+			free_buf(buf);
+	}
+	portdev->vdev->config->del_vqs(portdev->vdev);
+	kfree(portdev->in_vqs);
+	kfree(portdev->out_vqs);
+
+	return 0;
+}
+
+static int virtcons_restore(struct virtio_device *vdev)
+{
+	struct ports_device *portdev;
+	struct port *port;
+	int ret;
+
+	portdev = vdev->priv;
+
+	ret = init_vqs(portdev);
+	if (ret)
+		return ret;
+
+	if (use_multiport(portdev)) {
+		fill_queue(portdev->c_ivq, &portdev->cvq_lock);
+	}
+
+	list_for_each_entry(port, &portdev->ports, list) {
+		port->in_vq = portdev->in_vqs[port->id];
+		port->out_vq = portdev->out_vqs[port->id];
+
+		fill_queue(port->in_vq, &port->inbuf_lock);
+
+		/* XXX: Should this be done in 'complete' instead of 'restore'? */
+		/* Get port open/close status on the host */
+		send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
+	}
+	return 0;
+}
+#endif
+
 static struct virtio_driver virtio_console = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
@@ -1810,6 +1877,10 @@ static struct virtio_driver virtio_console = {
 	.probe =	virtcons_probe,
 	.remove =	virtcons_remove,
 	.config_changed = config_intr,
+#ifdef CONFIG_PM
+	.freeze =	virtcons_freeze,
+	.restore =	virtcons_restore,
+#endif
 };
 
 static int __init init(void)
-- 
1.7.6
