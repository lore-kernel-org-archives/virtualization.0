From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 04/15] virtio_console: Introduce a workqueue for handling
	host->guest notifications
Date: Tue, 10 Nov 2009 15:11:30 +0530
Message-ID: <1257846101-23258-5-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-4-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-4-git-send-email-amit.shah@redhat.com>
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

We currently only maintain one buffer for any data the host sends
us. If we're slow in consuming that data, we might lose old data.
To buffer the data that the host sends us, we need to be able to
allocate buffers as and when the host sends us some.

Using a workqueue gives us the freedom to allocate kernel buffers
since the workqueues are executed in process context.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index ed4d9a4..19c9729 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -35,6 +35,12 @@
 #include "hvc_console.h"
 
 struct virtio_console_struct {
+	/*
+	 * Workqueue handlers where we process deferred work after an
+	 * interrupt
+	 */
+	struct work_struct rx_work;
+
 	/*D:340
 	 * These represent our input and output console queues,
 	 * and the virtio operations for them.
@@ -197,12 +203,21 @@ int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
 	return hvc_instantiate(0, 0, &virtio_cons);
 }
 
-static void hvc_handle_input(struct virtqueue *vq)
+static void virtio_console_rx_work_handler(struct work_struct *work)
 {
-	if (hvc_poll(virtconsole.hvc))
+	struct virtio_console_struct *vcon;
+
+	vcon = container_of(work, struct virtio_console_struct, rx_work);
+
+	if (hvc_poll(vcon->hvc))
 		hvc_kick();
 }
 
+static void rx_intr(struct virtqueue *vq)
+{
+	schedule_work(&virtconsole.rx_work);
+}
+
 /*D:370 Once we're further in boot, we get probed like any other virtio device.
  * At this stage we set up the output virtqueue.
  *
@@ -212,7 +227,7 @@ static void hvc_handle_input(struct virtqueue *vq)
  * Finally we put our input buffer in the input queue, ready to receive. */
 static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *callbacks[] = { hvc_handle_input, NULL};
+	vq_callback_t *callbacks[] = { rx_intr, NULL};
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	int err;
@@ -248,6 +263,8 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	 */
 	virtio_cons.put_chars = put_chars;
 
+	INIT_WORK(&virtconsole.rx_work, &virtio_console_rx_work_handler);
+
 	/* The first argument of hvc_alloc() is the virtual console number, so
 	 * we use zero.  The second argument is the parameter for the
 	 * notification mechanism (like irq number). We currently leave this
-- 
1.6.2.5
