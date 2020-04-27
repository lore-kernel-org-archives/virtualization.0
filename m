From: Vasily Averin <vvs-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 1/2] drm/qxl: qxl_release leak in qxl_draw_dirty_fb()
Date: Mon, 27 Apr 2020 08:32:46 +0300
Message-ID: <22cfd55f-07c8-95d0-a2f7-191b7153c3d4@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.openvz.org/mailman/options/devel>,
	<mailto:devel-request-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.openvz.org/pipermail/devel/>
List-Post: <mailto:devel-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org>
List-Help: <mailto:devel-request-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://lists.openvz.org/mailman/listinfo/devel>,
	<mailto:devel-request-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: devel-bounces-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org
Errors-To: devel-bounces-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org
To: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, spice-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, OpenVZ devel <devel-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

ret should be changed to release allocated struct qxl_release

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Fixes: 8002db6336dd ("qxl: convert qxl driver to proper use for reservations")
Signed-off-by: Vasily Averin <vvs-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>
---
 drivers/gpu/drm/qxl/qxl_draw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 5bebf1ea1c5d..f8776d60d08e 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -209,9 +209,10 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		goto out_release_backoff;
 
 	rects = drawable_set_clipping(qdev, num_clips, clips_bo);
-	if (!rects)
+	if (!rects) {
+		ret = -EINVAL;
 		goto out_release_backoff;
-
+	}
 	drawable = (struct qxl_drawable *)qxl_release_map(qdev, release);
 
 	drawable->clip.type = SPICE_CLIP_TYPE_RECTS;
-- 
2.17.1
