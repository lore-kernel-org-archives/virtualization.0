From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/3] drm/qxl: use QXL_GEM_DOMAIN_SURFACE for shadow bo.
Date: Thu,  6 Dec 2018 11:46:37 +0100
Message-ID: <20181206104638.23330-3-kraxel__48651.2298616164$1544093094$gmane$org@redhat.com>
References: <20181206104638.23330-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181206104638.23330-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The shadow bo is used as qxl surface, so allocate it as
QXL_GEM_DOMAIN_SURFACE.  Should usually be allocated in
PRIV ttm domain then, so this reduces VRAM memory pressure.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index ce0b9c40fc..1dde3b2ecb 100644
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
