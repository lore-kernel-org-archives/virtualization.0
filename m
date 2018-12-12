From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 05/18] drm/qxl: drop unused fields from struct qxl_device
Date: Wed, 12 Dec 2018 14:20:56 +0100
Message-ID: <20181212132109.8126-6-kraxel__21753.9006415338$1544620792$gmane$org@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, spice-devel@redhat.com, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

slot_id_bits and slot_gen_bits can be read directly from qxlrom instead.
va_slot_mask is never used anywhere.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h |  3 ---
 drivers/gpu/drm/qxl/qxl_kms.c | 10 ++--------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index d015d4fff1..3ebe66abf2 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -232,9 +232,6 @@ struct qxl_device {
 
 	struct qxl_memslot main_slot;
 	struct qxl_memslot surfaces_slot;
-	uint8_t		slot_id_bits;
-	uint8_t		slot_gen_bits;
-	uint64_t	va_slot_mask;
 
 	spinlock_t	release_lock;
 	struct idr	release_idr;
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index a9288100ae..3c1753667d 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -78,9 +78,9 @@ static void setup_slot(struct qxl_device *qdev,
 
 	slot->generation = qdev->rom->slot_generation;
 	high_bits = (qdev->rom->slots_start + slot->index)
-		<< qdev->slot_gen_bits;
+		<< qdev->rom->slot_gen_bits;
 	high_bits |= slot->generation;
-	high_bits <<= (64 - (qdev->slot_gen_bits + qdev->slot_id_bits));
+	high_bits <<= (64 - (qdev->rom->slot_gen_bits + qdev->rom->slot_id_bits));
 	slot->high_bits = high_bits;
 
 	DRM_INFO("slot %d (%s): base 0x%08lx, size 0x%08lx\n",
@@ -235,12 +235,6 @@ int qxl_device_init(struct qxl_device *qdev,
 		r = -ENOMEM;
 		goto cursor_ring_free;
 	}
-	/* TODO - slot initialization should happen on reset. where is our
-	 * reset handler? */
-	qdev->slot_gen_bits = qdev->rom->slot_gen_bits;
-	qdev->slot_id_bits = qdev->rom->slot_id_bits;
-	qdev->va_slot_mask =
-		(~(uint64_t)0) >> (qdev->slot_id_bits + qdev->slot_gen_bits);
 
 	idr_init(&qdev->release_idr);
 	spin_lock_init(&qdev->release_idr_lock);
-- 
2.9.3
