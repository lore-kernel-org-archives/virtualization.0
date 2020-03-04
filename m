From: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH] drm/bochs: Remove vga write
Date: Tue, 3 Mar 2020 17:18:34 -0800
Message-ID: <CAKmqyKPEtbDr1kmnyz6FtfU567xxgmxn+F=zH_h8k_m1EN9b5A@mail.gmail.com>
References: <20200227210454.18217-1-alistair.francis@wdc.com>
 <20200228095748.uu4sqkz6y477eabc@sirius.home.kraxel.org>
 <CAKmqyKOTjyRL9vxZrZW8Q+yBM0n-Nw-o-Cn3dUDDfAAa7Nswrg@mail.gmail.com>
 <20200303062437.tjoje5huts6oldrv@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200303062437.tjoje5huts6oldrv@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: airlied@linux.ie, Khem Raj <raj.khem@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Alistair Francis <alistair.francis@wdc.com>, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 2, 2020 at 10:24 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Mar 02, 2020 at 02:14:02PM -0800, Alistair Francis wrote:
> > On Fri, Feb 28, 2020 at 1:57 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > On Thu, Feb 27, 2020 at 01:04:54PM -0800, Alistair Francis wrote:
> > > > The QEMU model for the Bochs display has no VGA memory section at offset
> > > > 0x400 [1]. By writing to this register Linux can create a write to
> > > > unassigned memory which depending on machine and architecture can result
> > > > in a store fault.
> > > >
> > > > I don't see any reference to this address at OSDev [2] or in the Bochs
> > > > source code.
> > > >
> > > > Removing this write still allows graphics to work inside QEMU with
> > > > the bochs-display.
> > >
> > > It's not that simple.  The driver also handles the qemu stdvga (-device
> > > VGA, -device secondary-vga) which *does* need the vga port write.
> > > There is no way for the guest to figure whenever the device is
> > > secondary-vga or bochs-display.
> > >
> > > So how about fixing things on the host side?  Does qemu patch below
> > > help?
> >
> > That patch looks like it will fix the problem, but it doesn't seem
> > like the correct fix. I would rather avoid adding a large chunk of
> > dummy I/O to handle the two devices.
>
> It's just a single handler for the parent mmio region, so we have a
> defined default action instead of undefined behavior.
>
> Patch just posted to qemu-devel, lets see what others think ...

Thanks, let's wait and see what happens.

>
> > > Maybe another possible approach is to enable/disable vga access per
> > > arch.  On x86 this doesn't cause any problems.  I guess you are on
> > > risc-v?
> >
> > I would prefer this option. I do see this on RISC-V, but I suspect the
> > issue will appear on other architectures (although how they handle I/O
> > failures in QEMU is a different story).
> >
> > Can I just do the VGA write if x86?
>
> I know ppc needs it too.  Not sure about other architectures.  I'd
> suggest to do it the other way around: blacklist known-problematic
> archs.

Argh, that is a little uglier. Let's circle back after receiving
feedback on the QEMU patch.

Alistair

>
> cheers,
>   Gerd
>
