From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Fix compile warnings in virtio_balloon
Date: Thu, 24 Jan 2008 14:03:18 -0600
Message-ID: <12012049981852-git-send-email-aliguori@us.ibm.com>
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
Cc: Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On x86_64, min was throwing a warning.  ARRAY_SIZE is unsigned long so let's
switch to using that for num.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 9de85ae..2f77bfe 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -82,7 +82,7 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 	wait_for_completion(&vb->acked);
 }
 
-static void fill_balloon(struct virtio_balloon *vb, unsigned int num)
+static void fill_balloon(struct virtio_balloon *vb, unsigned long num)
 {
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
@@ -92,7 +92,7 @@ static void fill_balloon(struct virtio_balloon *vb, unsigned int num)
 		if (!page) {
 			if (printk_ratelimit())
 				dev_printk(KERN_INFO, &vb->vdev->dev,
-					   "Out of puff! Can't get %u pages\n",
+					   "Out of puff! Can't get %lu pages\n",
 					   num);
 			/* Sleep for at least 1/5 of a second before retry. */
 			msleep(200);
@@ -121,7 +121,7 @@ static void release_pages_by_pfn(const u32 pfns[], unsigned int num)
 	}
 }
 
-static void leak_balloon(struct virtio_balloon *vb, unsigned int num)
+static void leak_balloon(struct virtio_balloon *vb, unsigned long num)
 {
 	struct page *page;
