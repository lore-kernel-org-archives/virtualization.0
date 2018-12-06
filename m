From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/3] drm/qxl: allow both PRIV and VRAM placement for
	QXL_GEM_DOMAIN_SURFACE
Date: Thu,  6 Dec 2018 11:46:36 +0100
Message-ID: <20181206104638.23330-2-kraxel__4002.41957181624$1544093111$gmane$org@redhat.com>
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

qxl surfaces (used for framebuffers and gem objects) can live in both
VRAM and PRIV ttm domains.  Update placement setup to include both.  Put
PRIV first in the list so it is preferred, so VRAM will have more room
for objects which must be allocated there.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 91f3bbc73e..f7f9f4f4fe 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -58,10 +58,10 @@ void qxl_ttm_placement_from_domain(struct qxl_bo *qbo, u32 domain, bool pinned)
 
 	qbo->placement.placement = qbo->placements;
 	qbo->placement.busy_placement = qbo->placements;
-	if (domain == QXL_GEM_DOMAIN_VRAM)
-		qbo->placements[c++].flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_VRAM | pflag;
 	if (domain == QXL_GEM_DOMAIN_SURFACE)
 		qbo->placements[c++].flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_PRIV | pflag;
+	if (domain == QXL_GEM_DOMAIN_SURFACE || domain == QXL_GEM_DOMAIN_VRAM)
+		qbo->placements[c++].flags = TTM_PL_FLAG_CACHED | TTM_PL_FLAG_VRAM | pflag;
 	if (domain == QXL_GEM_DOMAIN_CPU)
 		qbo->placements[c++].flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM | pflag;
 	if (!c)
-- 
2.9.3
