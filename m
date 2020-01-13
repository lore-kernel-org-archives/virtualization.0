From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/4] drm/ast: Set struct drm_crtc_state.no_vblank in
 atomic_check()
Date: Mon, 13 Jan 2020 11:38:20 +0100
Message-ID: <20200113103822.24473-3-tzimmermann@suse.de>
References: <20200113103822.24473-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200113103822.24473-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, hdegoede@redhat.com, david@lechnology.com, noralf@tronnes.org, sean@poorly.run, oleksandr_andrushchenko@epam.com, sam@ravnborg.org, laurent.pinchart@ideasonboard.com, emil.velikov@collabora.com
Cc: xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.or, Thomas Zimmermann <tzimmermann@suse.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CRTC state properties should be computed in atomic_check(). Do so for
the no_vblank field.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_mode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 34608f0499eb..ef7a0b08cc05 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -800,6 +800,8 @@ static int ast_crtc_helper_atomic_check(struct drm_crtc *crtc,
 		return -EINVAL;
 	}
 
+	state->no_vblank = true;
+
 	ast_state = to_ast_crtc_state(state);
 
 	format = ast_state->format;
@@ -833,8 +835,6 @@ static void ast_crtc_helper_atomic_flush(struct drm_crtc *crtc,
 	struct ast_vbios_mode_info *vbios_mode_info;
 	struct drm_display_mode *adjusted_mode;
 
-	crtc->state->no_vblank = true;
-
 	ast_state = to_ast_crtc_state(crtc->state);
 
 	format = ast_state->format;
-- 
2.24.1
