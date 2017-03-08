From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/4] qxl: drop mode_info.modes & related code.
Date: Wed,  8 Mar 2017 10:19:02 +0100
Message-ID: <1488964751-22763-3-git-send-email-kraxel__16872.7549644702$1488964812$gmane$org@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-rpi-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, David Airlie <airlied@linux.ie>, catalin.marinas@arm.com, will.deacon@arm.com, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, lee@kernel.org, linux@armlinux.org.uk, bcm-kernel-feedback-list@broadcom.com, Dave Airlie <airlied@redhat.com>, devicetree@vger.kernel.org, rjui@broadcom.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

very old qxl hardware revisions (predating qxl ksm support by a few
years) supported a fixed list of video modes only.  The list is still
provided by the virtual hardware, for backward compatibility reasons.

The qxl kms driver never ever looks at it, except for dumping it to
the kernel log at load time in case debug logging is enabled.  Drop
that pointless code.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h |  2 --
 drivers/gpu/drm/qxl/qxl_kms.c | 22 ----------------------
 2 files changed, 24 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 0c313e5..fe90b36 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -160,8 +160,6 @@ struct qxl_mman {
 };
 
 struct qxl_mode_info {
-	int num_modes;
-	struct qxl_mode *modes;
 	bool mode_config_initialized;
 
 	/* pointer to fbdev info structure */
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 2b1e1f3..a9a741c 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -31,19 +31,9 @@
 
 int qxl_log_level;
 
-static void qxl_dump_mode(struct qxl_device *qdev, void *p)
-{
-	struct qxl_mode *m = p;
-	DRM_DEBUG_KMS("%d: %dx%d %d bits, stride %d, %dmm x %dmm, orientation %d\n",
-		      m->id, m->x_res, m->y_res, m->bits, m->stride, m->x_mili,
-		      m->y_mili, m->orientation);
-}
-
 static bool qxl_check_device(struct qxl_device *qdev)
 {
 	struct qxl_rom *rom = qdev->rom;
-	int mode_offset;
-	int i;
 
 	if (rom->magic != 0x4f525851) {
 		DRM_ERROR("bad rom signature %x\n", rom->magic);
@@ -53,8 +43,6 @@ static bool qxl_check_device(struct qxl_device *qdev)
 	DRM_INFO("Device Version %d.%d\n", rom->id, rom->update_id);
 	DRM_INFO("Compression level %d log level %d\n", rom->compression_level,
 		 rom->log_level);
-	DRM_INFO("Currently using mode #%d, list at 0x%x\n",
-		 rom->mode, rom->modes_offset);
 	DRM_INFO("%d io pages at offset 0x%x\n",
 		 rom->num_io_pages, rom->pages_offset);
 	DRM_INFO("%d byte draw area at offset 0x%x\n",
@@ -62,14 +50,6 @@ static bool qxl_check_device(struct qxl_device *qdev)
 
 	qdev->vram_size = rom->surface0_area_size;
 	DRM_INFO("RAM header offset: 0x%x\n", rom->ram_header_offset);
-
-	mode_offset = rom->modes_offset / 4;
-	qdev->mode_info.num_modes = ((u32 *)rom)[mode_offset];
-	DRM_INFO("rom modes offset 0x%x for %d modes\n", rom->modes_offset,
-		 qdev->mode_info.num_modes);
-	qdev->mode_info.modes = (void *)((uint32_t *)rom + mode_offset + 1);
-	for (i = 0; i < qdev->mode_info.num_modes; i++)
-		qxl_dump_mode(qdev, qdev->mode_info.modes + i);
 	return true;
 }
 
@@ -282,7 +262,5 @@ void qxl_device_fini(struct qxl_device *qdev)
 	iounmap(qdev->ram_header);
 	iounmap(qdev->rom);
 	qdev->rom = NULL;
-	qdev->mode_info.modes = NULL;
-	qdev->mode_info.num_modes = 0;
 	qxl_debugfs_remove_files(qdev);
 }
-- 
1.8.3.1
