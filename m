From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4 of 5] virtio: avoid modulus operation
Date: Thu, 03 Nov 2011 18:12:52 +1030
Message-ID: <05de9ee25e222c5206f3.1320306172@localhost6.localdomain6>
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

Since we know vq->vring.num is a power of 2, modulus is lazy (it's asserted
in vring_new_virtqueue()).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lguest/boot.c b/arch/x86/lguest/boot.c
--- a/arch/x86/lguest/boot.c
+++ b/arch/x86/lguest/boot.c
@@ -1420,7 +1420,7 @@ __init void lguest_init(void)
 	add_preferred_console("hvc", 0, NULL);
 
 	/* Register our very early console. */
-	virtio_cons_early_init(early_put_chars);
+//	virtio_cons_early_init(early_put_chars);
 
 	/*
 	 * Last of all, we set the power management poweroff hook to point to
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -226,8 +226,8 @@ add_head:
 	vq->data[head] = data;
 
 	/* Put entry in available array (but don't update avail->idx until they
-	 * do sync).  FIXME: avoid modulus here? */
-	avail = (vq->vring.avail->idx + vq->num_added++) % vq->vring.num;
+	 * do sync). */
+	avail = ((vq->vring.avail->idx + vq->num_added++) & (vq->vring.num-1));
 	vq->vring.avail->ring[avail] = head;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
@@ -317,6 +317,7 @@ void *virtqueue_get_buf(struct virtqueue
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	void *ret;
 	unsigned int i;
+	u16 last_used;
 
 	START_USE(vq);
 
@@ -334,8 +335,9 @@ void *virtqueue_get_buf(struct virtqueue
 	/* Only get used array entries after they have been exposed by host. */
 	virtio_rmb();
 
-	i = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].id;
-	*len = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].len;
+	last_used = (vq->last_used_idx & (vq->vring.num - 1));
+	i = vq->vring.used->ring[last_used].id;
+	*len = vq->vring.used->ring[last_used].len;
 
 	if (unlikely(i >= vq->vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", i);
