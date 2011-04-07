From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: [RFC][PATCH] virtio balloon: kill tell-host-first logic
Date: Thu, 07 Apr 2011 10:43:25 -0700
Message-ID: <20110407174325.ED21C82B__29140.2777111673$1302198300$gmane$org@kernel>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


The virtio balloon driver has a VIRTIO_BALLOON_F_MUST_TELL_HOST
feature bit.  Whenever the bit is set, we must always tell the
host before we free pages back to the allocator.  Without this
we might free a page (and have another user touch it) while the
hypervisor is unprepared for it.

But, if the bit is _not_ set, we are under no obligation to
reverse the order.  Furthermore, all modern qemus set this bit.
So, the "tell second" code is completely unused and untestable.
Quoting Anthony: "untested code is broken code".

This _also_ means that we don't have to preserve a pfn list
after the pages are freed, which should let us get rid of some
temporary storage (vb->pfns) eventually.


Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/drivers/virtio/virtio_balloon.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff -puN drivers/virtio/virtio_balloon.c~kill-tell-host-first-logic drivers/virtio/virtio_balloon.c
--- linux-2.6.git/drivers/virtio/virtio_balloon.c~kill-tell-host-first-logic	2011-04-07 10:23:12.016343374 -0700
+++ linux-2.6.git-dave/drivers/virtio/virtio_balloon.c	2011-04-07 10:23:12.024343370 -0700
@@ -40,9 +40,6 @@ struct virtio_balloon
 	/* Waiting for host to ack the pages we released. */
 	struct completion acked;
 
-	/* Do we have to tell Host *before* we reuse pages? */
-	bool tell_host_first;
-
 	/* The pages we've told the Host we're not using. */
 	unsigned int num_pages;
 	struct list_head pages;
@@ -151,13 +148,14 @@ static void leak_balloon(struct virtio_b
 		vb->num_pages--;
 	}
 
-	if (vb->tell_host_first) {
-		tell_host(vb, vb->deflate_vq);
-		release_pages_by_pfn(vb->pfns, vb->num_pfns);
-	} else {
-		release_pages_by_pfn(vb->pfns, vb->num_pfns);
-		tell_host(vb, vb->deflate_vq);
-	}
+
+	/*
+	 * Note that if
+	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
+	 * is true, we *have* to do it in this order
+	 */
+	tell_host(vb, vb->deflate_vq);
+	release_pages_by_pfn(vb->pfns, vb->num_pfns);
 }
 
 static inline void update_stat(struct virtio_balloon *vb, int idx,
@@ -325,9 +323,6 @@ static int virtballoon_probe(struct virt
 		goto out_del_vqs;
 	}
 
-	vb->tell_host_first
-		= virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
-
 	return 0;
 
 out_del_vqs:
_
