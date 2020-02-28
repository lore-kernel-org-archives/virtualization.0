From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/bochs: Remove vga write
Date: Fri, 28 Feb 2020 10:57:48 +0100
Message-ID: <20200228095748.uu4sqkz6y477eabc@sirius.home.kraxel.org>
References: <20200227210454.18217-1-alistair.francis@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200227210454.18217-1-alistair.francis@wdc.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: airlied@linux.ie, Khem Raj <raj.khem@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, daniel@ffwll.ch, alistair23@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 27, 2020 at 01:04:54PM -0800, Alistair Francis wrote:
> The QEMU model for the Bochs display has no VGA memory section at offset
> 0x400 [1]. By writing to this register Linux can create a write to
> unassigned memory which depending on machine and architecture can result
> in a store fault.
> 
> I don't see any reference to this address at OSDev [2] or in the Bochs
> source code.
> 
> Removing this write still allows graphics to work inside QEMU with
> the bochs-display.

It's not that simple.  The driver also handles the qemu stdvga (-device
VGA, -device secondary-vga) which *does* need the vga port write.
There is no way for the guest to figure whenever the device is
secondary-vga or bochs-display.

So how about fixing things on the host side?  Does qemu patch below
help?

Maybe another possible approach is to enable/disable vga access per
arch.  On x86 this doesn't cause any problems.  I guess you are on
risc-v?

cheers,
  Gerd

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 62085f9fc063..e93e838243b8 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -151,6 +151,26 @@ static const MemoryRegionOps bochs_display_qext_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
+static uint64_t dummy_read(void *ptr, hwaddr addr, unsigned size)
+{
+    return -1;
+}
+
+static void dummy_write(void *ptr, hwaddr addr,
+                        uint64_t val, unsigned size)
+{
+}
+
+static const MemoryRegionOps dummy_ops = {
+    .read = dummy_read,
+    .write = dummy_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 1,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
 static int bochs_display_get_mode(BochsDisplayState *s,
                                    BochsDisplayMode *mode)
 {
@@ -284,8 +304,8 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
     memory_region_init_io(&s->qext, obj, &bochs_display_qext_ops, s,
                           "qemu extended regs", PCI_VGA_QEXT_SIZE);
 
-    memory_region_init(&s->mmio, obj, "bochs-display-mmio",
-                       PCI_VGA_MMIO_SIZE);
+    memory_region_init_io(&s->mmio, obj, &dummy_ops, NULL,
+                          "bochs-display-mmio", PCI_VGA_MMIO_SIZE);
     memory_region_add_subregion(&s->mmio, PCI_VGA_BOCHS_OFFSET, &s->vbe);
     memory_region_add_subregion(&s->mmio, PCI_VGA_QEXT_OFFSET, &s->qext);
