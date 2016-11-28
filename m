From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: fix framebuffer sparse warning
Date: Mon, 28 Nov 2016 09:05:21 +0100
Message-ID: <1480320322-23362-1-git-send-email-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

virtio uses normal ram as backing storage for the framebuffer, so we
should assign the address to new screen_buffer (added by commit
17a7b0b4d9749f80d365d7baff5dec2f54b0e992) instead of screen_base.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index 2242a80..dc2976c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -337,7 +337,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	info->fbops = &virtio_gpufb_ops;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
-	info->screen_base = obj->vmap;
+	info->screen_buffer = obj->vmap;
 	info->screen_size = obj->gem_base.size;
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->depth);
 	drm_fb_helper_fill_var(info, &vfbdev->helper,
-- 
1.8.3.1
