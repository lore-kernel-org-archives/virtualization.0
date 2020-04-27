From: Vasily Averin <vvs-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 2/2] drm/qxl: qxl_release leak in
	qxl_hw_surface_alloc()
Date: Mon, 27 Apr 2020 08:32:51 +0300
Message-ID: <2e5a13ae-9ab2-5401-aa4d-03d5f5593423@virtuozzo.com>
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

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Fixes: 8002db6336dd ("qxl: convert qxl driver to proper use for reservations")
Signed-off-by: Vasily Averin <vvs-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>
---
 drivers/gpu/drm/qxl/qxl_cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index d1086b2a6892..fa8762d15d0f 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -480,9 +480,10 @@ int qxl_hw_surface_alloc(struct qxl_device *qdev,
 		return ret;
 
 	ret = qxl_release_reserve_list(release, true);
-	if (ret)
+	if (ret) {
+		qxl_release_free(qdev, release);
 		return ret;
-
+	}
 	cmd = (struct qxl_surface_cmd *)qxl_release_map(qdev, release);
 	cmd->type = QXL_SURFACE_CMD_CREATE;
 	cmd->flags = QXL_SURF_FLAG_KEEP_DATA;
-- 
2.17.1
