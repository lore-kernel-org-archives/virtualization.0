From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 06/23] drm/qxl: use separate offset spaces for the two
	slots / ttm memory types.
Date: Fri, 18 Jan 2019 13:20:03 +0100
Message-ID: <20190118122020.27596-7-kraxel__39715.8904270784$1547813942$gmane$org@redhat.com>
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

Without that ttm offsets are not unique, they can refer to objects
in both VRAM and PRIV memory (aka main and surfaces slot).

One of those "why things didn't blow up without this" moments.
Probably offset conflicts are rare enough by pure luck.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h |  5 ++++-
 drivers/gpu/drm/qxl/qxl_kms.c |  5 +++--
 drivers/gpu/drm/qxl/qxl_ttm.c | 10 +++++++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 3ebe66abf2..27e0a3fc08 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -136,6 +136,7 @@ struct qxl_memslot {
 	uint64_t	start_phys_addr;
 	uint64_t	size;
 	uint64_t	high_bits;
+	uint64_t        gpu_offset;
 };
 
 enum {
@@ -312,8 +313,10 @@ qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
 		(bo->tbo.mem.mem_type == TTM_PL_VRAM)
 		? &qdev->main_slot : &qdev->surfaces_slot;
 
+	WARN_ON_ONCE((bo->tbo.offset & slot->gpu_offset) != slot->gpu_offset);
+
 	/* TODO - need to hold one of the locks to read tbo.offset */
-	return slot->high_bits | (bo->tbo.offset + offset);
+	return slot->high_bits | (bo->tbo.offset - slot->gpu_offset + offset);
 }
 
 /* qxl_fb.c */
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 3c1753667d..82c764623f 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -83,10 +83,11 @@ static void setup_slot(struct qxl_device *qdev,
 	high_bits <<= (64 - (qdev->rom->slot_gen_bits + qdev->rom->slot_id_bits));
 	slot->high_bits = high_bits;
 
-	DRM_INFO("slot %d (%s): base 0x%08lx, size 0x%08lx\n",
+	DRM_INFO("slot %d (%s): base 0x%08lx, size 0x%08lx, gpu_offset 0x%lx\n",
 		 slot->index, slot->name,
 		 (unsigned long)slot->start_phys_addr,
-		 (unsigned long)slot->size);
+		 (unsigned long)slot->size,
+		 (unsigned long)slot->gpu_offset);
 }
 
 void qxl_reinit_memslots(struct qxl_device *qdev)
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 886f61e94f..36ea993aac 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -100,6 +100,11 @@ static int qxl_invalidate_caches(struct ttm_bo_device *bdev, uint32_t flags)
 static int qxl_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 			     struct ttm_mem_type_manager *man)
 {
+	struct qxl_device *qdev = qxl_get_qdev(bdev);
+	unsigned int gpu_offset_shift =
+		64 - (qdev->rom->slot_gen_bits + qdev->rom->slot_id_bits + 8);
+	struct qxl_memslot *slot;
+
 	switch (type) {
 	case TTM_PL_SYSTEM:
 		/* System memory */
@@ -110,8 +115,11 @@ static int qxl_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 	case TTM_PL_VRAM:
 	case TTM_PL_PRIV:
 		/* "On-card" video ram */
+		slot = (type == TTM_PL_VRAM) ?
+			&qdev->main_slot : &qdev->surfaces_slot;
+		slot->gpu_offset = (uint64_t)type << gpu_offset_shift;
 		man->func = &ttm_bo_manager_func;
-		man->gpu_offset = 0;
+		man->gpu_offset = slot->gpu_offset;
 		man->flags = TTM_MEMTYPE_FLAG_FIXED |
 			     TTM_MEMTYPE_FLAG_MAPPABLE;
 		man->available_caching = TTM_PL_MASK_CACHING;
-- 
2.9.3
