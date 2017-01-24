From: Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] virtio-gpu: disable VIRGL with BE kernel
Date: Tue, 24 Jan 2017 14:12:29 +0100
Message-ID: <1485263549-28743-1-git-send-email-lvivier@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

VIRTIO_GPU_F_VIRGL is added in features list only
for LE kernel, so we must check for it only on LE kernel,
otherwise virtio_has_feature() calls BUG() and
crashes the kernel.

Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
Note: this patch has been actually written by Gerd,
but to post it I don't know if "Suggested-by" is enough
or if I should change the "author" field.

 drivers/gpu/drm/virtio/virtgpu_kms.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1235519..87915d5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -166,10 +166,14 @@ int virtio_gpu_driver_load(struct drm_device *dev, unsigned long flags)
 	INIT_WORK(&vgdev->config_changed_work,
 		  virtio_gpu_config_changed_work_func);
 
+#ifdef __LITTLE_ENDIAN
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
 	DRM_INFO("virgl 3d acceleration %s\n",
-		 vgdev->has_virgl_3d ? "enabled" : "not available");
+		 vgdev->has_virgl_3d ? "enabled" : "not supported by host");
+#else
+	DRM_INFO("virgl 3d acceleration not supported by guest\n");
+#endif
 
 	ret = vgdev->vdev->config->find_vqs(vgdev->vdev, 2, vqs,
 					    callbacks, names);
-- 
2.7.4
