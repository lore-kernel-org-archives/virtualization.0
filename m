From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: introduce vDPA based backend
Date: Wed, 5 Feb 2020 00:31:18 -0500
Message-ID: <20200205003048-mutt-send-email-mst@kernel.org>
References: <20200131033651.103534-1-tiwei.bie@intel.com>
 <7aab2892-bb19-a06a-a6d3-9c28bc4c3400@redhat.com>
 <20200204005306-mutt-send-email-mst@kernel.org>
 <cf485e7f-46e3-20d3-8452-e3058b885d0a@redhat.com>
 <20200205020555.GA369236@___>
 <798e5644-ca28-ee46-c953-688af9bccd3b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <798e5644-ca28-ee46-c953-688af9bccd3b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, shahafs@mellanox.com, jgg@mellanox.com, rob.miller@broadcom.com, haotian.wang@sifive.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, rdunlap@infradead.org, hch@infradead.org, jiri@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, maxime.coquelin@redhat.com, lingshan.zhu@intel.com, dan.daly@intel.com, cunming.liang@intel.com, zhihong.wang@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 05, 2020 at 11:12:21AM +0800, Jason Wang wrote:
> 
> On 2020/2/5 上午10:05, Tiwei Bie wrote:
> > On Tue, Feb 04, 2020 at 02:46:16PM +0800, Jason Wang wrote:
> > > On 2020/2/4 下午2:01, Michael S. Tsirkin wrote:
> > > > On Tue, Feb 04, 2020 at 11:30:11AM +0800, Jason Wang wrote:
> > > > > 5) generate diffs of memory table and using IOMMU API to setup the dma
> > > > > mapping in this method
> > > > Frankly I think that's a bunch of work. Why not a MAP/UNMAP interface?
> > > > 
> > > Sure, so that basically VHOST_IOTLB_UPDATE/INVALIDATE I think?
> > Do you mean we let userspace to only use VHOST_IOTLB_UPDATE/INVALIDATE
> > to do the DMA mapping in vhost-vdpa case? When vIOMMU isn't available,
> > userspace will set msg->iova to GPA, otherwise userspace will set
> > msg->iova to GIOVA, and vhost-vdpa module will get HPA from msg->uaddr?
> > 
> > Thanks,
> > Tiwei
> 
> 
> I think so. Michael, do you think this makes sense?
> 
> Thanks

to make sure, could you post the suggested argument format for
these ioctls?

> 
> > 
> > > Thanks
> > > 
> > > 
