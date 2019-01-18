From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 19/23] drm/qxl: implement qxl_gem_prime_(un)pin
Date: Fri, 18 Jan 2019 13:20:16 +0100
Message-ID: <20190118122020.27596-20-kraxel__19761.6356112578$1547814043$gmane$org@redhat.com>
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_prime.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index 708378844c..22e1faf047 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -22,6 +22,7 @@
  * Authors: Andreas Pokorny
  */
 
+#include "qxl_drv.h"
 #include "qxl_object.h"
 
 /* Empty Implementations as there should not be any other driver for a virtual
@@ -29,13 +30,16 @@
 
 int qxl_gem_prime_pin(struct drm_gem_object *obj)
 {
-	WARN_ONCE(1, "not implemented");
-	return -ENOSYS;
+	struct qxl_bo *bo = gem_to_qxl_bo(obj);
+
+	return qxl_bo_pin(bo);
 }
 
 void qxl_gem_prime_unpin(struct drm_gem_object *obj)
 {
-	WARN_ONCE(1, "not implemented");
+	struct qxl_bo *bo = gem_to_qxl_bo(obj);
+
+	qxl_bo_unpin(bo);
 }
 
 struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
-- 
2.9.3
