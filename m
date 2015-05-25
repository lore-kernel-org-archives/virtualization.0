From: Jason Wang <jasowang@redhat.com>
Subject: [RFC V7 PATCH 2/7] virtio_ring: try to disable event index callbacks
	in virtqueue_disable_cb()
Date: Mon, 25 May 2015 01:23:59 -0400
Message-ID: <1432531444-50193-3-git-send-email-jasowang__39105.2550556653$1432531491$gmane$org@redhat.com>
References: <1432531444-50193-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1432531444-50193-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Currently, we do nothing to prevent the callbacks in virtqueue_disable_cb() when
event index is used. This may cause spurious interrupts which may damage the
performance. This patch tries to publish last_used_idx as the used even to prevent
the callbacks.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 096b857..a83aebc 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -538,6 +538,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	vq->vring.avail->flags |= cpu_to_virtio16(_vq->vdev, VRING_AVAIL_F_NO_INTERRUPT);
+	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, vq->last_used_idx);
 }
 EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
-- 
1.8.3.1
