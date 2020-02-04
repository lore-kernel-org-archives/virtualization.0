From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 5/5] vdpasim: vDPA device simulator
Date: Tue, 4 Feb 2020 08:52:04 -0400
Message-ID: <20200204125204.GS23346@mellanox.com>
References: <20200116124231.20253-1-jasowang@redhat.com>
 <20200116124231.20253-6-jasowang@redhat.com>
 <1b86d188-0666-f6ab-e3b3-bec1cfbd0c76@linux.intel.com>
 <cca7901b-51dd-4f4b-5c30-c42577ad5194@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cca7901b-51dd-4f4b-5c30-c42577ad5194@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@linux.intel.com>, mst@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, tiwei.bie@intel.com, maxime.coquelin@redhat.com, cunming.liang@intel.com, zhihong.wang@intel.com, rob.miller@broadcom.com, xiao.w.wang@intel.com, haotian.wang@sifive.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com, kevin.tian@intel.com, stefanha@redhat.com, rdunlap@infradead.org, hch@infradead.org, aadam@redhat.com, jakub.kicinski@netronome.com, jiri@mellanox.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 04, 2020 at 04:28:27PM +0800, Jason Wang wrote:
> 
> On 2020/2/4 下午4:21, Zhu Lingshan wrote:
> > > +static const struct dma_map_ops vdpasim_dma_ops = {
> > > +    .map_page = vdpasim_map_page,
> > > +    .unmap_page = vdpasim_unmap_page,
> > > +    .alloc = vdpasim_alloc_coherent,
> > > +    .free = vdpasim_free_coherent,
> > > +};
> > > +
> > 
> > Hey Jason,
> > 
> > IMHO, it would be nice if dma_ops of the parent device could be re-used.
> > vdpa_device is expecting to represent a physical device except this
> > simulator, however, there are not enough information in vdpa_device.dev
> > to indicating which kind physical device it attached to. Namely
> > get_arch_dma_ops(struct bus type) can not work on vdpa_device.dev. Then
> > it seems device drivers need to implement a wrap of dma_ops of parent
> > devices. Can this work be done in the vdpa framework since it looks like
> > a common task? Can "vd_dev->vdev.dev.parent = vdpa->dev->parent;" in
> > virtio_vdpa_probe() do the work?
> > 
> > Thanks,
> > BR
> > Zhu Lingshan
> 
> 
> Good catch.
> 
> I think we can.

IMHO you need to specify some 'dma_device', not try and play tricks
with dma_ops, or assuming the parent is always the device used for
dma.

Jason
