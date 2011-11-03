From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5 of 5] virtio: expose added descriptors immediately
Date: Thu, 03 Nov 2011 18:12:53 +1030
Message-ID: <f3831c1617c86a51d875.1320306173@localhost6.localdomain6>
References: <patchbomb.1320306168@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <patchbomb.1320306168@localhost6.localdomain6>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: MichaelS.Tsirkist@redhat.com, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

A virtio driver does virtqueue_add_buf() multiple times before finally
calling virtqueue_kick(); previously we only exposed the added buffers
in the virtqueue_kick() call.  This means we don't need a memory
barrier in virtqueue_add_buf(), but it reduces concurrency as the
device (ie. host) can't see the buffers until the kick.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -227,9 +227,15 @@ add_head:
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
-	avail = ((vq->vring.avail->idx + vq->num_added++) & (vq->vring.num-1));
+	avail = (vq->vring.avail->idx & (vq->vring.num-1));
 	vq->vring.avail->ring[avail] = head;
 
+	/* Descriptors and available array need to be set before we expose the
+	 * new available array entries. */
+	virtio_wmb();
+	vq->vring.avail->idx++;
+	vq->num_added++;
+
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
 
@@ -248,13 +254,10 @@ bool virtqueue_kick_prepare(struct virtq
 	 * new available array entries. */
 	virtio_wmb();
 
-	old = vq->vring.avail->idx;
-	new = vq->vring.avail->idx = old + vq->num_added;
+	old = vq->vring.avail->idx - vq->num_added;
+	new = vq->vring.avail->idx;
 	vq->num_added = 0;
 
-	/* Need to update avail index before checking if we should notify */
-	virtio_mb();
-
 	if (vq->event) {
 		needs_kick = vring_need_event(vring_avail_event(&vq->vring),
 					      new, old);
