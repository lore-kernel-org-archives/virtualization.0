From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/2] drm/virtio: fix mmap page attributes
Date: Wed, 11 Dec 2019 09:18:10 +0100
Message-ID: <20191211081810.20079-3-kraxel@redhat.com>
References: <20191211081810.20079-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191211081810.20079-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, gurchetansingh@chromium.org
List-Id: virtualization@lists.linuxfoundation.org

virtio-gpu uses cached mappings, set shmem->caching accordingly.

Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 017a9e0fc3bb..a0b5e5195816 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -118,6 +118,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	shmem_obj = drm_gem_shmem_create(vgdev->ddev, params->size);
 	if (IS_ERR(shmem_obj))
 		return PTR_ERR(shmem_obj);
+	shmem_obj->caching = DRM_GEM_SHMEM_CACHED;
 	bo = gem_to_virtio_gpu_obj(&shmem_obj->base);
 
 	ret = virtio_gpu_resource_id_get(vgdev, &bo->hw_res_handle);
-- 
2.18.1
