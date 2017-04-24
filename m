From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/6] drm: fourcc byteorder: adapt bochs-drm to
	drm_mode_legacy_fb_format update
Date: Mon, 24 Apr 2017 08:25:30 +0200
Message-ID: <20170424062532.26722-5-kraxel__42604.8987581909$1493015156$gmane$org@redhat.com>
References: <20170424062532.26722-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170424062532.26722-1-kraxel@redhat.com>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>, David Airlie <airlied@linux.ie>, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>, open list <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Pekka Paalanen <ppaalanen@gmail.com>, Sean Paul <seanpaul@chromium.org>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Alex Deucher <alexdeucher@gmail.com>, Daniel Vetter <daniel.vetter@intel.com>, Ilia Mirkin <imirkin@alum.mit.edu>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 857755ac2d..781d35bdff 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -508,7 +508,7 @@ bochs_user_framebuffer_create(struct drm_device *dev,
 	       (mode_cmd->pixel_format >> 16) & 0xff,
 	       (mode_cmd->pixel_format >> 24) & 0xff);
 
-	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888)
+	if (mode_cmd->pixel_format != DRM_FORMAT_CPU_XRGB8888)
 		return ERR_PTR(-ENOENT);
 
 	obj = drm_gem_object_lookup(filp, mode_cmd->handles[0]);
-- 
2.9.3
