From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 6/8] drm/qxl: switch to gem vma offset manager
Date: Thu,  5 Sep 2019 09:05:07 +0200
Message-ID: <20190905070509.22407-7-kraxel__31357.2963512101$1576332933$gmane$org@redhat.com>
References: <20190905070509.22407-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905070509.22407-1-kraxel@redhat.com>
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

Pass gem vma_offset_manager to ttm_bo_device_init(), so ttm uses it
instead of its own embedded struct.  This makes some gem functions
(specifically drm_gem_object_lookup) work on ttm objects.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 69da0eea6e4c..cbc6c2ba8630 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -325,7 +325,7 @@ int qxl_ttm_init(struct qxl_device *qdev)
 	r = ttm_bo_device_init(&qdev->mman.bdev,
 			       &qxl_bo_driver,
 			       qdev->ddev.anon_inode->i_mapping,
-			       NULL,
+			       qdev->ddev.vma_offset_manager,
 			       false);
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
-- 
2.18.1
