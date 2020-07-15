From: Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Date: Wed, 15 Jul 2020 10:06:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.21.2007151001140.4124@sstabellini-ThinkPad-T480s>
References: <20200624163940-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s> <20200624181026-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org> <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s> <20200701133456.GA23888@infradead.org> <alpine.DEB.2.21.2007011020320.8121@sstabellini-ThinkPad-T480s> <20200701172219-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2007101019340.4124@sstabellini-ThinkPad-T480s> <20200711144334-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200711144334-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com, Peng Fan <peng.fan@nxp.com>, konrad.wilk@oracle.com, jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, linux-imx@nxp.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 11 Jul 2020, Michael S. Tsirkin wrote:
> On Fri, Jul 10, 2020 at 10:23:22AM -0700, Stefano Stabellini wrote:
> > Sorry for the late reply -- a couple of conferences kept me busy.
> > 
> > 
> > On Wed, 1 Jul 2020, Michael S. Tsirkin wrote:
> > > On Wed, Jul 01, 2020 at 10:34:53AM -0700, Stefano Stabellini wrote:
> > > > Would you be in favor of a more flexible check along the lines of the
> > > > one proposed in the patch that started this thread:
> > > > 
> > > >     if (xen_vring_use_dma())
> > > >             return true;
> > > > 
> > > > 
> > > > xen_vring_use_dma would be implemented so that it returns true when
> > > > xen_swiotlb is required and false otherwise.
> > > 
> > > Just to stress - with a patch like this virtio can *still* use DMA API
> > > if PLATFORM_ACCESS is set. So if DMA API is broken on some platforms
> > > as you seem to be saying, you guys should fix it before doing something
> > > like this..
> > 
> > Yes, DMA API is broken with some interfaces (specifically: rpmesg and
> > trusty), but for them PLATFORM_ACCESS is never set. That is why the
> > errors weren't reported before. Xen special case aside, there is no
> > problem under normal circumstances.
> 
> So why not fix DMA API? Then this patch is not needed.

It looks like the conversation is going in circles :-)

I tried to explain the reason why, even if we fixed the DMA API to work
with rpmesg and trusty, we still need this patch with the following
email:  https://marc.info/?l=linux-kernel&m=159347446709625&w=2


At that time it looked like you agreed that we needed to improve this
check?  (https://marc.info/?l=linux-kernel&m=159363662418250&w=2)
