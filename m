From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/5] virtio-gpu: add atomic_commit function
Date: Tue, 31 May 2016 12:53:10 +0200
Message-ID: <1464691994-5704-3-git-send-email-kraxel__22322.3670422614$1464692033$gmane$org@redhat.com>
References: <1464691994-5704-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1464691994-5704-1-git-send-email-kraxel@redhat.com>
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

Do modesets first, then call drm_atomic_helper_commit_planes with
active_only = true.  That way the outputs doesn't get disabled
temporarly on atomic commits.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 22 +++++++++++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index d4305da..c5d33e0 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -466,10 +466,30 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	return &virtio_gpu_fb->base;
 }
 
+static int vgdev_atomic_commit(struct drm_device *dev,
+			       struct drm_atomic_state *state,
+			       bool nonblock)
+{
+	if (nonblock)
+		return -EBUSY;
+
+	drm_atomic_helper_swap_state(dev, state);
+	drm_atomic_helper_wait_for_fences(dev, state);
+
+	drm_atomic_helper_commit_modeset_disables(dev, state);
+	drm_atomic_helper_commit_modeset_enables(dev, state);
+	drm_atomic_helper_commit_planes(dev, state, true);
+
+	drm_atomic_helper_wait_for_vblanks(dev, state);
+	drm_atomic_helper_cleanup_planes(dev, state);
+	drm_atomic_state_free(state);
+	return 0;
+}
+
 static const struct drm_mode_config_funcs virtio_gpu_mode_funcs = {
 	.fb_create = virtio_gpu_user_framebuffer_create,
 	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = drm_atomic_helper_commit,
+	.atomic_commit = vgdev_atomic_commit,
 };
 
 int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 0a54f43..ecd1c43 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -33,6 +33,7 @@
 
 #include <drm/drmP.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_crtc_helper.h>
 #include <ttm/ttm_bo_api.h>
 #include <ttm/ttm_bo_driver.h>
-- 
1.8.3.1
