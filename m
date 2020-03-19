From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V6 8/8] virtio: Intel IFC VF driver for VDPA
Date: Thu, 19 Mar 2020 10:02:39 -0300
Message-ID: <20200319130239.GW13183@mellanox.com>
References: <20200318080327.21958-1-jasowang@redhat.com>
 <20200318080327.21958-9-jasowang@redhat.com>
 <20200318122255.GG13183@mellanox.com>
 <30359bae-d66a-0311-0028-d7d33b8295f2@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <30359bae-d66a-0311-0028-d7d33b8295f2@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, Bie Tiwei <tiwei.bie@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 19, 2020 at 04:14:37PM +0800, Jason Wang wrote:
> 
> On 2020/3/18 下午8:22, Jason Gunthorpe wrote:
> > On Wed, Mar 18, 2020 at 04:03:27PM +0800, Jason Wang wrote:
> > > From: Zhu Lingshan <lingshan.zhu@intel.com>
> > > +
> > > +static int ifcvf_vdpa_attach(struct ifcvf_adapter *adapter)
> > > +{
> > > +	int ret;
> > > +
> > > +	adapter->vdpa_dev  = vdpa_alloc_device(adapter->dev, adapter->dev,
> > > +					       &ifc_vdpa_ops);
> > > +	if (IS_ERR(adapter->vdpa_dev)) {
> > > +		IFCVF_ERR(adapter->dev, "Failed to init ifcvf on vdpa bus");
> > > +		put_device(&adapter->vdpa_dev->dev);
> > > +		return -ENODEV;
> > > +	}
> > The point of having an alloc call is so that the drivers
> > ifcvf_adaptor memory could be placed in the same struct - eg use
> > container_of to flip between them, and have a kref for both memories.
> > 
> > It seem really weird to have an alloc followed immediately by
> > register.
> 
> 
> I admit the ifcvf_adapter is not correctly ref-counted. What you suggest
> should work. But it looks to me the following is more cleaner since the
> members of ifcvf_adapter are all related to PCI device not vDPA itself.

I've done it both ways (eg tpm is as you describe, ib is using alloc).

I tend to prefer the alloc method today, allowing the driver memory to
have a proper refcount makes the driver structure usable with RCU and
allows simple solutions to some tricky cases. It is a bit hard to
switch to this later..

> - keep the current layout of ifcvf_adapter
> - merge vdpa_alloc_device() and vdpa_register_device()
> - use devres to bind ifcvf_adapter refcnt/lifcycle to the under PCI device

This is almost what tpm does. Keep in mind the lifecycle with devm is
just slightly past the driver remove call, so remove still 
must revoke all external references to the memory.

The merging alloc and register rarely works out, the register must be
the very last thing done, and usually you need the subsystem pointer
to do pre-registration setup in anything but the most trivial of
subsystems and drivers.

> If we go for the container_of method, we probably need
> 
> - accept a size of parent parent structure in vdpa_alloc_device() and
> mandate vdpa_device to be the first member of ifcvf_adapter
> - we need provide a way to free resources of parent structure when we
> destroy vDPA device

Yep. netdev and rdma work this way with a free memory callback in the
existing ops structures.

Jason
