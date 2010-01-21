From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: use smp_XX barriers
Date: Thu, 21 Jan 2010 19:10:57 +0200
Message-ID: <20100121171055.GA16693@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Documentation/memory-barriers.txt says:
Mandatory barriers should not be used to control SMP effects, since
mandatory barriers unnecessarily impose overhead on UP systems.

This rule applies to virtio, so let's do it correctly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbd2ecd..2216587 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -36,10 +36,10 @@
 			panic("%s:in_use = %i\n",		\
 			      (_vq)->vq.name, (_vq)->in_use);	\
 		(_vq)->in_use = __LINE__;			\
-		mb();						\
+		smp_mb();						\
 	} while (0)
 #define END_USE(_vq) \
-	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; mb(); } while(0)
+	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; smp_mb(); } while(0)
 #else
 #define BAD_RING(_vq, fmt, args...)				\
 	do {							\
@@ -221,13 +221,13 @@ static void vring_kick(struct virtqueue *_vq)
 	START_USE(vq);
 	/* Descriptors and available array need to be set before we expose the
 	 * new available array entries. */
-	wmb();
+	smp_wmb();
 
 	vq->vring.avail->idx += vq->num_added;
 	vq->num_added = 0;
 
 	/* Need to update avail index before checking if we should notify */
-	mb();
+	smp_mb();
 
 	if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY))
 		/* Prod other side to tell it about changes. */
@@ -286,7 +286,7 @@ static void *vring_get_buf(struct virtqueue *_vq, unsigned int *len)
 	}
 
 	/* Only get used array entries after they have been exposed by host. */
-	rmb();
+	smp_rmb();
 
 	i = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].id;
 	*len = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].len;
@@ -324,7 +324,7 @@ static bool vring_enable_cb(struct virtqueue *_vq)
 	/* We optimistically turn back on interrupts, then check if there was
 	 * more to do. */
 	vq->vring.avail->flags &= ~VRING_AVAIL_F_NO_INTERRUPT;
-	mb();
+	smp_mb();
 	if (unlikely(more_used(vq))) {
 		END_USE(vq);
 		return false;
-- 
1.6.6.144.g5c3af
