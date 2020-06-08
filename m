From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 5/6] vdpa: introduce virtio pci driver
Date: Mon, 8 Jun 2020 05:31:48 -0400
Message-ID: <20200608052041-mutt-send-email-mst@kernel.org>
References: <20200529080303.15449-1-jasowang@redhat.com>
 <20200529080303.15449-6-jasowang@redhat.com>
 <20200602010332-mutt-send-email-mst@kernel.org>
 <5dbb0386-beeb-5bf4-d12e-fb5427486bb8@redhat.com>
 <6b1d1ef3-d65e-08c2-5b65-32969bb5ecbc@redhat.com>
 <20200607095012-mutt-send-email-mst@kernel.org>
 <9b1abd2b-232c-aa0f-d8bb-03e65fd47de2@redhat.com>
 <20200608021438-mutt-send-email-mst@kernel.org>
 <a1b1b7fb-b097-17b7-2e3a-0da07d2e48ae@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a1b1b7fb-b097-17b7-2e3a-0da07d2e48ae@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 08, 2020 at 05:18:44PM +0800, Jason Wang wrote:
> 
> On 2020/6/8 下午2:32, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2020 at 11:32:31AM +0800, Jason Wang wrote:
> > > On 2020/6/7 下午9:51, Michael S. Tsirkin wrote:
> > > > On Fri, Jun 05, 2020 at 04:54:17PM +0800, Jason Wang wrote:
> > > > > On 2020/6/2 下午3:08, Jason Wang wrote:
> > > > > > > > +static const struct pci_device_id vp_vdpa_id_table[] = {
> > > > > > > > +    { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
> > > > > > > > +    { 0 }
> > > > > > > > +};
> > > > > > > This looks like it'll create a mess with either virtio pci
> > > > > > > or vdpa being loaded at random. Maybe just don't specify
> > > > > > > any IDs for now. Down the road we could get a
> > > > > > > distinct vendor ID or a range of device IDs for this.
> > > > > > Right, will do.
> > > > > > 
> > > > > > Thanks
> > > > > Rethink about this. If we don't specify any ID, the binding won't work.
> > > > We can bind manually. It's not really for production anyway, so
> > > > not a big deal imho.
> > > 
> > > I think you mean doing it via "new_id", right.
> > I really meant driver_override. This is what people have been using
> > with pci-stub for years now.
> 
> 
> Do you want me to implement "driver_overrid" in this series, or a NULL
> id_table is sufficient?


Doesn't the pci subsystem create driver_override for all devices
on the pci bus?

> 
> > 
> > > > > How about using a dedicated subsystem vendor id for this?
> > > > > 
> > > > > Thanks
> > > > If virtio vendor id is used then standard driver is expected
> > > > to bind, right? Maybe use a dedicated vendor id?
> > > 
> > > I meant something like:
> > > 
> > > static const struct pci_device_id vp_vdpa_id_table[] = {
> > >      { PCI_DEVICE_SUB(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID,
> > > VP_TEST_VENDOR_ID, VP_TEST_DEVICE_ID) },
> > >      { 0 }
> > > };
> > > 
> > > Thanks
> > > 
> > Then regular virtio will still bind to it. It has
> > 
> > drivers/virtio/virtio_pci_common.c:     { PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_ANY_ID) },
> > 
> > 
> 
> IFCVF use this to avoid the binding to regular virtio device.


Ow. Indeed:

#define IFCVF_VENDOR_ID         0x1AF4

Which is of course not an IFCVF vendor id, it's the Red Hat vendor ID.

I missed that.

Does it actually work if you bind a virtio driver to it?
I'm guessing no otherwise they wouldn't need IFC driver, right?




> Looking at
> pci_match_one_device() it checks both subvendor and subdevice there.
> 
> Thanks


But IIUC there is no guarantee that driver with a specific subvendor
matches in presence of a generic one.
So either IFC or virtio pci can win, whichever binds first.

I guess we need to blacklist IFC in virtio pci probe code. Ugh.

-- 
MST
