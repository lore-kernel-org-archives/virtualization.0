From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 36/94] drm/virtio: use virtio_max_dma_size
Date: Wed,  4 Sep 2019 11:56:41 -0400
Message-ID: <20190904155739.2816-36-sashal__3317.80761932663$1567612760$gmane$org@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Laszlo Ersek <lersek@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Gerd Hoffmann <kraxel@redhat.com>

[ Upstream commit 9b2a0a1ef66f96bf34921a3865581eca32ff05ec ]

We must make sure our scatterlist segments are not too big, otherwise
we might see swiotlb failures (happens with sev, also reproducable with
swiotlb=force).

Suggested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20190821111210.27165-1-kraxel@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index b2da31310d24c..09b526518f5a6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -204,6 +204,7 @@ int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
 		.interruptible = false,
 		.no_wait_gpu = false
 	};
+	size_t max_segment;
 
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
2.20.1
