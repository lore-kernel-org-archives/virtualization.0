From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] vhost: disable for OABI
Date: Mon, 6 Apr 2020 08:56:56 -0400
Message-ID: <20200406085453-mutt-send-email-mst@kernel.org>
References: <20200406121233.109889-1-mst@redhat.com>
 <20200406121233.109889-3-mst@redhat.com>
 <CAMj1kXFNeuZU66swwf_Cx7PrQJV34C0VJ7Rte5aga2Jx4S-yHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMj1kXFNeuZU66swwf_Cx7PrQJV34C0VJ7Rte5aga2Jx4S-yHw@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <lkp@intel.com>, "daniel.santos@pobox.com" <daniel.santos@pobox.com>, Jason Wang <jasowang@redhat.com>, "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>, Russell King <rmk+kernel@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 06, 2020 at 02:45:13PM +0200, Ard Biesheuvel wrote:
> On Mon, 6 Apr 2020 at 14:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > vhost is currently broken on the default ARM config.
> >
> 
> Where did you get this idea? The report from the robot was using a
> randconfig build, and in general, AEABI is required to run anything on
> any modern ARM system .

Oh - I forgot it's randconfig. This part is wrong, sorry.
I decided to just force 2-byte alignment
instead (seems more robust) but I'll take this into account
if we do decide to add this dependency.


> 
> > The reason is that that uses apcs-gnu which is the ancient OABI that is been
> > deprecated for a long time.
> >
> > Given that virtio support on such ancient systems is not needed in the
> > first place, let's just add something along the lines of
> >
> >         depends on !ARM || AEABI
> >
> > to the virtio Kconfig declaration, and add a comment that it has to do
> > with struct member alignment.
> >
> > Note: we can't make VHOST and VHOST_RING themselves have
> > a dependency since these are selected. Add a new symbol for that.
> >
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Siggested-by: Richard Earnshaw <Richard.Earnshaw@arm.com>
> 
> typo ^^^


Thanks!

> 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/misc/mic/Kconfig |  2 +-
> >  drivers/net/caif/Kconfig |  2 +-
> >  drivers/vdpa/Kconfig     |  2 +-
> >  drivers/vhost/Kconfig    | 17 +++++++++++++----
> >  4 files changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
> > index 8f201d019f5a..3bfe72c59864 100644
> > --- a/drivers/misc/mic/Kconfig
> > +++ b/drivers/misc/mic/Kconfig
> > @@ -116,7 +116,7 @@ config MIC_COSM
> >
> >  config VOP
> >         tristate "VOP Driver"
> > -       depends on VOP_BUS
> > +       depends on VOP_BUS && VHOST_DPN
> >         select VHOST_RING
> >         select VIRTIO
> >         help
> > diff --git a/drivers/net/caif/Kconfig b/drivers/net/caif/Kconfig
> > index 9db0570c5beb..661c25eb1c46 100644
> > --- a/drivers/net/caif/Kconfig
> > +++ b/drivers/net/caif/Kconfig
> > @@ -50,7 +50,7 @@ config CAIF_HSI
> >
> >  config CAIF_VIRTIO
> >         tristate "CAIF virtio transport driver"
> > -       depends on CAIF && HAS_DMA
> > +       depends on CAIF && HAS_DMA && VHOST_DPN
> >         select VHOST_RING
> >         select VIRTIO
> >         select GENERIC_ALLOCATOR
> > diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> > index d0cb0e583a5d..aee28def466b 100644
> > --- a/drivers/vdpa/Kconfig
> > +++ b/drivers/vdpa/Kconfig
> > @@ -14,7 +14,7 @@ if VDPA_MENU
> >
> >  config VDPA_SIM
> >         tristate "vDPA device simulator"
> > -       depends on RUNTIME_TESTING_MENU && HAS_DMA
> > +       depends on RUNTIME_TESTING_MENU && HAS_DMA && VHOST_DPN
> >         select VDPA
> >         select VHOST_RING
> >         select VHOST_IOTLB
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index cb6b17323eb2..b3486e218f62 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -12,6 +12,15 @@ config VHOST_RING
> >           This option is selected by any driver which needs to access
> >           the host side of a virtio ring.
> >
> > +config VHOST_DPN
> > +       bool "VHOST dependencies"
> > +       depends on !ARM || AEABI
> > +       default y
> > +       help
> > +         Anything selecting VHOST or VHOST_RING must depend on VHOST_DPN.
> > +         This excludes the deprecated ARM ABI since that forces a 4 byte
> > +         alignment on all structs - incompatible with virtio spec requirements.
> > +
> >  config VHOST
> >         tristate
> >         select VHOST_IOTLB
> > @@ -27,7 +36,7 @@ if VHOST_MENU
> >
> >  config VHOST_NET
> >         tristate "Host kernel accelerator for virtio net"
> > -       depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP)
> > +       depends on NET && EVENTFD && (TUN || !TUN) && (TAP || !TAP) && VHOST_DPN
> >         select VHOST
> >         ---help---
> >           This kernel module can be loaded in host kernel to accelerate
> > @@ -39,7 +48,7 @@ config VHOST_NET
> >
> >  config VHOST_SCSI
> >         tristate "VHOST_SCSI TCM fabric driver"
> > -       depends on TARGET_CORE && EVENTFD
> > +       depends on TARGET_CORE && EVENTFD && VHOST_DPN
> >         select VHOST
> >         default n
> >         ---help---
> > @@ -48,7 +57,7 @@ config VHOST_SCSI
> >
> >  config VHOST_VSOCK
> >         tristate "vhost virtio-vsock driver"
> > -       depends on VSOCKETS && EVENTFD
> > +       depends on VSOCKETS && EVENTFD && VHOST_DPN
> >         select VHOST
> >         select VIRTIO_VSOCKETS_COMMON
> >         default n
> > @@ -62,7 +71,7 @@ config VHOST_VSOCK
> >
> >  config VHOST_VDPA
> >         tristate "Vhost driver for vDPA-based backend"
> > -       depends on EVENTFD
> > +       depends on EVENTFD && VHOST_DPN
> >         select VHOST
> >         select VDPA
> >         help
> > --
> > MST
> >
