From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 01/20] drm/atomic: Fix remaining places where
	!funcs->best_encoder is valid
Date: Thu,  2 Jun 2016 16:31:28 +0200
Message-ID: <1464877907-27723-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1464877907-27723-1-git-send-email-boris.brezillon@free-electrons.com>
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

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/gpu/drm/drm_atomic_helper.c |  4 +++-
 drivers/gpu/drm/drm_fb_helper.c     | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

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
 
-- 
2.7.4
