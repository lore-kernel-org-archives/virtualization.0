Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12995497B84;
	Wed, 23 Sep 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179568; cv=pass; b=CUSOpbDjYOL5dviqewcn2MvoWwquviZ5E8ONkS71k2qRbkODFI5ANgoue4qjhiAW2KuHdDiba5MhfBt7XDgvMrRRIC2Lh66T+TGPsFjSWHD8MOzmkJ1SEP3zDc/qIZUEi8QW+nYLxOXD33IXuGLVLVCWl1pZ5DsKw+/69Ry77aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179568; c=relaxed/simple;
	bh=IkleXA3PhsAe26br548CaGLPW3um7HiKfzluT6wlItE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iU5jKN7ICXqcEchLkWno5B97AvT5zAI0O+9bsbnMSjcYZN1m/cgaB8kwDhWlRpIP6xbODdonNPxhzkNlQ5A+RX3kazJb/MapPQhh6EorRzASLphhvs/AtrvnnA5/65V0spxSw1xHCummDWSYro7HdlXtHyfZZfSzVH+dbq6eH6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=sGwe8lG6; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=s4i9PNzT; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="sGwe8lG6";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="s4i9PNzT"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-5ns1.prod.antispam.mailspamprotection.com; s=arckey; t=1790179564;
	 b=VkQ9C6U/kxOJSEVZu7er2hdtFfjT+LraoRqwyRjoU56vZ9iQpofQLEOZuqUYbyQpcJns8QrfjI
	  yFxpb4DdmC3sG+hv5pn+1N9j3HX7LAnCdf7nayBP8RHCug6fbZ7Tq82fON8ef8Cox94NiEEgjL
	  q+NcTz/sONBrdNpO3GxEonNxRDrINro4rELbH/urj2lCJD19njUretlOTPCx/VkcVMfIPVa1Ek
	  t5BsjTJYX7o4elKodXEL7mtoSIlmwXlLt/+0Wg3kmPcW+tWQU2PNtIaF0TqP+n4s8G6ttBeb37
	  KygIa1l5iEnD2SPJkwYDXxf/s/Jdz82T3sJesWFIBs/6PQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-5ns1.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-5ns1.prod.antispam.mailspamprotection.com; s=arckey; t=1790179564;
	bh=IkleXA3PhsAe26br548CaGLPW3um7HiKfzluT6wlItE=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=Tv4WNqbm5J2Mtz3L/9YQ7mcKwMOHn0lsFElFKv9HlK5FlQiI+6wELH2+b0QjXJxSyJN9ZtMeqd
	  Oa9iByPilA0X7Uu80IfK7Rnw3N27qeSoItZ0f+OalPvyauBpoyXIvvjRVJoNz6SebyMdeRfVoc
	  L6/mSjZ2ZFLjdlFFldepN5t+Ev4KHCEeIR/UeX2fjNuajLijgVp7UCX/jb4tn31ba0L6XhIRSJ
	  hdzTjuFqrUEXcp1648Hhz2bpNNQx2JDibWmYtXxgkDPAai63uHwOJKRLzfKewM/uppzBot3AHG
	  mMgzSRy7Mro9JTU4ko6OWvPU1RX1mlheugJK2E1ZquNOrA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=ExOume0RxNp+eQGZM9E2Gpt9Yr0okaIsouUpEfdruVo=; b=sGwe8lG6e5YbEupX3jHD09McWZ
	IAaSQM4LxN1babi3szbT3hhikIScSAh2ggItNrdzFpqjY4c6LSjhu0Qw4xL3xcCaI88G22vzjKOyv
	rGu0kJGTKaSIjtCUTUWlvCibBaCjJvR0d1UwSdIKoFCTBLD6D3u5XbjbJVfMDyBosXt4=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-5ns1.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1x9PTp-00000000AbM-07go;
	Wed, 23 Sep 2026 16:05:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=ExOume0RxNp+eQGZM9E2Gpt9Yr0okaIsouUpEfdruVo=; b=s4i9PNzTPS62uqMOP/zZ9XctFI
	jIElpj7SRnkH0ZaguZf78ZyKYruKevLb9KBtK57yE+YWCCUwi/tSHNCZAmFqcf8pwQebSBrcXQU6O
	swQN8EKNBoG9Bko/jF5glgrDil4PnDtsDmOYHiWM5Q5RD0zIU84EGZ0AHwRznGt1Tm6k=;
