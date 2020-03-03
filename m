From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/bochs: Remove vga write
Date: Tue, 3 Mar 2020 07:24:37 +0100
Message-ID: <20200303062437.tjoje5huts6oldrv@sirius.home.kraxel.org>
References: <20200227210454.18217-1-alistair.francis@wdc.com>
 <20200228095748.uu4sqkz6y477eabc@sirius.home.kraxel.org>
 <CAKmqyKOTjyRL9vxZrZW8Q+yBM0n-Nw-o-Cn3dUDDfAAa7Nswrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKmqyKOTjyRL9vxZrZW8Q+yBM0n-Nw-o-Cn3dUDDfAAa7Nswrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, daniel@ffwll.ch, airlied@linux.ie, Khem Raj <raj.khem@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 02, 2020 at 02:14:02PM -0800, Alistair Francis wrote:
> On Fri, Feb 28, 2020 at 1:57 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Thu, Feb 27, 2020 at 01:04:54PM -0800, Alistair Francis wrote:
> > > The QEMU model for the Bochs display has no VGA memory section at offset
> > > 0x400 [1]. By writing to this register Linux can create a write to
> > > unassigned memory which depending on machine and architecture can result
> > > in a store fault.
> > >
> > > I don't see any reference to this address at OSDev [2] or in the Bochs
> > > source code.
> > >
> > > Removing this write still allows graphics to work inside QEMU with
> > > the bochs-display.
> >
> > It's not that simple.  The driver also handles the qemu stdvga (-device
> > VGA, -device secondary-vga) which *does* need the vga port write.
> > There is no way for the guest to figure whenever the device is
> > secondary-vga or bochs-display.
> >
> > So how about fixing things on the host side?  Does qemu patch below
> > help?
> 
> That patch looks like it will fix the problem, but it doesn't seem
> like the correct fix. I would rather avoid adding a large chunk of
> dummy I/O to handle the two devices.

It's just a single handler for the parent mmio region, so we have a
defined default action instead of undefined behavior.

Patch just posted to qemu-devel, lets see what others think ...

> > Maybe another possible approach is to enable/disable vga access per
> > arch.  On x86 this doesn't cause any problems.  I guess you are on
> > risc-v?
> 
> I would prefer this option. I do see this on RISC-V, but I suspect the
> issue will appear on other architectures (although how they handle I/O
> failures in QEMU is a different story).
> 
> Can I just do the VGA write if x86?

I know ppc needs it too.  Not sure about other architectures.  I'd
suggest to do it the other way around: blacklist known-problematic
archs.

cheers,
  Gerd
