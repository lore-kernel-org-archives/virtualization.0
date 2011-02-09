From: Ken Stailey <kstailey@yahoo.com>
Subject: [PATCH] virtio-net: add schedule check to napi_enable call in
	refill_work
Date: Wed, 9 Feb 2011 12:29:25 -0800 (PST)
Message-ID: <132885.30568.qm@web110313.mail.gq1.yahoo.com>
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
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Justification:

Impact: Under heavy network I/O load virtio-net driver crashes making VM guest unusable.

Testcases:

1) Sergey Svishchev reports that servers that run java webapps with high java heap usage (especially when heap size is close to physical memory size) helps trigger one of aforementioned bugs. Unfortunately, I don't have a simple test case.

2) Peter Lieven reports that his binary NNTP newsfeed test servers crash without this patch.

3) Bruce Rogers of Novell has asked for this patch to be integrated but the request was mysteriously ignored.  Is is purported that this patch is being distributed with SLES.

4) I can crash 2.6.32 and 2.6.38-rc4 by simply running "scp -r /nfs/read-only/1 otherhost:/target/1" and "scp -r /nfs/read-only/2 otherhost:/target/2" concurrently with a mix of small to medium files for a few hours usually.  I've never seen more than 200 GB copied before the crash occurs.  Both 2.6.32 and 2.6.38-rc4 with this patch will copy more than 200GB unfailingly this way.

See
https://bugs.launchpad.net/bugs/579276
for more details.



--- drivers/net/virtio_net.c.orig	2011-02-08 14:34:51.444099190 -0500
+++ drivers/net/virtio_net.c	2011-02-08 14:18:00.484400134 -0500
@@ -446,6 +446,20 @@
 	}
 }
 
+static void virtnet_napi_enable(struct virtnet_info *vi)
+{
+	napi_enable(&vi->napi);
+
+	/* If all buffers were filled by other side before we napi_enabled, we
+	 * won't get another interrupt, so process any outstanding packets
+	 * now.  virtnet_poll wants re-enable the queue, so we disable here.
+	 * We synchronize against interrupts via NAPI_STATE_SCHED */
+	if (napi_schedule_prep(&vi->napi)) {
+		virtqueue_disable_cb(vi->rvq);
+		__napi_schedule(&vi->napi);
+	}
+}
+
 static void refill_work(struct work_struct *work)
 {
 	struct virtnet_info *vi;
@@ -454,7 +468,7 @@
 	vi = container_of(work, struct virtnet_info, refill.work);
 	napi_disable(&vi->napi);
 	still_empty = !try_fill_recv(vi, GFP_KERNEL);
-	napi_enable(&vi->napi);
+	virtnet_napi_enable(vi);
 
 	/* In theory, this can happen: if we don't get any buffers in
 	 * we will *never* try to fill again. */
@@ -638,16 +652,7 @@
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
-	napi_enable(&vi->napi);
-
-	/* If all buffers were filled by other side before we napi_enabled, we
-	 * won't get another interrupt, so process any outstanding packets
-	 * now.  virtnet_poll wants re-enable the queue, so we disable here.
-	 * We synchronize against interrupts via NAPI_STATE_SCHED */
-	if (napi_schedule_prep(&vi->napi)) {
-		virtqueue_disable_cb(vi->rvq);
-		__napi_schedule(&vi->napi);
-	}
+	virtnet_napi_enable(vi);
 	return 0;
 }
