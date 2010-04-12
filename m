From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/6] virtio_console: use virtqueue_xxx wrappers
Date: Mon, 12 Apr 2010 16:18:32 +0300
Message-ID: <8a35c0803fbcbc3adcec7388d94ef0487f9f1df5.1271078235.git.mst@redhat.com>
References: <cover.1271078235.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1271078235.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Switch virtio_console to new virtqueue_xxx wrappers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 196428c..48ce834 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -328,7 +328,7 @@ static void *get_inbuf(struct port *port)
 	unsigned int len;
 
 	vq = port->in_vq;
-	buf = vq->vq_ops->get_buf(vq, &len);
+	buf = virtqueue_get_buf(vq, &len);
 	if (buf) {
 		buf->len = len;
 		buf->offset = 0;
@@ -349,8 +349,8 @@ static int add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
 
 	sg_init_one(sg, buf->buf, buf->size);
 
-	ret = vq->vq_ops->add_buf(vq, sg, 0, 1, buf);
-	vq->vq_ops->kick(vq);
+	ret = virtqueue_add_buf(vq, sg, 0, 1, buf);
+	virtqueue_kick(vq);
 	return ret;
 }
 
@@ -366,7 +366,7 @@ static void discard_port_data(struct port *port)
 	if (port->inbuf)
 		buf = port->inbuf;
 	else
-		buf = vq->vq_ops->get_buf(vq, &len);
+		buf = virtqueue_get_buf(vq, &len);
 
 	ret = 0;
 	while (buf) {
@@ -374,7 +374,7 @@ static void discard_port_data(struct port *port)
 			ret++;
 			free_buf(buf);
 		}
-		buf = vq->vq_ops->get_buf(vq, &len);
+		buf = virtqueue_get_buf(vq, &len);
 	}
 	port->inbuf = NULL;
 	if (ret)
@@ -421,9 +421,9 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	vq = port->portdev->c_ovq;
 
 	sg_init_one(sg, &cpkt, sizeof(cpkt));
-	if (vq->vq_ops->add_buf(vq, sg, 1, 0, &cpkt) >= 0) {
-		vq->vq_ops->kick(vq);
-		while (!vq->vq_ops->get_buf(vq, &len))
+	if (virtqueue_add_buf(vq, sg, 1, 0, &cpkt) >= 0) {
+		virtqueue_kick(vq);
+		while (!virtqueue_get_buf(vq, &len))
 			cpu_relax();
 	}
 	return 0;
@@ -439,10 +439,10 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
 	out_vq = port->out_vq;
 
 	sg_init_one(sg, in_buf, in_count);
-	ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, in_buf);
+	ret = virtqueue_add_buf(out_vq, sg, 1, 0, in_buf);
 
 	/* Tell Host to go! */
-	out_vq->vq_ops->kick(out_vq);
+	virtqueue_kick(out_vq);
 
 	if (ret < 0) {
 		in_count = 0;
@@ -450,7 +450,7 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
 	}
 
 	/* Wait till the host acknowledges it pushed out the data we sent. */
-	while (!out_vq->vq_ops->get_buf(out_vq, &len))
+	while (!virtqueue_get_buf(out_vq, &len))
 		cpu_relax();
 fail:
 	/* We're expected to return the amount of data we wrote */
@@ -901,7 +901,7 @@ static int remove_port(struct port *port)
 	discard_port_data(port);
 
 	/* Remove buffers we queued up for the Host to send us data in. */
-	while ((buf = port->in_vq->vq_ops->detach_unused_buf(port->in_vq)))
+	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
 		free_buf(buf);
 
 	kfree(port->name);
@@ -1030,7 +1030,7 @@ static void control_work_handler(struct work_struct *work)
 	vq = portdev->c_ivq;
 
 	spin_lock(&portdev->cvq_lock);
-	while ((buf = vq->vq_ops->get_buf(vq, &len))) {
+	while ((buf = virtqueue_get_buf(vq, &len))) {
 		spin_unlock(&portdev->cvq_lock);
 
 		buf->len = len;
@@ -1224,7 +1224,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	return 0;
 
 free_inbufs:
-	while ((buf = port->in_vq->vq_ops->detach_unused_buf(port->in_vq)))
+	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
 		free_buf(buf);
 free_device:
 	device_destroy(pdrvdata.class, port->dev->devt);
@@ -1536,10 +1536,10 @@ static void virtcons_remove(struct virtio_device *vdev)
 
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 
-	while ((buf = portdev->c_ivq->vq_ops->get_buf(portdev->c_ivq, &len)))
+	while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
 		free_buf(buf);
 
-	while ((buf = portdev->c_ivq->vq_ops->detach_unused_buf(portdev->c_ivq)))
+	while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
 		free_buf(buf);
 
 	vdev->config->del_vqs(vdev);
-- 
1.7.0.2.280.gc6f05
