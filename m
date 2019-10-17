From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5/5] drm/qxl: allocate small objects top-down
Date: Thu, 17 Oct 2019 15:26:38 +0200
Message-ID: <20191017132638.9693-6-kraxel__21591.1747467302$1571318839$gmane$org@redhat.com>
References: <20191017132638.9693-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191017132638.9693-1-kraxel@redhat.com>
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

qxl uses small buffer objects for qxl commands.
Allocate them top-down to reduce fragmentation.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_object.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 927ab917b834..ad336c98a0cf 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -54,9 +54,14 @@ bool qxl_ttm_bo_is_qxl_bo(struct ttm_buffer_object *bo)
 void qxl_ttm_placement_from_domain(struct qxl_bo *qbo, u32 domain, bool pinned)
 {
 	u32 c = 0;
-	u32 pflag = pinned ? TTM_PL_FLAG_NO_EVICT : 0;
+	u32 pflag = 0;
 	unsigned int i;
 
+	if (pinned)
+		pflag |= TTM_PL_FLAG_NO_EVICT;
+	if (qbo->tbo.base.size <= PAGE_SIZE)
+		pflag |= TTM_PL_FLAG_TOPDOWN;
+
 	qbo->placement.placement = qbo->placements;
 	qbo->placement.busy_placement = qbo->placements;
 	if (domain == QXL_GEM_DOMAIN_VRAM)
-- 
2.18.1
