From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/5] drm/bochs: Use shadow buffer for bochs framebuffer console
Date: Wed,  3 Jul 2019 10:33:01 +0200
Message-ID: <20190703083302.2609-5-tzimmermann__46842.2000574478$1562143446$gmane$org@suse.de>
References: <20190703083302.2609-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190703083302.2609-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: airlied@redhat.com, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com, sean@poorly.run, noralf@tronnes.org, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The bochs driver (and virtual hardware) requires buffer objects to
reside in video ram to display them to the screen. So it can not
display the framebuffer console because the respective buffer object
is permanently pinned in system memory.

Using a shadow buffer for the console solves this problem. The console
emulation will pin the buffer object only during updates from the shadow
buffer. Otherwise, the bochs driver can freely relocated the buffer
between system memory and video ram.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index bc19dbd531ef..47fab4852483 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -172,7 +172,7 @@ bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
 	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888)
 		return ERR_PTR(-EINVAL);
 
-	return drm_gem_fb_create(dev, file, mode_cmd);
+	return drm_gem_fb_create_with_dirty(dev, file, mode_cmd);
 }
 
 const struct drm_mode_config_funcs bochs_mode_funcs = {
-- 
2.21.0
