From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Fri, 14 Feb 2020 10:04:46 -0400
Message-ID: <20200214140446.GD4271@mellanox.com>
References: <20200212125108.GS4271@mellanox.com>
 <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
 <20200213134128.GV4271@mellanox.com>
 <ebaea825-5432-65e2-2ab3-720a8c4030e7@redhat.com>
 <20200213150542.GW4271@mellanox.com>
 <20200213103714-mutt-send-email-mst@kernel.org>
 <20200213155154.GX4271@mellanox.com>
 <20200213105425-mutt-send-email-mst@kernel.org>
 <20200213162407.GZ4271@mellanox.com>
 <5625f971-0455-6463-2c0a-cbca6a1f8271@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5625f971-0455-6463-2c0a-cbca6a1f8271@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 14, 2020 at 12:05:32PM +0800, Jason Wang wrote:

> > The standard driver model is a 'bus' driver provides the HW access
> > (think PCI level things), and a 'hw driver' attaches to the bus
> > device,
> 
> This is not true, kernel had already had plenty virtual bus where virtual
> devices and drivers could be attached, besides mdev and virtio, you can see
> vop, rpmsg, visorbus etc.

Sure, but those are not connecting HW into the kernel..
 
> > and instantiates a 'subsystem device' (think netdev, rdma,
> > etc) using some per-subsystem XXX_register().
> 
> 
> Well, if you go through virtio spec, we support ~20 types of different
> devices. Classes like netdev and rdma are correct since they have a clear
> set of semantics their own. But grouping network and scsi into a single
> class looks wrong, that's the work of a virtual bus.

rdma also has about 20 different types of things it supports on top of
the generic ib_device.

The central point in RDMA is the 'struct ib_device' which is a device
class. You can discover all RDMA devices by looking in /sys/class/infiniband/

It has an internal bus like thing (which probably should have been an
actual bus, but this was done 15 years ago) which allows other
subsystems to have drivers to match and bind their own drivers to the
struct ib_device.

So you'd have a chain like:

struct pci_device -> struct ib_device -> [ib client bus thing] -> struct net_device

And the various char devs are created by clients connecting to the
ib_device and creating char devs on their own classes.

Since ib_devices are multi-queue we can have all 20 devices running
concurrently and there are various schemes to manage when the various
things are created.

> > The 'hw driver' pulls in
> > functions from the 'subsystem' using a combination of callbacks and
> > library-style calls so there is no code duplication.
> 
> The point is we want vDPA devices to be used by different subsystems, not
> only vhost, but also netdev, blk, crypto (every subsystem that can use
> virtio devices). That's why we introduce vDPA bus and introduce different
> drivers on top.

See the other mail, it seems struct virtio_device serves this purpose
already, confused why a struct vdpa_device and another bus is being
introduced

> There're several examples that a bus is needed on top.
> 
> A good example is Mellanox TmFIFO driver which is a platform device driver
> but register itself as a virtio device in order to be used by virito-console
> driver on the virtio bus.

How is that another bus? The platform bus is the HW bus, the TmFIFO is
the HW driver, and virtio_device is the subsystem.

This seems reasonable/normal so far..

> But it's a pity that the device can not be used by userspace driver due to
> the limitation of virito bus which is designed for kernel driver. That's why
> vDPA bus is introduced which abstract the common requirements of both kernel
> and userspace drivers which allow the a single HW driver to be used by
> kernel drivers (and the subsystems on top) and userspace drivers.

Ah! Maybe this is the source of all this strangeness - the userspace
driver is something parallel to the struct virtio_device instead of
being a consumer of it?? That certianly would mess up the driver model
quite a lot.

Then you want to add another bus to switch between vhost and struct
virtio_device? But only for vdpa?

But as you point out something like TmFIFO is left hanging. Seems like
the wrong abstraction point..

Jason
