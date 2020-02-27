From: Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] drm/bochs: Remove vga write
Date: Thu, 27 Feb 2020 13:04:54 -0800
Message-ID: <20200227210454.18217-1-alistair.francis@wdc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com, alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>, Khem Raj <raj.khem@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

The QEMU model for the Bochs display has no VGA memory section at offset
0x400 [1]. By writing to this register Linux can create a write to
unassigned memory which depending on machine and architecture can result
in a store fault.

I don't see any reference to this address at OSDev [2] or in the Bochs
source code.

Removing this write still allows graphics to work inside QEMU with
the bochs-display.

1: https://gitlab.com/qemu-project/qemu/-/blob/master/hw/display/bochs-display.c#L264
2. https://wiki.osdev.org/Bochs_VBE_Extensions

Reported-by: Khem Raj <raj.khem@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/gpu/drm/bochs/bochs_hw.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index b615b7dfdd9d..dfb2a5363c62 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -10,19 +10,6 @@
 
 /* ---------------------------------------------------------------------- */
 
-static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
-{
-	if (WARN_ON(ioport < 0x3c0 || ioport > 0x3df))
-		return;
-
-	if (bochs->mmio) {
-		int offset = ioport - 0x3c0 + 0x400;
-		writeb(val, bochs->mmio + offset);
-	} else {
-		outb(val, ioport);
-	}
-}
-
 static u16 bochs_dispi_read(struct bochs_device *bochs, u16 reg)
 {
 	u16 ret = 0;
@@ -217,8 +204,6 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 			 bochs->xres, bochs->yres, bochs->bpp,
 			 bochs->yres_virtual);
 
-	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
-
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,      0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BPP,         bochs->bpp);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_XRES,        bochs->xres);
-- 
2.25.0
