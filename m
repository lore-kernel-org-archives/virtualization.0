From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 03/23] drm/qxl: simplify slot management
Date: Fri, 18 Jan 2019 13:20:00 +0100
Message-ID: <20190118122020.27596-4-kraxel__2484.52228629521$1547813913$gmane$org@redhat.com>
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

Drop pointless indirection, remove the mem_slots array and index
variables, drop dynamic allocation.  Store memslots in qxl_device
instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h | 15 +++++----
 drivers/gpu/drm/qxl/qxl_kms.c | 72 +++++++++++++++++--------------------------
 2 files changed, 36 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 7eabf4a9ed..f9dddfe7d9 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -130,9 +130,11 @@ struct qxl_mman {
 };
 
 struct qxl_memslot {
+	int             index;
+	const char      *name;
 	uint8_t		generation;
 	uint64_t	start_phys_addr;
-	uint64_t	end_phys_addr;
+	uint64_t	size;
 	uint64_t	high_bits;
 };
 
@@ -228,11 +230,8 @@ struct qxl_device {
 
 	unsigned int primary_created:1;
 
-	struct qxl_memslot	*mem_slots;
-	uint8_t		n_mem_slots;
-
-	uint8_t		main_mem_slot;
-	uint8_t		surfaces_mem_slot;
+	struct qxl_memslot main_slot;
+	struct qxl_memslot surfaces_slot;
 	uint8_t		slot_id_bits;
 	uint8_t		slot_gen_bits;
 	uint64_t	va_slot_mask;
@@ -312,8 +311,8 @@ static inline uint64_t
 qxl_bo_physical_address(struct qxl_device *qdev, struct qxl_bo *bo,
 			unsigned long offset)
 {
-	int slot_id = bo->type == QXL_GEM_DOMAIN_VRAM ? qdev->main_mem_slot : qdev->surfaces_mem_slot;
-	struct qxl_memslot *slot = &(qdev->mem_slots[slot_id]);
+	struct qxl_memslot *slot = bo->type == QXL_GEM_DOMAIN_VRAM
+		? &qdev->main_slot : &qdev->surfaces_slot;
 
 	/* TODO - need to hold one of the locks to read tbo.offset */
 	return slot->high_bits | (bo->tbo.offset + offset);
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 15238a413f..a9288100ae 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -53,40 +53,46 @@ static bool qxl_check_device(struct qxl_device *qdev)
 	return true;
 }
 
-static void setup_hw_slot(struct qxl_device *qdev, int slot_index,
-			  struct qxl_memslot *slot)
+static void setup_hw_slot(struct qxl_device *qdev, struct qxl_memslot *slot)
 {
 	qdev->ram_header->mem_slot.mem_start = slot->start_phys_addr;
-	qdev->ram_header->mem_slot.mem_end = slot->end_phys_addr;
-	qxl_io_memslot_add(qdev, slot_index);
+	qdev->ram_header->mem_slot.mem_end = slot->start_phys_addr + slot->size;
+	qxl_io_memslot_add(qdev, qdev->rom->slots_start + slot->index);
 }
 
-static uint8_t setup_slot(struct qxl_device *qdev, uint8_t slot_index_offset,
-	unsigned long start_phys_addr, unsigned long end_phys_addr)
+static void setup_slot(struct qxl_device *qdev,
+		       struct qxl_memslot *slot,
+		       unsigned int slot_index,
+		       const char *slot_name,
+		       unsigned long start_phys_addr,
+		       unsigned long size)
 {
 	uint64_t high_bits;
-	struct qxl_memslot *slot;
-	uint8_t slot_index;
 
-	slot_index = qdev->rom->slots_start + slot_index_offset;
-	slot = &qdev->mem_slots[slot_index];
+	slot->index = slot_index;
+	slot->name = slot_name;
 	slot->start_phys_addr = start_phys_addr;
-	slot->end_phys_addr = end_phys_addr;
+	slot->size = size;
 
-	setup_hw_slot(qdev, slot_index, slot);
+	setup_hw_slot(qdev, slot);
 
 	slot->generation = qdev->rom->slot_generation;
-	high_bits = slot_index << qdev->slot_gen_bits;
+	high_bits = (qdev->rom->slots_start + slot->index)
+		<< qdev->slot_gen_bits;
 	high_bits |= slot->generation;
 	high_bits <<= (64 - (qdev->slot_gen_bits + qdev->slot_id_bits));
 	slot->high_bits = high_bits;
-	return slot_index;
+
+	DRM_INFO("slot %d (%s): base 0x%08lx, size 0x%08lx\n",
+		 slot->index, slot->name,
+		 (unsigned long)slot->start_phys_addr,
+		 (unsigned long)slot->size);
 }
 
 void qxl_reinit_memslots(struct qxl_device *qdev)
 {
-	setup_hw_slot(qdev, qdev->main_mem_slot, &qdev->mem_slots[qdev->main_mem_slot]);
-	setup_hw_slot(qdev, qdev->surfaces_mem_slot, &qdev->mem_slots[qdev->surfaces_mem_slot]);
+	setup_hw_slot(qdev, &qdev->main_slot);
+	setup_hw_slot(qdev, &qdev->surfaces_slot);
 }
 
 static void qxl_gc_work(struct work_struct *work)
@@ -231,22 +237,11 @@ int qxl_device_init(struct qxl_device *qdev,
 	}
 	/* TODO - slot initialization should happen on reset. where is our
 	 * reset handler? */
-	qdev->n_mem_slots = qdev->rom->slots_end;
 	qdev->slot_gen_bits = qdev->rom->slot_gen_bits;
 	qdev->slot_id_bits = qdev->rom->slot_id_bits;
 	qdev->va_slot_mask =
 		(~(uint64_t)0) >> (qdev->slot_id_bits + qdev->slot_gen_bits);
 
-	qdev->mem_slots =
-		kmalloc_array(qdev->n_mem_slots, sizeof(struct qxl_memslot),
-			      GFP_KERNEL);
-
-	if (!qdev->mem_slots) {
-		DRM_ERROR("Unable to alloc mem slots\n");
-		r = -ENOMEM;
-		goto release_ring_free;
-	}
-
 	idr_init(&qdev->release_idr);
 	spin_lock_init(&qdev->release_idr_lock);
 	spin_lock_init(&qdev->release_lock);
@@ -264,33 +259,24 @@ int qxl_device_init(struct qxl_device *qdev,
 	r = qxl_irq_init(qdev);
 	if (r) {
 		DRM_ERROR("Unable to init qxl irq\n");
-		goto mem_slots_free;
+		goto release_ring_free;
 	}
 
 	/*
 	 * Note that virtual is surface0. We rely on the single ioremap done
 	 * before.
 	 */
-	qdev->main_mem_slot = setup_slot(qdev, 0,
-		(unsigned long)qdev->vram_base,
-		(unsigned long)qdev->vram_base + qdev->rom->ram_header_offset);
-	qdev->surfaces_mem_slot = setup_slot(qdev, 1,
-		(unsigned long)qdev->surfaceram_base,
-		(unsigned long)qdev->surfaceram_base + qdev->surfaceram_size);
-	DRM_INFO("main mem slot %d [%lx,%x]\n",
-		 qdev->main_mem_slot,
-		 (unsigned long)qdev->vram_base, qdev->rom->ram_header_offset);
-	DRM_INFO("surface mem slot %d [%lx,%lx]\n",
-		 qdev->surfaces_mem_slot,
-		 (unsigned long)qdev->surfaceram_base,
-		 (unsigned long)qdev->surfaceram_size);
+	setup_slot(qdev, &qdev->main_slot, 0, "main",
+		   (unsigned long)qdev->vram_base,
+		   (unsigned long)qdev->rom->ram_header_offset);
+	setup_slot(qdev, &qdev->surfaces_slot, 1, "surfaces",
+		   (unsigned long)qdev->surfaceram_base,
+		   (unsigned long)qdev->surfaceram_size);
 
 	INIT_WORK(&qdev->gc_work, qxl_gc_work);
 
 	return 0;
 
-mem_slots_free:
-	kfree(qdev->mem_slots);
 release_ring_free:
 	qxl_ring_free(qdev->release_ring);
 cursor_ring_free:
-- 
2.9.3
