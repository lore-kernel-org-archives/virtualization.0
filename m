From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 06/15] drm/bochs: atomic: use atomic set_config helper
Date: Thu, 10 Jan 2019 09:28:36 +0100
Message-ID: <20190110082845.3453-7-kraxel__46666.0762358972$1547108845$gmane$org@redhat.com>
References: <20190110082845.3453-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190110082845.3453-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: andr2000@gmail.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Conversion to atomic modesetting, step four.
Use atomic set_config helper for crtc.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index c6993c2d59..646f897cb2 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -150,7 +150,7 @@ static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
 
 /* These provide the minimum set of functions required to handle a CRTC */
 static const struct drm_crtc_funcs bochs_crtc_funcs = {
-	.set_config = drm_crtc_helper_set_config,
+	.set_config = drm_atomic_helper_set_config,
 	.destroy = drm_crtc_cleanup,
 	.page_flip = bochs_crtc_page_flip,
 	.reset = drm_atomic_helper_crtc_reset,
-- 
2.9.3
