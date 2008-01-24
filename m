From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Fix compile warnings in virtio_balloon
Date: Fri, 25 Jan 2008 10:09:14 +1100
Message-ID: <200801251009.14305.rusty@rustcorp.com.au>
References: <12012049981852-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12012049981852-git-send-email-aliguori@us.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 25 January 2008 07:03:18 Anthony Liguori wrote:
> On x86_64, min was throwing a warning.  ARRAY_SIZE is unsigned long so
> let's switch to using that for num.

Creates warning on 32-bit.

How about this?
===

On x86_64, min was throwing a warning.  size_t is correct for 32 and 64.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -82,7 +82,7 @@ static void tell_host(struct virtio_ball
 	wait_for_completion(&vb->acked);
 }
 
-static void fill_balloon(struct virtio_balloon *vb, unsigned int num)
+static void fill_balloon(struct virtio_balloon *vb, size_t num)
 {
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
@@ -92,7 +92,7 @@ static void fill_balloon(struct virtio_b
 		if (!page) {
 			if (printk_ratelimit())
 				dev_printk(KERN_INFO, &vb->vdev->dev,
-					   "Out of puff! Can't get %u pages\n",
+					   "Out of puff! Can't get %zu pages\n",
 					   num);
 			/* Sleep for at least 1/5 of a second before retry. */
 			msleep(200);
@@ -121,7 +121,7 @@ static void release_pages_by_pfn(const u
 	}
 }
 
-static void leak_balloon(struct virtio_balloon *vb, unsigned int num)
+static void leak_balloon(struct virtio_balloon *vb, size_t num)
 {
 	struct page *page;
