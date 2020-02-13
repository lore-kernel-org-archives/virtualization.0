From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Thu, 13 Feb 2020 12:24:07 -0400
Message-ID: <20200213162407.GZ4271@mellanox.com>
References: <20200211134746.GI4271@mellanox.com>
 <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
 <20200212125108.GS4271@mellanox.com>
 <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
 <20200213134128.GV4271@mellanox.com>
 <ebaea825-5432-65e2-2ab3-720a8c4030e7@redhat.com>
 <20200213150542.GW4271@mellanox.com>
 <20200213103714-mutt-send-email-mst@kernel.org>
 <20200213155154.GX4271@mellanox.com>
 <20200213105425-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200213105425-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 13, 2020 at 10:56:00AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 13, 2020 at 11:51:54AM -0400, Jason Gunthorpe wrote:
> > > That bus is exactly what Greg KH proposed. There are other ways
> > > to solve this I guess but this bikeshedding is getting tiring.
> > 
> > This discussion was for a different goal, IMHO.
> 
> Hmm couldn't find it anymore. What was the goal there in your opinion?

I think it was largely talking about how to model things like
ADI/SF/etc, plus stuff got very confused when the discussion tried to
explain what mdev's role was vs the driver core.

The standard driver model is a 'bus' driver provides the HW access
(think PCI level things), and a 'hw driver' attaches to the bus
device, and instantiates a 'subsystem device' (think netdev, rdma,
etc) using some per-subsystem XXX_register(). The 'hw driver' pulls in
functions from the 'subsystem' using a combination of callbacks and
library-style calls so there is no code duplication.

As a subsystem, vhost&vdpa should expect its 'HW driver' to bind to
devices on busses, for instance I would expect:

 - A future SF/ADI/'virtual bus' as a child of multi-functional PCI device
   Exactly how this works is still under active discussion and is
   one place where Greg said 'use a bus'.
 - An existing PCI, platform, or other bus and device. No need for an
   extra bus here, PCI is the bus.
 - No bus, ie for a simulator or binding to a netdev. (existing vhost?)

They point is that the HW driver's job is to adapt from the bus level
interfaces (eg readl/writel) to the subsystem level (eg something like
the vdpa_ops). 

For instance that Intel driver should be a pci_driver to bind to a
struct pci_device for its VF and then call some 'vhost&vdpa'
_register() function to pass its ops to the subsystem which in turn
creates the struct device of the subsystem calls, common char devices,
sysfs, etc and calls the driver's ops in response to uAPI calls.

This is already almost how things were setup in v2 of the patches,
near as I can see, just that a bus was inserted somehow instead of
having only the vhost class. So it iwas confusing and the lifetime
model becomes too complicated to implement correctly...

Jason
