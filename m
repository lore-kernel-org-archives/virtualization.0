From: Xin Long <lucien.xin@gmail.com>
Subject: [PATCH] virtio: queue variable should be initialized in
	vring_create_virtqueue
Date: Mon, 25 Apr 2016 00:50:00 +0800
Message-ID: <d7791ba9c480629c937083a02f610cbc3bd72b41.1461516600.git.lucien.xin__20672.2754090608$1461551977$gmane$org@gmail.com>
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
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Andy Lutomirski <luto@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

'queue' may be used uninitialized in vring_create_virtqueue, actually
when we compile kernel, gcc can also give this warning.

Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5c802d4..ca6bfdd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1006,7 +1006,7 @@ struct virtqueue *vring_create_virtqueue(
 	const char *name)
 {
 	struct virtqueue *vq;
-	void *queue;
+	void *queue = NULL;
 	dma_addr_t dma_addr;
 	size_t queue_size_in_bytes;
 	struct vring vring;
-- 
2.1.0
