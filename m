From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH 1/2] drm/virtio: drop virtio_gpu_execbuffer_ioctl() wrapping
Date: Wed, 31 Aug 2016 12:26:52 -0400
Message-ID: <1472660813-28219-1-git-send-email-gustavo@padovan.org>
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
To: David Airlie <airlied@linux.ie>
Cc: open list <linux-kernel@vger.kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, "open list:VIRTIO GPU DRIVER" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Instead of wrapping virtio_gpu_execbuffer() to execute the ioctl
just execute it directly.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c046903..e0613a9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -89,10 +89,16 @@ static void virtio_gpu_unref_list(struct list_head *head)
 	}
 }
 
-static int virtio_gpu_execbuffer(struct drm_device *dev,
-				 struct drm_virtgpu_execbuffer *exbuf,
+/*
+ * Usage of execbuffer:
+ * Relocations need to take into account the full VIRTIO_GPUDrawable size.
+ * However, the command as passed from user space must *not* contain the initial
+ * VIRTIO_GPUReleaseInfo struct (first XXX bytes)
+ */
+static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *drm_file)
 {
+	struct drm_virtgpu_execbuffer *exbuf = data;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
 	struct drm_gem_object *gobj;
@@ -182,20 +188,6 @@ out_free:
 	return ret;
 }
 
-/*
- * Usage of execbuffer:
- * Relocations need to take into account the full VIRTIO_GPUDrawable size.
- * However, the command as passed from user space must *not* contain the initial
- * VIRTIO_GPUReleaseInfo struct (first XXX bytes)
- */
-static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
-				       struct drm_file *file_priv)
-{
-	struct drm_virtgpu_execbuffer *execbuffer = data;
-	return virtio_gpu_execbuffer(dev, execbuffer, file_priv);
-}
-
-
 static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 				     struct drm_file *file_priv)
 {
-- 
2.5.5
