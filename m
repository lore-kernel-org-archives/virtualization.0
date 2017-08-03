From: Cihangir Akturk <cakturk@gmail.com>
Subject: [PATCH 06/29] drm/bochs: switch to drm_*{get,put} helpers
Date: Thu,  3 Aug 2017 14:58:21 +0300
Message-ID: <1501761585-11757-7-git-send-email-cakturk__3541.51573633335$1509078902$gmane$org@gmail.com>
References: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Cihangir Akturk <cakturk@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

drm_*_reference() and drm_*_unreference() functions are just
compatibility alias for drm_*_get() and drm_*_put() adn should not be
used by new code. So convert all users of compatibility functions to use
the new APIs.

Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
---
 drivers/gpu/drm/bochs/bochs_fbdev.c |  2 +-
 drivers/gpu/drm/bochs/bochs_mm.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index c38deff..502f9d9 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -145,7 +145,7 @@ static int bochs_fbdev_destroy(struct bochs_device *bochs)
 	drm_fb_helper_unregister_fbi(&bochs->fb.helper);
 
 	if (gfb->obj) {
-		drm_gem_object_unreference_unlocked(gfb->obj);
+		drm_gem_object_put_unlocked(gfb->obj);
 		gfb->obj = NULL;
 	}
 
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index c4cadb6..881b784 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -417,7 +417,7 @@ int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
 		return ret;
 
 	ret = drm_gem_handle_create(file, gobj, &handle);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	if (ret)
 		return ret;
 
@@ -457,7 +457,7 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 	bo = gem_to_bochs_bo(obj);
 	*offset = bochs_bo_mmap_offset(bo);
 
-	drm_gem_object_unreference_unlocked(obj);
+	drm_gem_object_put_unlocked(obj);
 	return 0;
 }
 
@@ -467,7 +467,7 @@ static void bochs_user_framebuffer_destroy(struct drm_framebuffer *fb)
 {
 	struct bochs_framebuffer *bochs_fb = to_bochs_framebuffer(fb);
 
-	drm_gem_object_unreference_unlocked(bochs_fb->obj);
+	drm_gem_object_put_unlocked(bochs_fb->obj);
 	drm_framebuffer_cleanup(fb);
 	kfree(fb);
 }
@@ -518,13 +518,13 @@ bochs_user_framebuffer_create(struct drm_device *dev,
 
 	bochs_fb = kzalloc(sizeof(*bochs_fb), GFP_KERNEL);
 	if (!bochs_fb) {
-		drm_gem_object_unreference_unlocked(obj);
+		drm_gem_object_put_unlocked(obj);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	ret = bochs_framebuffer_init(dev, bochs_fb, mode_cmd, obj);
 	if (ret) {
-		drm_gem_object_unreference_unlocked(obj);
+		drm_gem_object_put_unlocked(obj);
 		kfree(bochs_fb);
 		return ERR_PTR(ret);
 	}
-- 
2.7.4
