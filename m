From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 02/23] drm/qxl: drop unused qxl_fb_virtual_address
Date: Fri, 18 Jan 2019 13:19:59 +0100
Message-ID: <20190118122020.27596-3-kraxel__20803.4633230001$1547814246$gmane$org@redhat.com>
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
 drivers/gpu/drm/qxl/qxl_drv.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 38c5a8b1df..7eabf4a9ed 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -308,13 +308,6 @@ void qxl_ring_free(struct qxl_ring *ring);
 void qxl_ring_init_hdr(struct qxl_ring *ring);
 int qxl_check_idle(struct qxl_ring *ring);
 
-static inline void *
-qxl_fb_virtual_address(struct qxl_device *qdev, unsigned long physical)
-{
-	DRM_DEBUG_DRIVER("not implemented (%lu)\n", physical);
-	return 0;
-}
-
 static inline uint64_t
 qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
 			unsigned long offset)
-- 
2.9.3
