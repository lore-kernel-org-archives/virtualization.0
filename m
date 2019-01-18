From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 08/23] drm/qxl: use QXL_GEM_DOMAIN_SURFACE for shadow bo.
Date: Fri, 18 Jan 2019 13:20:05 +0100
Message-ID: <20190118122020.27596-9-kraxel__10044.7745797739$1547814146$gmane$org@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The shadow bo is used as qxl surface, so allocate it as
QXL_GEM_DOMAIN_SURFACE.  Should usually be allocated in
PRIV ttm domain then, so this reduces VRAM memory pressure.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 1f8fddcc34..86bfc19bea 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -758,7 +758,7 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 			user_bo->shadow = old_bo->shadow;
 		} else {
 			qxl_bo_create(qdev, user_bo->gem_base.size,
-				      true, true, QXL_GEM_DOMAIN_VRAM, NULL,
+				      true, true, QXL_GEM_DOMAIN_SURFACE, NULL,
 				      &user_bo->shadow);
 		}
 	}
-- 
2.9.3
