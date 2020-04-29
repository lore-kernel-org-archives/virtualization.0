From: Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] drm/qxl: qxl_release use after free
Date: Wed, 29 Apr 2020 12:01:24 +0300
Message-ID: <fa17b338-66ae-f299-68fe-8d32419d9071@virtuozzo.com>
References: <20200429082837.uedcapxmennuc5a2@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spice-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20200429082837.uedcapxmennuc5a2@sirius.home.kraxel.org>
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, spice-devel@lists.freedesktop.org, Caicai <caizhaopeng@uniontech.com>
List-Id: virtualization@lists.linuxfoundation.org

qxl_release should not be accesses after qxl_push_*_ring_release() calls:
userspace driver can process submitted command quickly, move qxl_release
into release_ring, generate interrupt and trigger garbage collector.

It can lead to crashes in qxl driver or trigger memory corruption
in some kmalloc-192 slab object

Gerd Hoffmann proposes to swap the qxl_release_fence_buffer_objects() +
qxl_push_{cursor,command}_ring_release() calls to close that race window.

cc: stable@vger.kernel.org
Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 drivers/gpu/drm/qxl/qxl_cmd.c     | 5 ++---
 drivers/gpu/drm/qxl/qxl_display.c | 6 +++---
 drivers/gpu/drm/qxl/qxl_draw.c    | 2 +-
 drivers/gpu/drm/qxl/qxl_ioctl.c   | 5 +----
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index fa8762d15d0f..05863b253d68 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -500,8 +500,8 @@ int qxl_hw_surface_alloc(struct qxl_device *qdev,
 	/* no need to add a release to the fence for this surface bo,
 	   since it is only released when we ask to destroy the surface
 	   and it would never signal otherwise */
-	qxl_push_command_ring_release(qdev, release, QXL_CMD_SURFACE, false);
 	qxl_release_fence_buffer_objects(release);
+	qxl_push_command_ring_release(qdev, release, QXL_CMD_SURFACE, false);
 
 	surf->hw_surf_alloc = true;
 	spin_lock(&qdev->surf_id_idr_lock);
@@ -543,9 +543,8 @@ int qxl_hw_surface_dealloc(struct qxl_device *qdev,
 	cmd->surface_id = id;
 	qxl_release_unmap(qdev, release, &cmd->release_info);
 
-	qxl_push_command_ring_release(qdev, release, QXL_CMD_SURFACE, false);
-
 	qxl_release_fence_buffer_objects(release);
+	qxl_push_command_ring_release(qdev, release, QXL_CMD_SURFACE, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 09583a08e141..91f398d51cfa 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -510,8 +510,8 @@ static int qxl_primary_apply_cursor(struct drm_plane *plane)
 	cmd->u.set.visible = 1;
 	qxl_release_unmap(qdev, release, &cmd->release_info);
 
-	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 	qxl_release_fence_buffer_objects(release);
+	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 
 	return ret;
 
@@ -652,8 +652,8 @@ static void qxl_cursor_atomic_update(struct drm_plane *plane,
 	cmd->u.position.y = plane->state->crtc_y + fb->hot_y;
 
 	qxl_release_unmap(qdev, release, &cmd->release_info);
-	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 	qxl_release_fence_buffer_objects(release);
+	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 
 	if (old_cursor_bo != NULL)
 		qxl_bo_unpin(old_cursor_bo);
@@ -700,8 +700,8 @@ static void qxl_cursor_atomic_disable(struct drm_plane *plane,
 	cmd->type = QXL_CURSOR_HIDE;
 	qxl_release_unmap(qdev, release, &cmd->release_info);
 
-	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 	qxl_release_fence_buffer_objects(release);
+	qxl_push_cursor_ring_release(qdev, release, QXL_CMD_CURSOR, false);
 }
 
 static void qxl_update_dumb_head(struct qxl_device *qdev,
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index f8776d60d08e..3599db096973 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -243,8 +243,8 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 	}
 	qxl_bo_kunmap(clips_bo);
 
-	qxl_push_command_ring_release(qdev, release, QXL_CMD_DRAW, false);
 	qxl_release_fence_buffer_objects(release);
+	qxl_push_command_ring_release(qdev, release, QXL_CMD_DRAW, false);
 
 out_release_backoff:
 	if (ret)
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 8117a45b3610..72f3f1bbb40c 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -261,11 +261,8 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 			apply_surf_reloc(qdev, &reloc_info[i]);
 	}
 
+	qxl_release_fence_buffer_objects(release);
 	ret = qxl_push_command_ring_release(qdev, release, cmd->type, true);
-	if (ret)
-		qxl_release_backoff_reserve_list(release);
-	else
-		qxl_release_fence_buffer_objects(release);
 
 out_free_bos:
 out_free_release:
-- 
2.17.1
