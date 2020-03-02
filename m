From: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH] drm/bochs: Remove vga write
Date: Mon, 2 Mar 2020 14:14:02 -0800
Message-ID: <CAKmqyKOTjyRL9vxZrZW8Q+yBM0n-Nw-o-Cn3dUDDfAAa7Nswrg@mail.gmail.com>
References: <20200227210454.18217-1-alistair.francis@wdc.com> <20200228095748.uu4sqkz6y477eabc@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228095748.uu4sqkz6y477eabc@sirius.home.kraxel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, daniel@ffwll.ch, airlied@linux.ie, Khem Raj <raj.khem@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 28, 2020 at 1:57 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Feb 27, 2020 at 01:04:54PM -0800, Alistair Francis wrote:
> > The QEMU model for the Bochs display has no VGA memory section at offset
> > 0x400 [1]. By writing to this register Linux can create a write to
> > unassigned memory which depending on machine and architecture can result
> > in a store fault.
> >
> > I don't see any reference to this address at OSDev [2] or in the Bochs
> > source code.
> >
> > Removing this write still allows graphics to work inside QEMU with
> > the bochs-display.
>
> It's not that simple.  The driver also handles the qemu stdvga (-device
> VGA, -device secondary-vga) which *does* need the vga port write.
> There is no way for the guest to figure whenever the device is
> secondary-vga or bochs-display.
>
> So how about fixing things on the host side?  Does qemu patch below
> help?

That patch looks like it will fix the problem, but it doesn't seem
like the correct fix. I would rather avoid adding a large chunk of
dummy I/O to handle the two devices.

>
> Maybe another possible approach is to enable/disable vga access per
> arch.  On x86 this doesn't cause any problems.  I guess you are on
> risc-v?

I would prefer this option. I do see this on RISC-V, but I suspect the
issue will appear on other architectures (although how they handle I/O
failures in QEMU is a different story).

Can I just do the VGA write if x86?

Alistair

>
> cheers,
>   Gerd
>
> diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
> index 62085f9fc063..e93e838243b8 100644
> --- a/hw/display/bochs-display.c
> +++ b/hw/display/bochs-display.c
> @@ -151,6 +151,26 @@ static const MemoryRegionOps bochs_display_qext_ops = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>
> +static uint64_t dummy_read(void *ptr, hwaddr addr, unsigned size)
> +{
> +    return -1;
> +}
> +
> +static void dummy_write(void *ptr, hwaddr addr,
> +                        uint64_t val, unsigned size)
> +{
> +}
> +
> +static const MemoryRegionOps dummy_ops = {
> +    .read = dummy_read,
> +    .write = dummy_write,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 1,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>  static int bochs_display_get_mode(BochsDisplayState *s,
>                                     BochsDisplayMode *mode)
>  {
> @@ -284,8 +304,8 @@ static void bochs_display_realize(PCIDevice *dev, Error **errp)
>      memory_region_init_io(&s->qext, obj, &bochs_display_qext_ops, s,
>                            "qemu extended regs", PCI_VGA_QEXT_SIZE);
>
> -    memory_region_init(&s->mmio, obj, "bochs-display-mmio",
> -                       PCI_VGA_MMIO_SIZE);
> +    memory_region_init_io(&s->mmio, obj, &dummy_ops, NULL,
> +                          "bochs-display-mmio", PCI_VGA_MMIO_SIZE);
>      memory_region_add_subregion(&s->mmio, PCI_VGA_BOCHS_OFFSET, &s->vbe);
>      memory_region_add_subregion(&s->mmio, PCI_VGA_QEXT_OFFSET, &s->qext);
>
>
