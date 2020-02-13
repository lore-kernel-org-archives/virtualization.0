From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Thu, 13 Feb 2020 09:41:28 -0400
Message-ID: <20200213134128.GV4271@mellanox.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-4-jasowang@redhat.com>
 <20200211134746.GI4271@mellanox.com>
 <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
 <20200212125108.GS4271@mellanox.com>
 <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 13, 2020 at 11:34:10AM +0800, Jason Wang wrote:

> >   You have dev, type or
> > class to choose from. Type is rarely used and doesn't seem to be used
> > by vdpa, so class seems the right choice
> > 
> > Jason
> 
> Yes, but my understanding is class and bus are mutually exclusive. So we
> can't add a class to a device which is already attached on a bus.

While I suppose there are variations, typically 'class' devices are
user facing things and 'bus' devices are internal facing (ie like a
PCI device)

So why is this using a bus? VDPA is a user facing object, so the
driver should create a class vhost_vdpa device directly, and that
driver should live in the drivers/vhost/ directory.

For the PCI VF case this driver would bind to a PCI device like
everything else

For our future SF/ADI cases the driver would bind to some
SF/ADI/whatever device on a bus.

I don't see a reason for VDPA to be creating busses..

Jason
