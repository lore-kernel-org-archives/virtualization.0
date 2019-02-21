From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 2/2] drm/bochs: Drop best_encoder
Date: Thu, 21 Feb 2019 16:58:57 +0100
Message-ID: <20190221155857.19773-2-daniel.vetter__21961.9862082013$1550764966$gmane$org@ffwll.ch>
References: <20190221155857.19773-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190221155857.19773-1-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel.vetter@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This is the default for atomic drivers.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/gpu/drm/bochs/bochs_kms.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 9cd82e3631fb..9e7cd6b34106 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -214,20 +214,9 @@ static enum drm_mode_status bochs_connector_mode_valid(struct drm_connector *con
 	return MODE_OK;
 }
 
-static struct drm_encoder *
-bochs_connector_best_encoder(struct drm_connector *connector)
-{
-	int enc_id = connector->encoder_ids[0];
-	/* pick the encoder ids */
-	if (enc_id)
-		return drm_encoder_find(connector->dev, NULL, enc_id);
-	return NULL;
-}
-
 static const struct drm_connector_helper_funcs bochs_connector_connector_helper_funcs = {
 	.get_modes = bochs_connector_get_modes,
 	.mode_valid = bochs_connector_mode_valid,
-	.best_encoder = bochs_connector_best_encoder,
 };
 
 static const struct drm_connector_funcs bochs_connector_connector_funcs = {
-- 
2.20.1
