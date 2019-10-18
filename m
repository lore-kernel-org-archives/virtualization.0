From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: print a single line with device features
Date: Fri, 18 Oct 2019 13:38:32 +0200
Message-ID: <20191018113832.5460-1-kraxel__45852.7593802259$1571398726$gmane$org@redhat.com>
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 0b3cdb0d83b0..2f5773e43557 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -155,16 +155,15 @@ int virtio_gpu_init(struct drm_device *dev)
 #ifdef __LITTLE_ENDIAN
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
-	DRM_INFO("virgl 3d acceleration %s\n",
-		 vgdev->has_virgl_3d ? "enabled" : "not supported by host");
-#else
-	DRM_INFO("virgl 3d acceleration not supported by guest\n");
 #endif
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
 		vgdev->has_edid = true;
-		DRM_INFO("EDID support available.\n");
 	}
 
+	DRM_INFO("features: %cvirgl %cedid\n",
+		 vgdev->has_virgl_3d ? '+' : '-',
+		 vgdev->has_edid     ? '+' : '-');
+
 	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
 	if (ret) {
 		DRM_ERROR("failed to find virt queues\n");
-- 
2.18.1
