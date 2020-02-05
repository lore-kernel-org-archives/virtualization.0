From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/virtio: fix vblank handling
Date: Wed,  5 Feb 2020 07:53:11 +0100
Message-ID: <20200205065312.15790-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: olvaffe@gmail.com, gurchetansingh@chromium.org, tzimmermann@suse.de, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

virtio has its own commit fail function.  Add the
drm_atomic_helper_fake_vblank() call there.

Fixes: 2a735ad3d211 ("drm/virtio: Remove sending of vblank event")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index ecf4ba7cc32b..7b0f0643bb2d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -324,6 +324,7 @@ static void vgdev_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_commit_modeset_enables(dev, state);
 	drm_atomic_helper_commit_planes(dev, state, 0);
 
+	drm_atomic_helper_fake_vblank(state);
 	drm_atomic_helper_commit_hw_done(state);
 
 	drm_atomic_helper_wait_for_vblanks(dev, state);
-- 
2.18.1
