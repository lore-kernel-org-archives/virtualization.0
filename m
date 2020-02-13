From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Thu, 13 Feb 2020 11:51:54 -0400
Message-ID: <20200213155154.GX4271@mellanox.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-4-jasowang@redhat.com>
 <20200211134746.GI4271@mellanox.com>
 <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
 <20200212125108.GS4271@mellanox.com>
 <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
 <20200213134128.GV4271@mellanox.com>
 <ebaea825-5432-65e2-2ab3-720a8c4030e7@redhat.com>
 <20200213150542.GW4271@mellanox.com>
 <20200213103714-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200213103714-mutt-send-email-mst@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 13, 2020 at 10:41:06AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 13, 2020 at 11:05:42AM -0400, Jason Gunthorpe wrote:
> > On Thu, Feb 13, 2020 at 10:58:44PM +0800, Jason Wang wrote:
> > > 
> > > On 2020/2/13 下午9:41, Jason Gunthorpe wrote:
> > > > On Thu, Feb 13, 2020 at 11:34:10AM +0800, Jason Wang wrote:
> > > > 
> > > > > >    You have dev, type or
> > > > > > class to choose from. Type is rarely used and doesn't seem to be used
> > > > > > by vdpa, so class seems the right choice
> > > > > > 
> > > > > > Jason
> > > > > Yes, but my understanding is class and bus are mutually exclusive. So we
> > > > > can't add a class to a device which is already attached on a bus.
> > > > While I suppose there are variations, typically 'class' devices are
> > > > user facing things and 'bus' devices are internal facing (ie like a
> > > > PCI device)
> > > 
> > > 
> > > Though all vDPA devices have the same programming interface, but the
> > > semantic is different. So it looks to me that use bus complies what
> > > class.rst said:
> > > 
> > > "
> > > 
> > > Each device class defines a set of semantics and a programming interface
> > > that devices of that class adhere to. Device drivers are the
> > > implementation of that programming interface for a particular device on
> > > a particular bus.
> > > 
> > > "
> > 
> > Here we are talking about the /dev/XX node that provides the
> > programming interface. All the vdpa devices have the same basic
> > chardev interface and discover any semantic variations 'in band'
> > 
> > > > So why is this using a bus? VDPA is a user facing object, so the
> > > > driver should create a class vhost_vdpa device directly, and that
> > > > driver should live in the drivers/vhost/ directory.
> > >  
> > > This is because we want vDPA to be generic for being used by different
> > > drivers which is not limited to vhost-vdpa. E.g in this series, it allows
> > > vDPA to be used by kernel virtio drivers. And in the future, we will
> > > probably introduce more drivers in the future.
> > 
> > I don't see how that connects with using a bus.
> > 
> > Every class of virtio traffic is going to need a special HW driver to
> > enable VDPA, that special driver can create the correct vhost side
> > class device.
> 
> That's just a ton of useless code duplication, and a good chance
> to have minor variations in implementations confusing
> userspace.

What? Why? This is how almost every user of the driver core works.

I don't see how you get any duplication unless the subsystem core is
badly done wrong.

The 'class' is supposed to provide all the library functions to remove
this duplication. Instead of plugging the HW driver in via some bus
scheme every subsystem has its own 'ops' that the HW driver provides
to the subsystem's class via subsystem_register()

This is the *standard* pattern to use the driver core.

This is almost there, it just has this extra bus part to convey the HW
ops instead of directly.

> Instead, each device implement the same interface, and then
> vhost sits on top.

Sure, but plugging in via ops/etc not via a bus and another struct
device.

> That bus is exactly what Greg KH proposed. There are other ways
> to solve this I guess but this bikeshedding is getting tiring.

This discussion was for a different goal, IMHO.

> Come on it's an internal kernel interface, if we feel
> it was a wrong direction to take we can change our minds later.
> Main thing is getting UAPI right.

This discussion started because the refcounting has been busted up in
every version posted so far. It is not bikeshedding when these bugs
are actually being caused by trying to abuse the driver core and
shoehorn in a bus that isn't needed when a class is the correct thing
to use.

Jason
