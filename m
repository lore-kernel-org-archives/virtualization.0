From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] virtio-gpu: fix vblank events
Date: Thu, 13 Oct 2016 13:55:05 +0200
Message-ID: <1476359705-12589-1-git-send-email-kraxel__25529.9065066085$1476359742$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, "daniel.vetter" <daniel.vetter@ffwll.ch>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

virtio-gpu sends vblank events in virtio_gpu_crtc_atomic_flush, and
because of that it must be called for disabled planes too.  Ask
drm_atomic_helper_commit_planes to do that.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 4e192aa..75ec172 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -338,7 +338,7 @@ static void vgdev_atomic_commit_tail(struct drm_atomic_state *state)
 
 	drm_atomic_helper_commit_modeset_disables(dev, state);
 	drm_atomic_helper_commit_modeset_enables(dev, state);
-	drm_atomic_helper_commit_planes(dev, state, true);
+	drm_atomic_helper_commit_planes(dev, state, false);
 
 	drm_atomic_helper_commit_hw_done(state);
 
-- 
1.8.3.1
