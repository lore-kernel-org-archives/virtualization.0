From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3] drm/virtio: use virtio_max_dma_size
Date: Tue, 13 Aug 2019 10:50:34 +0200
Message-ID: <20190813085034.14234-1-kraxel__21451.9139424496$1565686259$gmane$org@redhat.com>
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
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

We must make sure our scatterlist segments are not too big, otherwise
we might see swiotlb failures (happens with sev, also reproducable with
swiotlb=force).

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index b2da31310d24..3d86e4b3de58 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -204,6 +204,7 @@ int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
 		.interruptible = false,
 		.no_wait_gpu = false
 	};
+	unsigned max_segment;
 
 	/* wtf swapping */
 	if (bo->pages)
@@ -215,8 +216,13 @@ int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
 	if (!bo->pages)
 		goto out;
 
-	ret = sg_alloc_table_from_pages(bo->pages, pages, nr_pages, 0,
-					nr_pages << PAGE_SHIFT, GFP_KERNEL);
+	max_segment = virtio_max_dma_size(qdev->vdev);
+	max_segment &= PAGE_MASK;
+	if (max_segment > SCATTERLIST_MAX_SEGMENT)
+		max_segment = SCATTERLIST_MAX_SEGMENT;
+	ret = __sg_alloc_table_from_pages(bo->pages, pages, nr_pages, 0,
+					  nr_pages << PAGE_SHIFT,
+					  max_segment, GFP_KERNEL);
 	if (ret)
 		goto out;
 	return 0;
-- 
2.18.1
