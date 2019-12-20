From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/4] drm/virtio: add drm_driver.release callback.
Date: Fri, 20 Dec 2019 12:59:34 +0100
Message-ID: <20191220115935.15152-4-kraxel__26354.8252450832$1576843202$gmane$org@redhat.com>
References: <20191220115935.15152-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191220115935.15152-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Split virtio_gpu_deinit(), move the drm shutdown and release to
virtio_gpu_release().  Also free vbufs in case we can't queue them.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h | 1 +
 drivers/gpu/drm/virtio/virtgpu_drv.c | 4 ++++
 drivers/gpu/drm/virtio/virtgpu_kms.c | 5 +++++
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 8 ++++++--
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 7e69c06e168e..227f7c07e61c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -216,6 +216,7 @@ extern struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS];
 /* virtio_kms.c */
 int virtio_gpu_init(struct drm_device *dev);
 void virtio_gpu_deinit(struct drm_device *dev);
+void virtio_gpu_release(struct drm_device *dev);
 int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file);
 void virtio_gpu_driver_postclose(struct drm_device *dev, struct drm_file *file);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 8cf27af3ad53..664a741a3b0b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 
 #include <drm/drm.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 
@@ -136,6 +137,7 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 	struct drm_device *dev = vdev->priv;
 
 	drm_dev_unregister(dev);
+	drm_atomic_helper_shutdown(dev);
 	virtio_gpu_deinit(dev);
 	drm_dev_put(dev);
 }
@@ -214,4 +216,6 @@ static struct drm_driver driver = {
 	.major = DRIVER_MAJOR,
 	.minor = DRIVER_MINOR,
 	.patchlevel = DRIVER_PATCHLEVEL,
+
+	.release = virtio_gpu_release,
 };
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 2f5773e43557..387f05a9cc18 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -237,6 +237,11 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	flush_work(&vgdev->config_changed_work);
 	vgdev->vdev->config->reset(vgdev->vdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
+}
+
+void virtio_gpu_release(struct drm_device *dev)
+{
+	struct virtio_gpu_device *vgdev = dev->dev_private;
 
 	virtio_gpu_modeset_fini(vgdev);
 	virtio_gpu_free_vbufs(vgdev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 5914e79d3429..619c6108d07e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -319,8 +319,10 @@ static bool virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
 	bool notify = false;
 	int ret;
 
-	if (!vgdev->vqs_ready)
+	if (!vgdev->vqs_ready) {
+		free_vbuf(vgdev, vbuf);
 		return notify;
+	}
 
 	sg_init_one(&vcmd, vbuf->buf, vbuf->size);
 	sgs[outcnt + incnt] = &vcmd;
@@ -447,8 +449,10 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	int ret;
 	int outcnt;
 
-	if (!vgdev->vqs_ready)
+	if (!vgdev->vqs_ready) {
+		free_vbuf(vgdev, vbuf);
 		return;
+	}
 
 	sg_init_one(&ccmd, vbuf->buf, vbuf->size);
 	sgs[0] = &ccmd;
-- 
2.18.1
