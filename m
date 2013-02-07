From: Vadim Rozenfeld <vrozenfe@redhat.com>
Subject: Re: [Qemu-devel] Headsup: windows virtio networking does not work
	on current git
Date: Thu, 07 Feb 2013 22:46:14 +1100
Message-ID: <1360237574.1968.165.camel@localhost>
References: <1359981484.1968.29.camel@localhost>
	<87fw1ckupa.fsf@codemonkey.ws> <1360063865.1968.85.camel@localhost>
	<5110F0E2.1030705@msgid.tls.msk.ru> <20130205115816.GD6420@redhat.com>
	<1360144040.1968.119.camel@localhost> <877gmlj5pz.fsf@rustcorp.com.au>
	<1360229050.1968.149.camel@localhost>
	<20130207101813.GA3837@redhat.com>
	<1360234419.1968.162.camel@localhost>
	<20130207113356.GA5708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130207113356.GA5708@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2013-02-07 at 13:33 +0200, Michael S. Tsirkin wrote:
> On Thu, Feb 07, 2013 at 09:53:39PM +1100, Vadim Rozenfeld wrote:
> > On Thu, 2013-02-07 at 12:18 +0200, Michael S. Tsirkin wrote:
> > > On Thu, Feb 07, 2013 at 08:24:10PM +1100, Vadim Rozenfeld wrote:
> > > > On Thu, 2013-02-07 at 11:33 +1030, Rusty Russell wrote:
> > > > > Vadim Rozenfeld <vrozenfe@redhat.com> writes:
> > > > > > On Tue, 2013-02-05 at 13:58 +0200, Michael S. Tsirkin wrote:
> > > > > >> On Tue, Feb 05, 2013 at 03:45:38PM +0400, Michael Tokarev wrote:
> > > > > >>  Is it really
> > > > > >> > that bad that the config space size changed?  Why it has this effect?
> > > > > > Because in this case it's hard to distinguish between resource's
> > > > > > corruption and HW update.
> > > > > 
> > > > > But it's also true that if we'd incremented revid you'd have the same
> > > > > failure in this case, right?
> > > > 
> > > > It depends. If we have explicitly specified revision id in inf file and
> > > > this id doesn't mach the new revision id, Windows will not try to load
> > > > the "incompatible" driver, and finish up with "device driver not found"
> > > > dialog.
> > > > 
> > > > Best regards,
> > > > Vadim.
> > > >   
> > > > > 
> > > > > Cheers,
> > > > > Rusty.
> > > 
> > > Well that's all in theory, in practice it does not look like revision ID
> > > is specified in the NetKVM inf so this won't work?
> > > 
> > > From what I see this inf specifies:
> > > 
> > > NetKVM/wlh/netkvm.inf:%kvmnet6.DeviceDesc%    = kvmnet6.ndi, PCI\VEN_1AF4&DEV_1000&SUBSYS_00011AF4
> > > NetKVM/wxp/netkvm.inf:%kvmnet5.DeviceDesc%    = kvmnet5.ndi, PCI\VEN_1AF4&DEV_1000&SUBSYS_00011AF4
> > > NetKVM/wxp/netkvm2k.inf:%kvmnet5.DeviceDesc%    = kvmnet5.ndi, PCI\VEN_1AF4&DEV_1000&SUBSYS_00011AF4
> > > 
> > > So we can tweak any of vendor device and subsystem id.
> > > 
> > Unfortunately, it won't. Only balloon has revision id, specified as a
> > part of device HW descriptor. But it's only because virtio doesn't use 
> > revision ids. Otherwise it differential will be there. 
> 
> So your driver will load and attempt to work on rev=2 devices?

All virtio-win drivers (net, serial, block, and scsi), except for
balloon will.
 
> If yes it's a bug.  virtio spec specifies revision id as an ABI version.
> Linux driver does:
> 
>         if (pci_dev->revision != VIRTIO_PCI_ABI_VERSION) {
>                 printk(KERN_ERR "virtio_pci: expected ABI version %d, got %d\n",
>                        VIRTIO_PCI_ABI_VERSION, pci_dev->revision);
>                 return -ENODEV;
>         }
> 
> 
> > > 
> > > Changing subsystem vendor ID actually will be completely
> > > transparent to linux which for some reason looks at the
> > > subsystem device ID (why? no idea) but not the subsystem vendor ID.
> > > Of course this requires a valid vendor ID, getting this
> > > costs $3000 I think.
> > > We could tweak device ID too but that might break some other guests
> > > which don't copy the crazy 'replace device id with subsystem device id'
> > > logic from Linux.
> > > 
> > 
> 
> Apropos, would you guys like to start to copy your patches to
> virtualization@lists.linux-foundation.org?
> If you do, you might get some review and feedback, allowing
> us to catch such forward compatibility issues earlier.
> 
> Of course it's your project so entirely up to you.
> 
> 
