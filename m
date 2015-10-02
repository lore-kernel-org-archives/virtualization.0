From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 6/7] virtio-gpu: mark as a render gpu
Date: Fri,  2 Oct 2015 13:58:23 +0200
Message-ID: <1443787104-24243-7-git-send-email-kraxel__12770.2447622598$1443787166$gmane$org@redhat.com>
References: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Dave Airlie <airlied@redhat.com>

Also add DRM_RENDER_ALLOW to the ioctls.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 1f15ef8..b40ed60 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -118,7 +118,7 @@ static const struct file_operations virtio_gpu_driver_fops = {
 
 
 static struct drm_driver driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME,
+	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME | DRIVER_RENDER,
 	.set_busid = drm_virtio_set_busid,
 	.load = virtio_gpu_driver_load,
 	.unload = virtio_gpu_driver_unload,
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index d5c9e02..d297f38 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -540,33 +540,33 @@ copy_exit:
 
 struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] = {
 	DRM_IOCTL_DEF_DRV(VIRTGPU_MAP, virtio_gpu_map_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED),
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_EXECBUFFER, virtio_gpu_execbuffer_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED),
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_GETPARAM, virtio_gpu_getparam_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED),
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_CREATE,
 			  virtio_gpu_resource_create_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED),
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_INFO, virtio_gpu_resource_info_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED),
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 
 	/* make transfer async to the main ring? - no sure, can we
 	   thread these in the underlying GL */
 	DRM_IOCTL_DEF_DRV(VIRTGPU_TRANSFER_FROM_HOST,
 			  virtio_gpu_transfer_from_host_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED),
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(VIRTGPU_TRANSFER_TO_HOST,
 			  virtio_gpu_transfer_to_host_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED),
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_WAIT, virtio_gpu_wait_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED),
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 
 	DRM_IOCTL_DEF_DRV(VIRTGPU_GET_CAPS, virtio_gpu_get_caps_ioctl,
-			  DRM_AUTH|DRM_UNLOCKED),
+			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 };
-- 
1.8.3.1
