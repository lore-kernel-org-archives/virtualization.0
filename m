From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 02/28] virtio: console: statically initialize virtio_cons
Date: Sat, 28 Nov 2009 12:20:25 +0530
Message-ID: <1259391051-7752-3-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-2-git-send-email-amit.shah@redhat.com>
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

From: Rusty Russell <rusty@rustcorp.com.au>

That way, we can make it const as is good kernel style.  We use a separate
indirection for the early console, rather than mugging ops.put_chars.

We rename it hv_ops, too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   60 +++++++++++++++++++++++-----------------
 1 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 26e238c..1d844a4 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -28,12 +28,12 @@ static struct virtio_device *vdev;
 static unsigned int in_len;
 static char *in, *inbuf;
 
-/* The operations for our console. */
-static struct hv_ops virtio_cons;
-
 /* The hvc device */
 static struct hvc_struct *hvc;
 
+/* This is the very early arch-specified put chars function. */
+static int (*early_put_chars)(u32, const char *, int);
+
 /*
  * The put_chars() callback is pretty straightforward.
  *
@@ -47,6 +47,9 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	struct scatterlist sg[1];
 	unsigned int len;
 
+	if (unlikely(early_put_chars))
+		return early_put_chars(vtermno, buf, count);
+
 	/* This is a convenient routine to initialize a single-elem sg list */
 	sg_init_one(sg, buf, count);
 
@@ -118,21 +121,6 @@ static int get_chars(u32 vtermno, char *buf, int count)
 }
 
 /*
- * Console drivers are initialized very early so boot messages can go
- * out, so we do things slightly differently from the generic virtio
- * initialization of the net and block drivers.
- *
- * At this stage, the console is output-only.  It's too early to set
- * up a virtqueue, so we let the drivers do some boutique early-output
- * thing.
- */
-int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
-{
-	virtio_cons.put_chars = put_chars;
-	return hvc_instantiate(0, 0, &virtio_cons);
-}
-
-/*
  * virtio console configuration. This supports:
  * - console resize
  */
@@ -174,6 +162,30 @@ static void hvc_handle_input(struct virtqueue *vq)
 		hvc_kick();
 }
 
+/* The operations for the console. */
+static struct hv_ops hv_ops = {
+	.get_chars = get_chars,
+	.put_chars = put_chars,
+	.notifier_add = notifier_add_vio,
+	.notifier_del = notifier_del_vio,
+	.notifier_hangup = notifier_del_vio,
+};
+
+/*
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
+	early_put_chars = put_chars;
+	return hvc_instantiate(0, 0, &hv_ops);
+}
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.  At this stage we set up the output virtqueue.
@@ -209,13 +221,6 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 	in_vq = vqs[0];
 	out_vq = vqs[1];
 
-	/* Start using the new console output. */
-	virtio_cons.get_chars = get_chars;
-	virtio_cons.put_chars = put_chars;
-	virtio_cons.notifier_add = notifier_add_vio;
-	virtio_cons.notifier_del = notifier_del_vio;
-	virtio_cons.notifier_hangup = notifier_del_vio;
-
 	/*
 	 * The first argument of hvc_alloc() is the virtual console
 	 * number, so we use zero.  The second argument is the
@@ -228,7 +233,7 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 	 * pointers.  The final argument is the output buffer size: we
 	 * can do any size, so we put PAGE_SIZE here.
 	 */
-	hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
+	hvc = hvc_alloc(0, 0, &hv_ops, PAGE_SIZE);
 	if (IS_ERR(hvc)) {
 		err = PTR_ERR(hvc);
 		goto free_vqs;
@@ -236,6 +241,9 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 
 	/* Register the input buffer the first time. */
 	add_inbuf();
+
+	/* Start using the new console output. */
+	early_put_chars = NULL;
 	return 0;
 
 free_vqs:
-- 
1.6.2.5
