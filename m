From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/8] virtio: console: comment cleanup
Date: Tue, 10 Nov 2009 16:57:30 +1030
Message-ID: <1492.37399823523$1257834680@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


Remove old lguest-style comments.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/virtio_console.c |   30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1,18 +1,5 @@
-/*D:300
- * The Guest console driver
- *
- * Writing console drivers is one of the few remaining Dark Arts in Linux.
- * Fortunately for us, the path of virtual consoles has been well-trodden by
- * the PowerPC folks, who wrote "hvc_console.c" to generically support any
- * virtual console.  We use that infrastructure which only requires us to write
- * the basic put_chars and get_chars functions and call the right register
- * functions.
- :*/
-
-/*M:002 The console can be flooded: while the Guest is processing input the
- * Host can send more.  Buffering in the Host could alleviate this, but it is a
- * difficult problem in general. :*/
-/* Copyright (C) 2006, 2007 Rusty Russell, IBM Corporation
+/*
+ * Copyright (C) 2006, 2007, 2009 Rusty Russell, IBM Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -34,8 +21,6 @@
 #include <linux/virtio_console.h>
 #include "hvc_console.h"
 
-/*D:340 These represent our input and output console queues, and the virtio
- * operations for them. */
 static struct virtqueue *in_vq, *out_vq;
 static struct virtio_device *vdev;
 
@@ -49,7 +34,7 @@ static struct hv_ops virtio_cons;
 /* The hvc device */
 static struct hvc_struct *hvc;
 
-/*D:310 The put_chars() callback is pretty straightforward.
+/* The put_chars() callback is pretty straightforward.
  *
  * We turn the characters into a scatter-gather list, add it to the output
  * queue and then kick the Host.  Then we sit here waiting for it to finish:
@@ -90,7 +75,7 @@ static void add_inbuf(void)
 	in_vq->vq_ops->kick(in_vq);
 }
 
-/*D:350 get_chars() is the callback from the hvc_console infrastructure when
+/* get_chars() is the callback from the hvc_console infrastructure when
  * an interrupt is received.
  *
  * Most of the code deals with the fact that the hvc_console() infrastructure
@@ -123,9 +108,8 @@ static int get_chars(u32 vtermno, char *
 
 	return count;
 }
-/*:*/
 
-/*D:320 Console drivers are initialized very early so boot messages can go out,
+/* Console drivers are initialized very early so boot messages can go out,
  * so we do things slightly differently from the generic virtio initialization
  * of the net and block drivers.
  *
@@ -179,7 +163,7 @@ static void hvc_handle_input(struct virt
 		hvc_kick();
 }
 
-/*D:370 Once we're further in boot, we get probed like any other virtio device.
+/* Once we're further in boot, we get probed like any other virtio device.
  * At this stage we set up the output virtqueue.
  *
  * To set up and manage our virtual console, we call hvc_alloc().  Since we
@@ -203,8 +187,6 @@ static int __devinit virtcons_probe(stru
 	}
 
 	/* Find the queues. */
-	/* FIXME: This is why we want to wean off hvc: we do nothing
-	 * when input comes in. */
 	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
 	if (err)
 		goto free;
