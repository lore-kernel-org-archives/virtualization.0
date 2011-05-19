From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 11/14] virtio: don't delay avail index update
Date: Fri, 20 May 2011 02:12:19 +0300
Message-ID: <33d7df119ccbedc9b54fbe4b674076b4f7ba3499.1305846412.git.mst__35775.6640798927$1305847632$gmane$org@redhat.com>
References: <cover.1305846412.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1305846412.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Update avail index immediately instead of upon kick:
for virtio-net RX this helps parallelism with the host.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index eed5f29..8218fe6 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -89,7 +89,7 @@ struct vring_virtqueue
 	unsigned int num_free;
 	/* Head of free buffer list. */
 	unsigned int free_head;
-	/* Number we've added since last sync. */
+	/* Number we've added since last kick. */
 	unsigned int num_added;
 
 	/* Last used index we've seen. */
@@ -174,6 +174,13 @@ int virtqueue_add_buf_gfp(struct virtqueue *_vq,
 
 	BUG_ON(data == NULL);
 
+	/* Prevent drivers from adding more than num bufs without a kick. */
+	if (vq->num_added == vq->vring.num) {
+		printk(KERN_ERR "gaaa!!!\n");
+		END_USE(vq);
+		return -ENOSPC;
+	}
+
 	/* If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold */
 	if (vq->indirect && (out + in) > 1 && vq->num_free) {
@@ -227,8 +234,14 @@ add_head:
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync).  FIXME: avoid modulus here? */
-	avail = (vq->vring.avail->idx + vq->num_added++) % vq->vring.num;
+	avail = vq->vring.avail->idx % vq->vring.num;
 	vq->vring.avail->ring[avail] = head;
+	vq->num_added++;
+
+	/* Descriptors and available array need to be set before we expose the
+	 * new available array entries. */
+	virtio_wmb();
+	vq->vring.avail->idx++;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
@@ -242,17 +255,14 @@ void virtqueue_kick(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u16 new, old;
 	START_USE(vq);
-	/* Descriptors and available array need to be set before we expose the
-	 * new available array entries. */
-	virtio_wmb();
-
-	old = vq->vring.avail->idx;
-	new = vq->vring.avail->idx = old + vq->num_added;
-	vq->num_added = 0;
 
 	/* Need to update avail index before checking if we should notify */
 	virtio_mb();
 
+	new = vq->vring.avail->idx;
+	old = new - vq->num_added;
+	vq->num_added = 0;
+
 	if (vq->event ?
 	    vring_need_event(vring_avail_event(&vq->vring), new, old) :
 	    !(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY))
-- 
1.7.5.53.gc233e
