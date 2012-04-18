From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH] virtio_console: link vq to port with a private pointer in
	struct virtqueue
Date: Wed, 18 Apr 2012 15:33:33 +0200
Message-ID: <1334756013-11752-1-git-send-email-pbonzini@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

For virtio-scsi multiqueue support I would like to have an easy and
fast way to go from a virtqueue to the internal struct for that
queue.

It turns out that virtio-serial has the same need, but it gets
by with a simple list walk.

This patch adds a pointer to struct virtqueue that is reserved for
the virtio device, and uses it in virtio-serial.

Cc: Amit Shah <amit.shah@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	Untested; what do you think?  Would this patch be acceptable
	as is, or only with a more pressing need in virtio-scsi, or never?

 drivers/char/virtio_console.c |   16 +++++-----------
 include/linux/virtio.h        |    2 ++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1c74734..cfc7a63 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -297,17 +297,7 @@ out:
 static struct port *find_port_by_vq(struct ports_device *portdev,
 				    struct virtqueue *vq)
 {
-	struct port *port;
-	unsigned long flags;
-
-	spin_lock_irqsave(&portdev->ports_lock, flags);
-	list_for_each_entry(port, &portdev->ports, list)
-		if (port->in_vq == vq || port->out_vq == vq)
-			goto out;
-	port = NULL;
-out:
-	spin_unlock_irqrestore(&portdev->ports_lock, flags);
-	return port;
+	return vq->vdev_priv;
 }
 
 static bool is_console_port(struct port *port)
@@ -1159,6 +1149,8 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
+	port->in_vq->vdev_priv = port;
+	port->out_vq->vdev_priv = port;
 
 	port->cdev = cdev_alloc();
 	if (!port->cdev) {
@@ -1872,6 +1864,8 @@ static int virtcons_restore(struct virtio_device *vdev)
 	list_for_each_entry(port, &portdev->ports, list) {
 		port->in_vq = portdev->in_vqs[port->id];
 		port->out_vq = portdev->out_vqs[port->id];
+		port->in_vq->vdev_priv = port;
+		port->out_vq->vdev_priv = port;
 
 		fill_queue(port->in_vq, &port->inbuf_lock);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index c193ccf..6b39c1a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -14,6 +14,7 @@
  * @callback: the function to call when buffers are consumed (can be NULL).
  * @name: the name of this virtqueue (mainly for debugging)
  * @vdev: the virtio device this queue was created for.
+ * @vdev_priv: a pointer for the virtio device to use.
  * @priv: a pointer for the virtqueue implementation to use.
  */
 struct virtqueue {
@@ -21,6 +22,7 @@ struct virtqueue {
 	void (*callback)(struct virtqueue *vq);
 	const char *name;
 	struct virtio_device *vdev;
+	void *vdev_priv;
 	void *priv;
 };
 
-- 
1.7.9.3
