From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 10/23] drm/qxl: move qxl_primary_apply_cursor to correct
	place
Date: Fri, 18 Jan 2019 13:20:07 +0100
Message-ID: <20190118122020.27596-11-kraxel__26238.5642891333$1547813997$gmane$org@redhat.com>
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

The cursor must be set again after creating the primary surface.
Also drop the error message.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 86bfc19bea..1b700ef503 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -533,7 +533,6 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	    .x2 = plane->state->fb->width,
 	    .y2 = plane->state->fb->height
 	};
-	int ret;
 	bool same_shadow = false;
 
 	if (old_state->fb) {
@@ -554,16 +553,13 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 		if (!same_shadow)
 			qxl_io_destroy_primary(qdev);
 		bo_old->is_primary = false;
-
-		ret = qxl_primary_apply_cursor(plane);
-		if (ret)
-			DRM_ERROR(
-			"could not set cursor after creating primary");
 	}
 
 	if (!bo->is_primary) {
-		if (!same_shadow)
+		if (!same_shadow) {
 			qxl_io_create_primary(qdev, 0, bo);
+			qxl_primary_apply_cursor(plane);
+		}
 		bo->is_primary = true;
 	}
 
-- 
2.9.3
