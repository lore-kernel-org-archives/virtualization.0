From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 01/20] drm/atomic: Fix remaining places where
	!funcs->best_encoder is valid
Date: Tue,  7 Jun 2016 13:47:56 +0200
Message-ID: <1465300095-16971-2-git-send-email-boris.brezillon__26914.0264638283$1465300121$gmane$org@free-electrons.com>
References: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1465300095-16971-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Stefan Agner <stefan@agner.ch>, virtualization@lists.linux-foundation.org, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-samsung-soc@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, linux-tegra@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Inki Dae <inki.dae@sam>
List-Id: virtualization@lists.linuxfoundation.org

Adapt drm_pick_crtcs() and update_connector_routing() to fallback to
drm_atomic_helper_best_encoder() if funcs->best_encoder() is NULL so
that DRM drivers can leave this hook unassigned if they know they want
to use drm_atomic_helper_best_encoder().

Update the vtables documentation accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/drm_atomic_helper.c      |  4 +++-
 drivers/gpu/drm/drm_fb_helper.c          | 13 ++++++++++++-
 include/drm/drm_modeset_helper_vtables.h | 10 ++++++++--
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index f6a3350..849d029 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -300,8 +300,10 @@ update_connector_routing(struct drm_atomic_state *state,
 	if (funcs->atomic_best_encoder)
 		new_encoder = funcs->atomic_best_encoder(connector,
 							 connector_state);
-	else
+	else if (funcs->best_encoder)
 		new_encoder = funcs->best_encoder(connector);
+	else
+		new_encoder = drm_atomic_helper_best_encoder(connector);
 
 	if (!new_encoder) {
 		DRM_DEBUG_ATOMIC("No suitable encoder found for [CONNECTOR:%d:%s]\n",
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 7c2eb75..d44389a 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2000,7 +2000,18 @@ static int drm_pick_crtcs(struct drm_fb_helper *fb_helper,
 		my_score++;
 
 	connector_funcs = connector->helper_private;
-	encoder = connector_funcs->best_encoder(connector);
+
+	/*
+	 * If the DRM device implements atomic hooks and ->best_encoder() is
+	 * NULL we fallback to the default drm_atomic_helper_best_encoder()
+	 * helper.
+	 */
+	if (fb_helper->dev->mode_config.funcs->atomic_commit &&
+	    !connector_funcs->best_encoder)
+		encoder = drm_atomic_helper_best_encoder(connector);
+	else
+		encoder = connector_funcs->best_encoder(connector);
+
 	if (!encoder)
 		goto out;
 
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index d4619dc..4e7a53b 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -736,6 +736,11 @@ struct drm_connector_helper_funcs {
 	 * inspect dynamic configuration state should instead use
 	 * @atomic_best_encoder.
 	 *
+	 * You can leave this function to NULL if the connector is only
+	 * attached to a single encoder and you are using the atomic helpers.
+	 * In this case, the core will call drm_atomic_helper_best_encoder()
+	 * for you.
+	 *
 	 * RETURNS:
 	 *
 	 * Encoder that should be used for the given connector and connector
@@ -752,8 +757,9 @@ struct drm_connector_helper_funcs {
 	 * need to select the best encoder depending upon the desired
 	 * configuration and can't select it statically.
 	 *
-	 * This function is used by drm_atomic_helper_check_modeset() and either
-	 * this or @best_encoder is required.
+	 * This function is used by drm_atomic_helper_check_modeset().
+	 * If it is not implemented, the core will fallback to @best_encoder
+	 * (or drm_atomic_helper_best_encoder() if @best_encoder is NULL).
 	 *
 	 * NOTE:
 	 *
-- 
2.7.4
