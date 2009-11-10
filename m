From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 01/15] virtio_console: Initialize hv_ops struct at declaration
	instead of in the probe() routine
Date: Tue, 10 Nov 2009 15:11:27 +0530
Message-ID: <1257846101-23258-2-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
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

Initialize the hv_ops function pointers using C99 style. However, we
need to re-init the 'put_chars' field to our implementation in the
probe() routine as we replace it for early_init to use the caller's
put_chars implementation.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   50 ++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a035ae3..e5284a9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -43,9 +43,6 @@ static struct virtio_device *vdev;
 static unsigned int in_len;
 static char *in, *inbuf;
 
-/* The operations for our console. */
-static struct hv_ops virtio_cons;
-
 /* The hvc device */
 static struct hvc_struct *hvc;
 
@@ -125,18 +122,6 @@ static int get_chars(u32 vtermno, char *buf, int count)
 }
 /*:*/
 
-/*D:320 Console drivers are initialized very early so boot messages can go out,
- * so we do things slightly differently from the generic virtio initialization
- * of the net and block drivers.
- *
- * At this stage, the console is output-only.  It's too early to set up a
- * virtqueue, so we let the drivers do some boutique early-output thing. */
-int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
-{
-	virtio_cons.put_chars = put_chars;
-	return hvc_instantiate(0, 0, &virtio_cons);
-}
-
 /*
  * virtio console configuration. This supports:
  * - console resize
@@ -173,6 +158,30 @@ static void notifier_del_vio(struct hvc_struct *hp, int data)
 	hp->irq_requested = 0;
 }
 
+/* The operations for our console. */
+static struct hv_ops virtio_cons = {
+	.get_chars = get_chars,
+	.put_chars = put_chars,
+	.notifier_add = notifier_add_vio,
+	.notifier_del = notifier_del_vio,
+	.notifier_hangup = notifier_del_vio,
+};
+
+/*D:320
+ * Console drivers are initialized very early so boot messages can go
+ * out, so we do things slightly differently from the generic virtio
+ * initialization of the net and block drivers.
+ *
+ * At this stage, the console is output-only.  It's too early to set
+ * up a virtqueue, so we let the drivers do some boutique early-output
+ * thing.
+ */
+int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
+{
+	virtio_cons.put_chars = put_chars;
+	return hvc_instantiate(0, 0, &virtio_cons);
+}
+
 static void hvc_handle_input(struct virtqueue *vq)
 {
 	if (hvc_poll(hvc))
@@ -212,12 +221,13 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 	in_vq = vqs[0];
 	out_vq = vqs[1];
 
-	/* Start using the new console output. */
-	virtio_cons.get_chars = get_chars;
+	/*
+	 * We had set the virtio_cons ->put_chars implementation to an
+	 * architecture-provided put_chars for early_init. Now that
+	 * we're done with the early init phase, replace it with our
+	 * implementation.
+	 */
 	virtio_cons.put_chars = put_chars;
-	virtio_cons.notifier_add = notifier_add_vio;
-	virtio_cons.notifier_del = notifier_del_vio;
-	virtio_cons.notifier_hangup = notifier_del_vio;
 
 	/* The first argument of hvc_alloc() is the virtual console number, so
 	 * we use zero.  The second argument is the parameter for the
-- 
1.6.2.5
