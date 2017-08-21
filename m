From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] drm: virtio: constify drm_fb_helper_funcs
Date: Mon, 21 Aug 2017 16:37:32 +0530
Message-ID: <60db0ba6ddce08444299533e97c9adec3b3ef1bb.1503311145.git.arvind.yadav.cs__5722.49346082589$1509079250$gmane$org@gmail.com>
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
To: airlied@linux.ie, kraxel@redhat.com, daniel.vetter@intel.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

drm_fb_helper_funcs are not supposed to change at runtime.
All functions working with drm_fb_helper_funcs provided
by <drm/drm_fb_helper.h> work with const drm_fb_helper_funcs.
So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index 33df067..61f33ec 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -309,7 +309,7 @@ static int virtio_gpu_fbdev_destroy(struct drm_device *dev,
 
 	return 0;
 }
-static struct drm_fb_helper_funcs virtio_gpu_fb_helper_funcs = {
+static const struct drm_fb_helper_funcs virtio_gpu_fb_helper_funcs = {
 	.fb_probe = virtio_gpufb_create,
 };
 
-- 
1.9.1
