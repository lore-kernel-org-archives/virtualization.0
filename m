From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Wed, 5 Feb 2020 05:33:40 -0500
Message-ID: <20200205053129-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200205020247.GA368700@___>
 <AM0PR0502MB37952015716C1D5E07E390B6C3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
 <112858a4-1a01-f4d7-e41a-1afaaa1cad45@redhat.com>
 <AM0PR0502MB3795AD42233D69F350402A8AC3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM0PR0502MB3795AD42233D69F350402A8AC3020@AM0PR0502MB3795.eurprd05.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Shahaf Shuler <shahafs@mellanox.com>
Cc: Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jason Gunthorpe <jgg@mellanox.com>, "rob.miller@broadcom.com" <rob.miller@broadcom.com>, "haotian.wang@sifive.com" <haotian.wang@sifive.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "lulu@redhat.com" <lulu@redhat.com>, Parav Pandit <parav@mellanox.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "hch@infradead.org" <hch@infradead.org>, Jiri Pirko <jiri@mellanox.com>, "hanand@xilinx.com" <hanand@xilinx.com>, "mhabets@solarflare.com" <mhab>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 05, 2020 at 09:30:14AM +0000, Shahaf Shuler wrote:
> Wednesday, February 5, 2020 9:50 AM, Jason Wang:
> > Subject: Re: [PATCH] vhost: introduce vDPA based backend
> > On 2020/2/5 下午3:15, Shahaf Shuler wrote:
> > > Wednesday, February 5, 2020 4:03 AM, Tiwei Bie:
> > >> Subject: Re: [PATCH] vhost: introduce vDPA based backend
> > >>
> > >> On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
> > >>> On 2020/1/31 上午11:36, Tiwei Bie wrote:
> > >>>> This patch introduces a vDPA based vhost backend. This backend is
> > >>>> built on top of the same interface defined in virtio-vDPA and
> > >>>> provides a generic vhost interface for userspace to accelerate the
> > >>>> virtio devices in guest.
> > >>>>
> > >>>> This backend is implemented as a vDPA device driver on top of the
> > >>>> same ops used in virtio-vDPA. It will create char device entry
> > >>>> named vhost-vdpa/$vdpa_device_index for userspace to use.
> > Userspace
> > >>>> can use vhost ioctls on top of this char device to setup the backend.
> > >>>>
> > >>>> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > [...]
> > >
> > >>>> +static long vhost_vdpa_do_dma_mapping(struct vhost_vdpa *v) {
> > >>>> +	/* TODO: fix this */
> > >>>
> > >>> Before trying to do this it looks to me we need the following during
> > >>> the probe
> > >>>
> > >>> 1) if set_map() is not supported by the vDPA device probe the IOMMU
> > >>> that is supported by the vDPA device
> > >>> 2) allocate IOMMU domain
> > >>>
> > >>> And then:
> > >>>
> > >>> 3) pin pages through GUP and do proper accounting
> > >>> 4) store GPA->HPA mapping in the umem
> > >>> 5) generate diffs of memory table and using IOMMU API to setup the
> > >>> dma mapping in this method
> > >>>
> > >>> For 1), I'm not sure parent is sufficient for to doing this or need
> > >>> to introduce new API like iommu_device in mdev.
> > >> Agree. We may also need to introduce something like the iommu_device.
> > >>
> > > Would it be better for the map/umnap logic to happen inside each device ?
> > > Devices that needs the IOMMU will call iommu APIs from inside the driver
> > callback.
> > 
> > 
> > Technically, this can work. But if it can be done by vhost-vpda it will make the
> > vDPA driver more compact and easier to be implemented.
> 
> Need to see the layering of such proposal but am not sure. 
> Vhost-vdpa is generic framework, while the DMA mapping is vendor specific. 
> Maybe vhost-vdpa can have some shared code needed to operate on iommu, so drivers can re-use it.  to me it seems simpler than exposing a new iommu device. 
> 
> > 
> > 
> > > Devices that has other ways to do the DMA mapping will call the
> > proprietary APIs.
> > 
> > 
> > To confirm, do you prefer:
> > 
> > 1) map/unmap
> 
> It is not only that. AFAIR there also flush and invalidate calls, right?
> 
> > 
> > or
> > 
> > 2) pass all maps at one time?
> 
> To me this seems more straight forward. 
> It is correct that under hotplug and large number of memory segments
> the driver will need to understand the diff (or not and just reload
> the new configuration).
> However, my assumption here is that memory
> hotplug is heavy flow anyway, and the driver extra cycles will not be
> that visible

I think we can just allow both, after all vhost already has both interfaces ...
We just need a flag that tells userspace whether it needs to
update all maps aggressively or can wait for a fault.

> > 
> > Thanks
> > 
> > 
> > >
> 
