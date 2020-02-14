From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Fri, 14 Feb 2020 09:52:32 -0400
Message-ID: <20200214135232.GB4271@mellanox.com>
References: <20200210035608.10002-1-jasowang@redhat.com>
 <20200210035608.10002-4-jasowang@redhat.com>
 <20200211134746.GI4271@mellanox.com>
 <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
 <20200212125108.GS4271@mellanox.com>
 <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
 <20200213134128.GV4271@mellanox.com>
 <ebaea825-5432-65e2-2ab3-720a8c4030e7@redhat.com>
 <20200213150542.GW4271@mellanox.com>
 <8b3e6a9c-8bfd-fb3c-12a8-2d6a3879f1ae@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8b3e6a9c-8bfd-fb3c-12a8-2d6a3879f1ae@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 14, 2020 at 11:23:27AM +0800, Jason Wang wrote:

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
> > Here we are talking about the /dev/XX node that provides the
> > programming interface.
> 
> 
> I'm confused here, are you suggesting to use class to create char device in
> vhost-vdpa? That's fine but the comment should go for vhost-vdpa patch.

Certainly yes, something creating many char devs should have a
class. That makes the sysfs work as expected

I suppose this is vhost user? I admit I don't really see how this
vhost stuff works, all I see are global misc devices? Very unusual for
a new subsystem to be using global misc devices..

I would have expected that a single VDPA device comes out as a single
char dev linked to only that VDPA device.

> > All the vdpa devices have the same basic
> > chardev interface and discover any semantic variations 'in band'
> 
> That's not true, char interface is only used for vhost. Kernel virtio driver
> does not need char dev but a device on the virtio bus.

Okay, this is fine, but why do you need two busses to accomplish this?

Shouldn't the 'struct virito_device' be the plug in point for HW
drivers I was talking about - and from there a vhost-user can connect
to the struct virtio_device to give it a char dev or a kernel driver
can connect to link it to another subsystem?

It is easy to see something is going wrong with this design because
the drivers/virtio/virtio_vdpa.c mainly contains a bunch of trampoline
functions reflecting identical calls from one ops struct to a
different ops struct. This suggests the 'vdpa' is some subclass of
'virtio' and it is possibly better to model it by extending 'struct
virito_device' to include the vdpa specific stuff.

Where does the vhost-user char dev get invovled in with the v2 series?
Is that included?

> > Every class of virtio traffic is going to need a special HW driver to
> > enable VDPA, that special driver can create the correct vhost side
> > class device.
> 
> Are you saying, e.g it's the charge of IFCVF driver to create vhost char dev
> and other stuffs?

No.

Jason
