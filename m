From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/2] virtio: console: Use better variable names for fill_queue
	operation
Date: Mon,  8 Mar 2010 14:17:00 +0530
Message-ID: <1268038020-12539-3-git-send-email-amit.shah@redhat.com>
References: <1268038020-12539-1-git-send-email-amit.shah@redhat.com>
	<1268038020-12539-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1268038020-12539-2-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@linux-foundation.org, quintela@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

We want to keep track of the number of buffers added to a vq. Use
nr_added_bufs instead of 'ret'.

Also, the users of fill_queue() overloaded a local 'err' variable to
check the numbers of buffers allocated. Use nr_added_bufs instead of
err.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Reported-by: Juan Quintela <quintela@redhat.com>
---
 drivers/char/virtio_console.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2bd6a9c..f404ccf 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1071,27 +1071,27 @@ static void config_intr(struct virtio_device *vdev)
 static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
 {
 	struct port_buffer *buf;
-	unsigned int ret;
-	int err;
+	unsigned int nr_added_bufs;
+	int ret;
 
-	ret = 0;
+	nr_added_bufs = 0;
 	do {
 		buf = alloc_buf(PAGE_SIZE);
 		if (!buf)
 			break;
 
 		spin_lock_irq(lock);
-		err = add_inbuf(vq, buf);
-		if (err < 0) {
+		ret = add_inbuf(vq, buf);
+		if (ret < 0) {
 			spin_unlock_irq(lock);
 			free_buf(buf);
 			break;
 		}
-		ret++;
+		nr_added_bufs++;
 		spin_unlock_irq(lock);
-	} while (err > 0);
+	} while (ret > 0);
 
-	return ret;
+	return nr_added_bufs;
 }
 
 static int add_port(struct ports_device *portdev, u32 id)
@@ -1100,6 +1100,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	struct port *port;
 	struct port_buffer *buf;
 	dev_t devt;
+	unsigned int nr_added_bufs;
 	int err;
 
 	port = kmalloc(sizeof(*port), GFP_KERNEL);
@@ -1144,8 +1145,8 @@ static int add_port(struct ports_device *portdev, u32 id)
 	init_waitqueue_head(&port->waitqueue);
 
 	/* Fill the in_vq with buffers so the host can send us data. */
-	err = fill_queue(port->in_vq, &port->inbuf_lock);
-	if (!err) {
+	nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
+	if (!nr_added_bufs) {
 		dev_err(port->dev, "Error allocating inbufs\n");
 		err = -ENOMEM;
 		goto free_device;
@@ -1442,12 +1443,14 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	INIT_LIST_HEAD(&portdev->ports);
 
 	if (multiport) {
+		unsigned int nr_added_bufs;
+
 		spin_lock_init(&portdev->cvq_lock);
 		INIT_WORK(&portdev->control_work, &control_work_handler);
 		INIT_WORK(&portdev->config_work, &config_work_handler);
 
-		err = fill_queue(portdev->c_ivq, &portdev->cvq_lock);
-		if (!err) {
+		nr_added_bufs = fill_queue(portdev->c_ivq, &portdev->cvq_lock);
+		if (!nr_added_bufs) {
 			dev_err(&vdev->dev,
 				"Error allocating buffers for control queue\n");
 			err = -ENOMEM;
-- 
1.6.2.5
