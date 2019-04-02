From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] drm/bochs: drop mode_config_initialized
Date: Tue,  2 Apr 2019 11:04:58 +0200
Message-ID: <20190402090459.12126-2-kraxel__30322.7791491494$1554195918$gmane$org@redhat.com>
References: <20190402090459.12126-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190402090459.12126-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     | 1 -
 drivers/gpu/drm/bochs/bochs_kms.c | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 03711394f1ed..a7f6723bebdd 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -73,7 +73,6 @@ struct bochs_device {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct drm_connector connector;
-	bool mode_config_initialized;
 
 	/* ttm */
 	struct {
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 93cb27f93d39..485f9cf05e8b 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -267,7 +267,6 @@ const struct drm_mode_config_funcs bochs_mode_funcs = {
 int bochs_kms_init(struct bochs_device *bochs)
 {
 	drm_mode_config_init(bochs->dev);
-	bochs->mode_config_initialized = true;
 
 	bochs->dev->mode_config.max_width = 8192;
 	bochs->dev->mode_config.max_height = 8192;
@@ -292,9 +291,6 @@ int bochs_kms_init(struct bochs_device *bochs)
 
 void bochs_kms_fini(struct bochs_device *bochs)
 {
-	if (bochs->mode_config_initialized) {
-		drm_atomic_helper_shutdown(bochs->dev);
-		drm_mode_config_cleanup(bochs->dev);
-		bochs->mode_config_initialized = false;
-	}
+	drm_atomic_helper_shutdown(bochs->dev);
+	drm_mode_config_cleanup(bochs->dev);
 }
-- 
2.18.1
