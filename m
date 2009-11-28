From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 11/28] virtio: console: Introduce a workqueue for handling
	host->guest notifications
Date: Sat, 28 Nov 2009 12:20:34 +0530
Message-ID: <1259391051-7752-12-git-send-email-amit.shah@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-11-git-send-email-amit.shah@redhat.com>
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

We currently only maintain one buffer per port for any data the
host sends us. If we're slow in consuming that data, we might lose
old data. To buffer the data that the host sends us, we need to be
able to allocate buffers as and when the host sends us some.

Using a workqueue gives us the freedom to allocate kernel buffers
since the workqueues are executed in process context.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   43 ++++++++++++++++++++++++++++------------
 1 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5a3d5df..a80d15c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -21,6 +21,7 @@
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_console.h>
+#include <linux/workqueue.h>
 #include "hvc_console.h"
 
 /*
@@ -58,6 +59,12 @@ DEFINE_SPINLOCK(pdrvdata_lock);
 struct ports_device {
 	struct virtqueue *in_vq, *out_vq;
 	struct virtio_device *vdev;
+
+	/*
+	 * Workqueue handlers where we process deferred work after an
+	 * interrupt
+	 */
+	struct work_struct rx_work;
 };
 
 /* This struct holds the per-port data */
@@ -243,18 +250,6 @@ static void notifier_del_vio(struct hvc_struct *hp, int data)
 	hp->irq_requested = 0;
 }
 
-static void hvc_handle_input(struct virtqueue *vq)
-{
-	struct port *port;
-	bool activity = false;
-
-	list_for_each_entry(port, &pdrvdata.consoles, list)
-		activity |= hvc_poll(port->hvc);
-
-	if (activity)
-		hvc_kick();
-}
-
 /* The operations for the console. */
 static const struct hv_ops hv_ops = {
 	.get_chars = get_chars,
@@ -279,6 +274,26 @@ int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
 	return hvc_instantiate(0, 0, &hv_ops);
 }
 
+static void rx_work_handler(struct work_struct *work)
+{
+	struct port *port;
+	bool activity = false;
+
+	list_for_each_entry(port, &pdrvdata.consoles, list)
+		activity |= hvc_poll(port->hvc);
+
+	if (activity)
+		hvc_kick();
+}
+
+static void rx_intr(struct virtqueue *vq)
+{
+	struct ports_device *portdev;
+
+	portdev = vq->vdev->priv;
+	schedule_work(&portdev->rx_work);
+}
+
 static int __devinit add_port(struct ports_device *portdev)
 {
 	struct port *port;
@@ -334,7 +349,7 @@ fail:
  */
 static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *callbacks[] = { hvc_handle_input, NULL};
+	vq_callback_t *callbacks[] = { rx_intr, NULL};
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	struct ports_device *portdev;
@@ -357,6 +372,8 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	portdev->in_vq = vqs[0];
 	portdev->out_vq = vqs[1];
 
+	INIT_WORK(&portdev->rx_work, &rx_work_handler);
+
 	/* We only have one port. */
 	err = add_port(portdev);
 	if (err)
-- 
1.6.2.5
