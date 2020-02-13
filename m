From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH V2 3/5] vDPA: introduce vDPA bus
Date: Thu, 13 Feb 2020 12:13:20 -0400
Message-ID: <20200213161320.GY4271@mellanox.com>
References: <20200211134746.GI4271@mellanox.com>
 <cf7abcc9-f8ef-1fe2-248e-9b9028788ade@redhat.com>
 <20200212125108.GS4271@mellanox.com>
 <12775659-1589-39e4-e344-b7a2c792b0f3@redhat.com>
 <20200213134128.GV4271@mellanox.com>
 <ebaea825-5432-65e2-2ab3-720a8c4030e7@redhat.com>
 <20200213150542.GW4271@mellanox.com>
 <20200213103714-mutt-send-email-mst@kernel.org>
 <20200213155154.GX4271@mellanox.com>
 <20200213105743-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200213105743-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 13, 2020 at 10:59:34AM -0500, Michael S. Tsirkin wrote:
> On Thu, Feb 13, 2020 at 11:51:54AM -0400, Jason Gunthorpe wrote:
> > The 'class' is supposed to provide all the library functions to remove
> > this duplication. Instead of plugging the HW driver in via some bus
> > scheme every subsystem has its own 'ops' that the HW driver provides
> > to the subsystem's class via subsystem_register()
> 
> Hmm I'm not familiar with subsystem_register. A grep didn't find it
> in the kernel either ...

I mean it is the registration function provided by the subsystem that
owns the class, for instance tpm_chip_register(),
ib_register_device(), register_netdev(), rtc_register_device() etc

So if you have some vhost (vhost net?) class then you'd have some
vhost_vdpa_init/alloc(); vhost_vdpa_register(), sequence
presumably. (vs trying to do it with a bus matcher)

I recommend to look at rtc and tpm for fairly simple easy to follow
patterns for creating a subsystem in the kernel. A subsystem owns a class,
allows HW drivers to plug in to it, and provides a consistent user
API via a cdev/sysfs/etc.

The driver model class should revolve around the char dev and sysfs
uABI - if you enumerate the devices on the class then they should all
follow the char dev and sysfs interfaces contract of that class.

Those examples show how to do all the refcounting semi-sanely,
introduce sysfs, cdevs, etc.

I thought the latest proposal was to use the existing vhost class and
largely the existing vhost API, so it probably just needs to make sure
the common class-wide stuff is split from the 'driver' stuff of the
existing vhost to netdev.

Jason