Received: from [79.45.60.29] (port=59672 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1x9PTV-00000000GNB-0mZC;
	Wed, 23 Sep 2026 16:05:37 +0000
Date: Wed, 23 Sep 2026 18:05:35 +0200
From: Francesco Valla <francesco@valla.it>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	virtualization@lists.linux.dev, imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 06/12] remoteproc: virtio: add bounce buffering for
 data buffers
Message-ID: <arP38OEaabFFu8lJ@bywater>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>
 <arKlvZGqu2nt6Ci0@p14s>
 <arLXthhYbKkwZ9zY@bywater>
 <CANLsYkwNOukGX68=NVvwNP7iudP3EcKN6C2L2o9nVCTRxFVxFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwNOukGX68=NVvwNP7iudP3EcKN6C2L2o9nVCTRxFVxFg@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 6ef30e3b5c1021a44f8818d23a577ebd
X-AntiAbuse: ID - 6ef30e3b5c1021a44f8818d23a577ebd
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1x9PTp-00000000AbM-07go-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-5ns1.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Wed, Sep 23, 2026 at 08:44:41AM -0600, Mathieu Poirier wrote:
> On Tue, 22 Sept 2026 at 13:39, Francesco Valla <francesco@valla.it> wrote:
> >
> > On Tue, Sep 22, 2026 at 09:58:53AM -0600, Mathieu Poirier wrote:
> > > On Wed, Sep 16, 2026 at 11:10:51PM +0200, Francesco Valla wrote:
> > > > Depending on the driver originating them, data buffers used for virtio
> > > > communication can either:
> > > >
> > > >   - already be allocated from the coherent memory area that is
> > > >     accessible by the remote processor; this is the case of rpmsg
> > > >     and the rproc flavor of virtio-console;
> > > >   - be allocated from generic kmem, and thus not accessible directly by
> > > >     the remote processor.
> > > >
> > > > Exploiting the map operations, which are used by the virtio framework
> > > > when VIRTIO_F_ACCESS_PLATFORM is part of a vdev's feature flags, add
> > > > bounce buffering for the second case: when the map() callback is called
> > > > for a buffer, one or more pages of coherent memory are allocated and
> > > > data is copied to them, then they are exposed to the remote processor;
> > > > the data is  then bounced back on unmap().
> > > >
> > > > The first case is not impacted, since buffers already suitable for
> > > > remote transmission are passed through.
> > > >
> > > > With the bounce buffering in place, any kind of virtio device can be
> > > > supported through the remoteproc-virtio transport, at least from a
> > > > data exchange standpoint.
> > >
> > > Is this _necessary_ for the imx93 platform you are implementing feature for?
> > >
> >
> > If I don't want to fundamentally change how the remoteproc integration
> > works (i.e.: using buffers only from a pre-shared area), yes. While in
> > my test environment the Cortex-M33 serving as remoteproc is able to
> > access the whole RAM space, that is not always the case.
> 
> The first sentence tells me it is mandatory while the second says it
> is not.  I understand the use case but don't want to bloat the
> subsystem with code that is trying to address a problem you currently
> don't have.
> 

Let me rephrase: while on i.MX93 the Cortex-M33 can theoretically access
the whole RAM space, that is not a good idea from a security point of
view and can be the source of a number of bugs. The target is to
statically define a static shared memory area (as I am doing on i.MX95)
and only use that.

