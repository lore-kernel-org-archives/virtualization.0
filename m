From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] virtio: don't warn if we can't allocate indirect sglist
Date: Mon, 11 Jul 2016 13:22:15 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1607111320530.25989@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Don't print warning if memory allocation fails. The virtio driver can
handle allocation failure (it falls back to direct sglist), so there is
no functionality degradation.

This warning was observed when swapping to virtio scsi device because
there may be not enough free memory during swapping.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/virtio/virtio_ring.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-4.7-rc7/drivers/virtio/virtio_ring.c
===================================================================
--- linux-4.7-rc7.orig/drivers/virtio/virtio_ring.c	2016-05-09 17:45:04.000000000 +0200
+++ linux-4.7-rc7/drivers/virtio/virtio_ring.c	2016-07-11 17:30:20.000000000 +0200
@@ -237,6 +237,12 @@ static struct vring_desc *alloc_indirect
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
+	/*
+	 * Don't warn if the allocation fails, because the driver
+	 * handles allocation failures gracefully.
+	 */
+	gfp |= __GFP_NOWARN;
+
 	desc = kmalloc(total_sg * sizeof(struct vring_desc), gfp);
 	if (!desc)
 		return NULL;
