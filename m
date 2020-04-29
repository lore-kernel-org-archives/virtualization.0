From: Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2] drm/qxl: lost qxl_bo_kunmap_atomic_page in
 qxl_image_init_helper()
Date: Wed, 29 Apr 2020 12:34:36 +0300
Message-ID: <a4e0ae09-a73c-1c62-04ef-3f990d41bea9@virtuozzo.com>
References: <20200428100831.a4525pdp335ffkgi@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spice-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20200428100831.a4525pdp335ffkgi@sirius.home.kraxel.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/spice-devel>,
 <mailto:spice-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/spice-devel>
List-Post: <mailto:spice-devel@lists.freedesktop.org>
List-Help: <mailto:spice-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/spice-devel>,
 <mailto:spice-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: spice-devel-bounces@lists.freedesktop.org
Sender: "Spice-devel" <spice-devel-bounces@lists.freedesktop.org>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

v2: removed TODO reminder

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/gpu/drm/qxl/qxl_image.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_image.c b/drivers/gpu/drm/qxl/qxl_image.c
index 43688ecdd8a0..60ab7151b84d 100644
--- a/drivers/gpu/drm/qxl/qxl_image.c
+++ b/drivers/gpu/drm/qxl/qxl_image.c
@@ -212,7 +212,8 @@ qxl_image_init_helper(struct qxl_device *qdev,
 		break;
 	default:
 		DRM_ERROR("unsupported image bit depth\n");
-		return -EINVAL; /* TODO: cleanup */
+		qxl_bo_kunmap_atomic_page(qdev, image_bo, ptr);
+		return -EINVAL;
 	}
 	image->u.bitmap.flags = QXL_BITMAP_TOP_DOWN;
 	image->u.bitmap.x = width;
-- 
2.17.1