> 
> > This is even more important for mixed-criticality-ready processors (say:
> > i.MX95), where access to different memory areas si defined even before
> > the various application cores are started.
> >
> > For the sake of completeness, there *might be* a completely different
> > approach that would work: modify every virtio driver to make sure they
> > allocate buffers from the pre-shared memory area (that is, the coherent
> > memory pool). That approach would even avoid the bounce buffering and
> > allow for zero-copy transmission. I even started working on that,
> > defining virtio helpers to do the allocations instead of using raw
> > kmallocs, but then I dropped the idea because of the magnitude of the
> > changes required.
> >
> > > >
> > > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > > ---
> > > >  drivers/remoteproc/remoteproc_virtio.c | 182 +++++++++++++++++++++++++++++++--
> > > >  include/linux/remoteproc.h             |  14 +++
> > > >  2 files changed, 190 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> > > > index cfd66d9d1c9e..d21b3b8044df 100644
> > > > --- a/drivers/remoteproc/remoteproc_virtio.c
> > > > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > > > @@ -241,7 +241,14 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
> > > >     dev_dbg(&vdev->dev, "reset !\n");
> > > >  }
> > > >
> > > > -/* provide the vdev features as retrieved from the firmware */
> > > > +/* Provide the vdev features as retrieved from the firmware, plus the following
> > > > + * additional ones:
> > > > + *   - VIRTIO_F_VERSION_1 that is required by some non-rpmsg virtio devices
> > > > + *   - VIRTIO_F_ACCESS_PLATFORM to force usage of the map operations
> > > > + */
> > > > +#define RPROC_VIRTIO_STATIC_FEATURES \
> > > > +   ((1ULL << VIRTIO_F_VERSION_1) | (1ULL << VIRTIO_F_ACCESS_PLATFORM))
> > > > +
> > > >  static u64 rproc_virtio_get_features(struct virtio_device *vdev)
> > > >  {
> > > >     struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
> > > > @@ -249,7 +256,7 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
> > > >
> > > >     rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
> > > >
> > > > -   return rsc->dfeatures | (1ULL << VIRTIO_F_VERSION_1);
> > > > +   return rsc->dfeatures | RPROC_VIRTIO_STATIC_FEATURES;
> > > >  }
> > > >
> > > >  static void rproc_transport_features(struct virtio_device *vdev)
> > > > @@ -275,16 +282,16 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
> > > >     /* Give virtio_rproc a chance to accept features. */
> > > >     rproc_transport_features(vdev);
> > > >
> > > > -   /* Make sure we don't have any features > 32 bits except VIRTIO_F_VERSION_1 */
> > > > +   /* Make sure we don't have any features > 32 bits */
> > > >     if (WARN_ON_ONCE((u32)vdev->features !=
> > > > -                    (vdev->features & ~(1ULL << VIRTIO_F_VERSION_1))))
> > > > +                    (vdev->features & ~RPROC_VIRTIO_STATIC_FEATURES)))
> > > >             return -1;
> > > >
> > > >     /*
> > > >      * Remember the finalized features of our vdev, and provide it
> > > >      * to the remote processor once it is powered on.
> > > >      */
> > > > -   rsc->gfeatures = vdev->features & ~(1ULL << VIRTIO_F_VERSION_1);
> > > > +   rsc->gfeatures = vdev->features & ~RPROC_VIRTIO_STATIC_FEATURES;
> > > >
> > > >     return 0;
> > > >  }
> > > > @@ -337,6 +344,151 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
> > > >     .set            = rproc_virtio_set,
> > > >  };
> > > >
> > > > +static inline unsigned int rproc_virtio_bounce_slot(struct device *dma_dev,
> > > > +                                               dma_addr_t dma_handle)
> > > > +{
> > > > +   const dma_addr_t dma_base = dma_dev_coherent_base(dma_dev);
> > > > +
> > > > +   return (dma_handle - dma_base) >> PAGE_SHIFT;
> > > > +}
> > > > +
> > > > +static dma_addr_t rproc_virtio_map_page(union virtio_map map, struct page *page,
> > > > +                                   unsigned long offset, size_t size,
> > > > +                                   enum dma_data_direction dir,
> > > > +                                   unsigned long attrs)
> > > > +{
> > > > +   struct device *dev = map.dma_dev;
> > > > +   struct rproc_vdev *rvdev = dev_get_drvdata(dev);
> > > > +   dma_addr_t dma_base = dma_dev_coherent_base(dev);
> > > > +   size_t dma_size = dma_dev_coherent_size(dev);
> > > > +   phys_addr_t paddr = page_to_phys(page) + offset;
> > > > +   void *vaddr = page_to_virt(page) + offset;
> > > > +   struct rproc_map_record *record;
> > > > +   dma_addr_t map_handle;
> > > > +   void *bounce;
> > > > +
> > > > +   // No need to allocate a bounce buffer if the memory to map is already
> > > > +   // part of the device's coherent pool.
> > > > +   if (paddr >= dma_base && paddr < (dma_base + dma_size)) {
> > > > +           // The allocation details will be recorded also in this case,
> > > > +           // indicating that no bounce buffer was allocated.
> > > > +           map_handle = (dma_addr_t)paddr;
> > > > +           bounce = NULL;
> > > > +   } else {
> > > > +           // Allocate bounce buffer from device coherent memory
> > > > +           bounce = dma_alloc_coherent(dev, size, &map_handle, GFP_KERNEL | __GFP_ZERO);
> > > > +           if (!bounce)
> > > > +                   return DMA_MAPPING_ERROR;
> > > > +
> > > > +           // Copy data to bounce buffer
> > > > +           memcpy(bounce, vaddr, size);
> > > > +   }
> > > > +
> > > > +   // Save bounce details
> > > > +   record = &rvdev->map_records[rproc_virtio_bounce_slot(dev, map_handle)];
> > > > +
> > > > +   record->original = vaddr;
> > > > +   record->size = size;
> > > > +   record->bounce = bounce;
> > > > +
> > > > +   return map_handle;
> > > > +}
> > > > +
> > > > +static void rproc_virtio_unmap_page(union virtio_map map, dma_addr_t map_handle,
> > > > +                               size_t size, enum dma_data_direction dir,
> > > > +                               unsigned long attrs)
> > > > +{
> > > > +   struct device *dev = map.dma_dev;
> > > > +   struct rproc_vdev *rvdev = dev_get_drvdata(dev);
> > > > +   unsigned int slot = rproc_virtio_bounce_slot(dev, map_handle);
> > > > +   struct rproc_map_record *record = &rvdev->map_records[slot];
> > > > +
> > > > +   WARN_ON(size != record->size);
> > > > +
> > > > +   // If a bounce buffer was used, copy data back to original one
> > > > +   if (record->bounce) {
> > > > +           memcpy(record->original, record->bounce, record->size);
> > > > +
> > > > +           dma_free_coherent(dev, record->size, record->bounce, map_handle);
> > > > +   }
> > > > +
> > > > +   record->original = NULL;
> > > > +   record->size = 0;
> > > > +   record->bounce = NULL;
> > > > +}
> > > > +
> > > > +static void rproc_virtio_sync_single_for_cpu(union virtio_map map,
> > > > +                                        dma_addr_t map_handle,
> > > > +                                        size_t size,
> > > > +                                        enum dma_data_direction dir)
> > > > +{
> > > > +   struct device *dev = map.dma_dev;
> > > > +
> > > > +   dma_sync_single_range_for_cpu(dev, (map_handle & PAGE_MASK),
> > > > +                                 offset_in_page(map_handle), size, dir);
> > > > +}
> > > > +
> > > > +static void rproc_virtio_sync_single_for_device(union virtio_map map,
> > > > +                                           dma_addr_t map_handle,
> > > > +                                           size_t size,
> > > > +                                           enum dma_data_direction dir)
> > > > +{
> > > > +   struct device *dev = map.dma_dev;
> > > > +
> > > > +   dma_sync_single_range_for_device(dev, (map_handle & PAGE_MASK),
> > > > +                                    offset_in_page(map_handle), size, dir);
> > > > +}
> > > > +
> > > > +static void *rproc_virtio_alloc(union virtio_map map, size_t size,
> > > > +                           dma_addr_t *map_handle, gfp_t gfp)
> > > > +{
> > > > +   struct device *dev = map.dma_dev;
> > > > +
> > > > +   return dma_alloc_coherent(dev, size, map_handle, gfp);
> > > > +}
> > > > +
> > > > +static void rproc_virtio_free(union virtio_map map, size_t size, void *vaddr,
> > > > +                         dma_addr_t map_handle, unsigned long attrs)
> > > > +{
> > > > +   struct device *dev = map.dma_dev;
> > > > +
> > > > +   dma_free_coherent(dev, size, vaddr, map_handle);
> > > > +}
> > > > +
> > > > +static bool rproc_virtio_need_sync(union virtio_map map, dma_addr_t map_handle)
> > > > +{
> > > > +   struct device *dev = map.dma_dev;
> > > > +
> > > > +   return dma_need_sync(dev, map_handle);
> > > > +}
> > > > +
> > > > +static int rproc_virtio_mapping_error(union virtio_map map, dma_addr_t map_handle)
> > > > +{
> > > > +   if (unlikely(map_handle == DMA_MAPPING_ERROR))
> > > > +           return -ENOMEM;
> > > > +
> > > > +   return 0;
> > > > +}
> > > > +
> > > > +static inline size_t rproc_virtio_max_mapping_size(union virtio_map map)
> > > > +{
> > > > +   struct device *dev = map.dma_dev;
> > > > +
> > > > +   return dma_dev_coherent_size(dev);
> > > > +}
> > > > +
> > > > +static const struct virtio_map_ops rproc_virtio_map_ops = {
> > > > +   .map_page = rproc_virtio_map_page,
> > > > +   .unmap_page = rproc_virtio_unmap_page,
> > > > +   .sync_single_for_cpu = rproc_virtio_sync_single_for_cpu,
> > > > +   .sync_single_for_device = rproc_virtio_sync_single_for_device,
> > > > +   .alloc = rproc_virtio_alloc,
> > > > +   .free = rproc_virtio_free,
> > > > +   .need_sync = rproc_virtio_need_sync,
> > > > +   .mapping_error = rproc_virtio_mapping_error,
> > > > +   .max_mapping_size = rproc_virtio_max_mapping_size,
> > > > +};
> > > > +
> > > >  /*
> > > >   * This function is called whenever vdev is released, and is responsible
> > > >   * to decrement the remote processor's refcount which was taken when vdev was
> > > > @@ -355,6 +507,8 @@ static void rproc_virtio_dev_release(struct device *dev)
> > > >     of_reserved_mem_device_release(&rvdev->pdev->dev);
> > > >     dma_release_coherent_memory(&rvdev->pdev->dev);
> > > >
> > > > +   kvfree(rvdev->map_records);
> > > > +
> > > >     put_device(&rvdev->pdev->dev);
> > > >  }
> > > >
> > > > @@ -429,13 +583,29 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> > > >             of_reserved_mem_device_init_by_idx(dev, np, 0);
> > > >     }
> > > >
> > > > +   /* Allocate one tracking record for each page of the device reserved
> > > > +    * memory. Contiguous memory is not required for this array, which can
> > > > +    * also be quite big (depending on the size of the coherent memory), so
> > > > +    * let's use vmalloc for this allocation.
> > > > +    */
> > > > +   rvdev->map_records = kvcalloc(dma_dev_coherent_size(dev) >> PAGE_SHIFT,
> > > > +                                 sizeof(*rvdev->map_records),
> > > > +                                 GFP_KERNEL);
> > > > +   if (!rvdev->map_records) {
> > > > +           dev_err(dev, "failed to allocate memory for map records\n");
> > > > +           return -ENOMEM;
> > > > +   }
> > > > +
> > > >     /* Allocate virtio device */
> > > >     vdev = kzalloc_obj(*vdev);
> > > > -   if (!vdev)
> > > > +   if (!vdev) {
> > > > +           kvfree(rvdev->map_records);
> > > >             return -ENOMEM;
> > > > +   }
> > > >
> > > >     vdev->id.device = id;
> > > >     vdev->config = &rproc_virtio_config_ops;
> > > > +   vdev->map = &rproc_virtio_map_ops;
> > > >     vdev->dev.parent = dev;
> > > >     vdev->dev.release = rproc_virtio_dev_release;
> > > >
> > > > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > > > index c3ba51fe9e54..2ff48b505ac0 100644
> > > > --- a/include/linux/remoteproc.h
> > > > +++ b/include/linux/remoteproc.h
> > > > @@ -339,10 +339,23 @@ struct rproc_vring {
> > > >     struct virtqueue *vq;
> > > >  };
> > > >
> > > > +/**
> > > > + * struct rproc_map_record - remoteproc map record
> > > > + * @original:      original virtual address
> > > > + * @num: allocation size
> > > > + * @bounce: bounce buffer virtual address (NULL if not used)
> > > > + */
> > > > +struct rproc_map_record {
> > > > +   void *original;
> > > > +   size_t size;
> > > > +   void *bounce;
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct rproc_vdev - remoteproc state for a supported virtio device
> > > >   * @subdev: handle for registering the vdev as a rproc subdevice
> > > >   * @pdev: remoteproc virtio platform device
> > > > + * @map_records: array of map records
> > > >   * @id: virtio device id (as in virtio_ids.h)
> > > >   * @node: list node
> > > >   * @rproc: the rproc handle
> > > > @@ -358,6 +371,7 @@ struct rproc_vdev {
> > > >     unsigned int id;
> > > >     struct list_head node;
> > > >     struct rproc *rproc;
> > > > +   struct rproc_map_record *map_records;
> > > >     u32 rsc_offset;
> > > >     u32 index;
> > > >     unsigned int num_vrings;
> > > >
> > > > --
> > > > 2.55.0
> > > >
> >
> > Regards,
> > Francesco
> >
