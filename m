From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 17/32] virtio: console: Separate out find_vqs operation into a
	different function
Date: Mon, 18 Jan 2010 19:15:11 +0530
Message-ID: <1263822326-24208-18-git-send-email-amit.shah@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-17-git-send-email-amit.shah@redhat.com>
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

With support for multiple ports, each port will have its own input and
output vqs. Prepare the probe function for this change.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   98 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 11e5faf..75c5a35 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -74,7 +74,9 @@ struct console {
  * ports for that device (vdev->priv).
  */
 struct ports_device {
-	struct virtqueue *in_vq, *out_vq;
+	/* Array of per-port IO virtqueues */
+	struct virtqueue **in_vqs, **out_vqs;
+
 	struct virtio_device *vdev;
 };
 
@@ -395,8 +397,8 @@ static int __devinit add_port(struct ports_device *portdev)
 	}
 
 	port->portdev = portdev;
-	port->in_vq = portdev->in_vq;
-	port->out_vq = portdev->out_vq;
+	port->in_vq = portdev->in_vqs[0];
+	port->out_vq = portdev->out_vqs[0];
 
 	port->inbuf = alloc_buf(PAGE_SIZE);
 	if (!port->inbuf) {
@@ -421,15 +423,87 @@ fail:
 	return err;
 }
 
+static int init_vqs(struct ports_device *portdev)
+{
+	vq_callback_t **io_callbacks;
+	char **io_names;
+	struct virtqueue **vqs;
+	u32 nr_ports, nr_queues;
+	int err;
+
+	/* We currently only have one port and two queues for that port */
+	nr_ports = 1;
+	nr_queues = 2;
+
+	vqs = kmalloc(nr_queues * sizeof(struct virtqueue *), GFP_KERNEL);
+	if (!vqs) {
+		err = -ENOMEM;
+		goto fail;
+	}
+	io_callbacks = kmalloc(nr_queues * sizeof(vq_callback_t *), GFP_KERNEL);
+	if (!io_callbacks) {
+		err = -ENOMEM;
+		goto free_vqs;
+	}
+	io_names = kmalloc(nr_queues * sizeof(char *), GFP_KERNEL);
+	if (!io_names) {
+		err = -ENOMEM;
+		goto free_callbacks;
+	}
+	portdev->in_vqs = kmalloc(nr_ports * sizeof(struct virtqueue *),
+				  GFP_KERNEL);
+	if (!portdev->in_vqs) {
+		err = -ENOMEM;
+		goto free_names;
+	}
+	portdev->out_vqs = kmalloc(nr_ports * sizeof(struct virtqueue *),
+				   GFP_KERNEL);
+	if (!portdev->out_vqs) {
+		err = -ENOMEM;
+		goto free_invqs;
+	}
+
+	io_callbacks[0] = hvc_handle_input;
+	io_callbacks[1] = NULL;
+	io_names[0] = "input";
+	io_names[1] = "output";
+
+	/* Find the queues. */
+	err = portdev->vdev->config->find_vqs(portdev->vdev, nr_queues, vqs,
+					      io_callbacks,
+					      (const char **)io_names);
+	if (err)
+		goto free_outvqs;
+
+	portdev->in_vqs[0] = vqs[0];
+	portdev->out_vqs[0] = vqs[1];
+
+	kfree(io_callbacks);
+	kfree(io_names);
+	kfree(vqs);
+
+	return 0;
+
+free_names:
+	kfree(io_names);
+free_callbacks:
+	kfree(io_callbacks);
+free_outvqs:
+	kfree(portdev->out_vqs);
+free_invqs:
+	kfree(portdev->in_vqs);
+free_vqs:
+	kfree(vqs);
+fail:
+	return err;
+}
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
  */
 static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *callbacks[] = { hvc_handle_input, NULL};
-	const char *names[] = { "input", "output" };
-	struct virtqueue *vqs[2];
 	struct ports_device *portdev;
 	int err;
 
@@ -443,13 +517,11 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	portdev->vdev = vdev;
 	vdev->priv = portdev;
 
-	/* Find the queues. */
-	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
-	if (err)
+	err = init_vqs(portdev);
+	if (err < 0) {
+		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
 		goto free;
-
-	portdev->in_vq = vqs[0];
-	portdev->out_vq = vqs[1];
+	}
 
 	/* We only have one port. */
 	err = add_port(portdev);
@@ -462,6 +534,8 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 
 free_vqs:
 	vdev->config->del_vqs(vdev);
+	kfree(portdev->in_vqs);
+	kfree(portdev->out_vqs);
 free:
 	kfree(portdev);
 fail:
-- 
1.6.2.5
