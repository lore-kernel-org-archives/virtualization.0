From: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 1/2] drm/virtio: Handle error from
	virtio_gpu_resource_id_get
Date: Tue, 30 Oct 2018 09:53:51 -0700
Message-ID: <20181030165352.13065-1-willy__31357.5847111226$1540918362$gmane$org@infradead.org>
References: <20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181029215339.aywdmehccrwwls2n@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

ida_alloc() can return -ENOMEM in the highly unlikely case we run out
of memory.  The current code creates an object with an invalid ID.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 77eac4eb06b1..5ac42dded217 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -25,11 +25,16 @@
 
 #include "virtgpu_drv.h"
 
-static void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
+static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
 				       uint32_t *resid)
 {
 	int handle = ida_alloc_min(&vgdev->resource_ida, 1, GFP_KERNEL);
+
+	if (handle < 0)
+		return handle;
+
 	*resid = handle;
+	return 0;
 }
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
@@ -94,7 +99,11 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	bo = kzalloc(sizeof(struct virtio_gpu_object), GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
-	virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
+	ret = virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
+	if (ret < 0) {
+		kfree(bo);
+		return ret;
+	}
 	size = roundup(size, PAGE_SIZE);
 	ret = drm_gem_object_init(vgdev->ddev, &bo->gem_base, size);
 	if (ret != 0) {
-- 
2.19.1
