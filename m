From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Wed, 5 Feb 2020 02:16:57 -0500
Message-ID: <20200205020547-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200204005306-mutt-send-email-mst@kernel.org>
 <cf485e7f-46e3-20d3-8452-e3058b885d0a@redhat.com>
 <20200205020555.GA369236@___>
 <798e5644-ca28-ee46-c953-688af9bccd3b@redhat.com>
 <20200205003048-mutt-send-email-mst@kernel.org>
 <eb53d1c2-92ae-febf-f502-2d3e107ee608@redhat.com>
 <20200205011935-mutt-send-email-mst@kernel.org>
 <2dd43fb5-6f02-2dcc-5c27-9f7419ef72fc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2dd43fb5-6f02-2dcc-5c27-9f7419ef72fc@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com, rob.miller@broadcom.com, haotian.wang@sifive.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, rdunlap@infradead.org, hch@infradead.org, jiri@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 05, 2020 at 02:49:31PM +0800, Jason Wang wrote:
> 
> On 2020/2/5 下午2:30, Michael S. Tsirkin wrote:
> > On Wed, Feb 05, 2020 at 01:50:28PM +0800, Jason Wang wrote:
> > > On 2020/2/5 下午1:31, Michael S. Tsirkin wrote:
> > > > On Wed, Feb 05, 2020 at 11:12:21AM +0800, Jason Wang wrote:
> > > > > On 2020/2/5 上午10:05, Tiwei Bie wrote:
> > > > > > On Tue, Feb 04, 2020 at 02:46:16PM +0800, Jason Wang wrote:
> > > > > > > On 2020/2/4 下午2:01, Michael S. Tsirkin wrote:
> > > > > > > > On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
> > > > > > > > > 5) generate diffs of memory table and using IOMMU API to setup the dma
> > > > > > > > > mapping in this method
> > > > > > > > Frankly I think that's a bunch of work. Why not a MAP/UNMAP interface?
> > > > > > > > 
> > > > > > > Sure, so that basically VHOST_IOTLB_UPDATE/INVALIDATE I think?
> > > > > > Do you mean we let userspace to only use VHOST_IOTLB_UPDATE/INVALIDATE
> > > > > > to do the DMA mapping in vhost-vdpa case? When vIOMMU isn't available,
> > > > > > userspace will set msg->iova to GPA, otherwise userspace will set
> > > > > > msg->iova to GIOVA, and vhost-vdpa module will get HPA from msg->uaddr?
> > > > > > 
> > > > > > Thanks,
> > > > > > Tiwei
> > > > > I think so. Michael, do you think this makes sense?
> > > > > 
> > > > > Thanks
> > > > to make sure, could you post the suggested argument format for
> > > > these ioctls?
> > > > 
> > > It's the existed uapi:
> > > 
> > > /* no alignment requirement */
> > > struct vhost_iotlb_msg {
> > >      __u64 iova;
> > >      __u64 size;
> > >      __u64 uaddr;
> > > #define VHOST_ACCESS_RO      0x1
> > > #define VHOST_ACCESS_WO      0x2
> > > #define VHOST_ACCESS_RW      0x3
> > >      __u8 perm;
> > > #define VHOST_IOTLB_MISS           1
> > > #define VHOST_IOTLB_UPDATE         2
> > > #define VHOST_IOTLB_INVALIDATE     3
> > > #define VHOST_IOTLB_ACCESS_FAIL    4
> > >      __u8 type;
> > > };
> > > 
> > > #define VHOST_IOTLB_MSG 0x1
> > > #define VHOST_IOTLB_MSG_V2 0x2
> > > 
> > > struct vhost_msg {
> > >      int type;
> > >      union {
> > >          struct vhost_iotlb_msg iotlb;
> > >          __u8 padding[64];
> > >      };
> > > };
> > > 
> > > struct vhost_msg_v2 {
> > >      __u32 type;
> > >      __u32 reserved;
> > >      union {
> > >          struct vhost_iotlb_msg iotlb;
> > >          __u8 padding[64];
> > >      };
> > > };
> > Oh ok.  So with a real device, I suspect we do not want to wait for each
> > change to be processed by device completely, so we might want an asynchronous variant
> > and then some kind of flush that tells device "you better apply these now".
> 
> 
> Let me explain:
> 
> There are two types of devices:
> 
> 1) device without on-chip IOMMU, DMA was done via IOMMU API which only
> support incremental map/unmap

Most IOMMUs have queues nowdays though. Whether APIs within kernel
expose that matters but we are better off on emulating
hardware not specific guest behaviour.

> 2) device with on-chip IOMMU, DMA could be done by device driver itself, and
> we could choose to pass the whole mappings to the driver at one time through
> vDPA bus operation (set_map)
> 
> For vhost-vpda, there're two types of memory mapping:
> 
> a) memory table, setup by userspace through VHOST_SET_MEM_TABLE, the whole
> mapping is updated in this way
> b) IOTLB API, incrementally done by userspace through vhost message
> (IOTLB_UPDATE/IOTLB_INVALIDATE)
> 
> The current design is:
> 
> - Reuse VHOST_SET_MEM_TABLE, and for type 1), we can choose to send diffs
> through IOMMU API or flush all the mappings then map new ones. For type 2),
> just send the whole mapping through set_map()

I know that at least for RDMA based things, you can't change
a mapping if it's active. So drivers will need to figure out the
differences which just looks ugly: userspace knows what
it was changing (really just adding/removing some guest memory).



> - Reuse vhost IOTLB, so for type 1), simply forward update/invalidate
> request via IOMMU API, for type 2), send IOTLB to vDPA device driver via
> set_map(), device driver may choose to send diffs or rebuild all mapping at
> their will
> 
> Technically we can use vhost IOTLB API (map/umap) for building
> VHOST_SET_MEM_TABLE, but to avoid device to process the each request, it
> looks to me we need new UAPI which seems sub optimal.
> 
> What's you thought?
> 
> Thanks

I suspect we can't completely avoid a new UAPI.

> 
> > 
