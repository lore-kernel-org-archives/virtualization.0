From: Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: [PATCH] virtio_ring: use alloc_pages_node for NUMA-aware allocation
Date: Fri, 17 Jul 2020 17:35:04 +0800
Message-ID: <20200717093504.47794-1-shile.zhang@linux.alibaba.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Shile Zhang <shile.zhang@linux.alibaba.com>, Jiang Liu <liuj97@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Use alloc_pages_node() allocate memory for vring queue with proper
NUMA affinity.

Suggested-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58b96baa8d48..ded82880281a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -276,9 +276,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 		return dma_alloc_coherent(vdev->dev.parent, size,
 					  dma_handle, flag);
 	} else {
-		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
-
-		if (queue) {
+		void *queue = NULL;
+		struct page *page = alloc_pages_node(dev_to_node(&vdev->dev.parent),
+						     flag, get_order(size));
+		if (page) {
+			queue = page_address(page);
 			phys_addr_t phys_addr = virt_to_phys(queue);
 			*dma_handle = (dma_addr_t)phys_addr;
 
@@ -308,7 +310,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
 	if (vring_use_dma_api(vdev))
 		dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
 	else
-		free_pages_exact(queue, PAGE_ALIGN(size));
+		free_pages((unsigned long)queue, get_order(size));
 }
 
 /*
-- 
2.24.0.rc2
