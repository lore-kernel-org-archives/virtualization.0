From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 14/14] drm: remove unused and redundant callbacks
Date: Thu, 22 Jun 2017 08:06:37 +0200
Message-ID: <1498111597-10714-15-git-send-email-peda__30627.9436954812$1509078497$gmane$org@axentia.se>
References: <1498111597-10714-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1498111597-10714-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, Daniel Vetter <daniel.vetter@intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Russell King <linux@armlinux.org.uk>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>, intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Vincent Abriou <vincent.abriou@st.com>, Philippe Cornu <philippe.cornu@st.com>, Peter Rosin <peda@axentia.se>, Yannick Fertre <yannick.fertre@st.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

Drivers no longer have any need for these callbacks, and there are no
users. Zap. Zap-zap-zzzap-p-pp-p.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 include/drm/drm_fb_helper.h              | 32 --------------------------------
 include/drm/drm_modeset_helper_vtables.h | 16 ----------------
 2 files changed, 48 deletions(-)

diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 119e5e4..80d9853 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -85,38 +85,6 @@ struct drm_fb_helper_surface_size {
  */
 struct drm_fb_helper_funcs {
 	/**
-	 * @gamma_set:
-	 *
-	 * Set the given gamma LUT register on the given CRTC.
-	 *
-	 * This callback is optional.
-	 *
-	 * FIXME:
-	 *
-	 * This callback is functionally redundant with the core gamma table
-	 * support and simply exists because the fbdev hasn't yet been
-	 * refactored to use the core gamma table interfaces.
-	 */
-	void (*gamma_set)(struct drm_crtc *crtc, u16 red, u16 green,
-			  u16 blue, int regno);
-	/**
-	 * @gamma_get:
-	 *
-	 * Read the given gamma LUT register on the given CRTC, used to save the
-	 * current LUT when force-restoring the fbdev for e.g. kdbg.
-	 *
-	 * This callback is optional.
-	 *
-	 * FIXME:
-	 *
-	 * This callback is functionally redundant with the core gamma table
-	 * support and simply exists because the fbdev hasn't yet been
-	 * refactored to use the core gamma table interfaces.
-	 */
-	void (*gamma_get)(struct drm_crtc *crtc, u16 *red, u16 *green,
-			  u16 *blue, int regno);
-
-	/**
 	 * @fb_probe:
 	 *
 	 * Driver callback to allocate and initialize the fbdev info structure.
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 85984b2..0773db9 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -267,22 +267,6 @@ struct drm_crtc_helper_funcs {
 				    enum mode_set_atomic);
 
 	/**
-	 * @load_lut:
-	 *
-	 * Load a LUT prepared with the &drm_fb_helper_funcs.gamma_set vfunc.
-	 *
-	 * This callback is optional and is only used by the fbdev emulation
-	 * helpers.
-	 *
-	 * FIXME:
-	 *
-	 * This callback is functionally redundant with the core gamma table
-	 * support and simply exists because the fbdev hasn't yet been
-	 * refactored to use the core gamma table interfaces.
-	 */
-	void (*load_lut)(struct drm_crtc *crtc);
-
-	/**
 	 * @disable:
 	 *
 	 * This callback should be used to disable the CRTC. With the atomic
-- 
2.1.4
