Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D23AB262
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348849; cv=none; b=iPpIE/viO788U4O61d4t77yPHIrtJCkBekkhT+fKK8GKF8Z8FukFezCyYdu7T+UBZaQMx+ks5xDU0At8fBSpPQb4gLOlG0MvH/ehiftIqUw499mBusAqwJrOuMBUMMYKZOe7ZzoMcWJLh9ZjPw/TFFeNTUZEhVFegpQWvwr3oFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348849; c=relaxed/simple;
	bh=ny9+NDKsmXZhKY4e3nqy/x9XFxYxyFVfNU8ZiWTkGzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1rlbcsRZjJT3bm7xpDV5OXLqSP5x/d8Y5nNdJb2N5acRYT+K/jIH5tvXey9CWlTRSjdoVXqJIx1+wrsxG/y9eb8q/KglpIVLtPv1ZfpaSASeCBKOpAz9/wVpPt0fyMN5AyzFbHLc+Hx0QIULlfYI6HhQ3yOErZ+benNno6ZuWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfjE3Pu6; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfjE3Pu6"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2df8de41d6eso5894375ad.1
        for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790348840; x=1790953640; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VJeJx/1VJEA6Gj+/UQ35Ewf5IweeZceECI410Tb+a58=;
        b=hfjE3Pu6zm5YLgfQcA9lx+IKSCbfc+D+Db9URL3aWJQ28ziQJOxAQIqbXam+4X28J9
         tqjAmBOKOTMCJmtuzO5X09Yu4uIy/hRJKIDgmp9n6GLj0OGr24B6BjqL8tVNtskwXy5V
         0CHiIioMVPh1DFfvEZHx0pXKrdhhs89Fl09R4uPtlynRXAnTHaF4uKISPUjSG/K2GJ4H
         HDT5pZ+5ip6RLOIZl1lS6D2mt2gysolk+wie+9/MWvoKvC2Hx6vhTV/YDQ9IpPLB9EGT
         wi7FHpYl93NOQnKqFtXrGrxgA23BaFdCs4qcBkpePwKD0wTDv9qz/hSBo0H/AaKAQDwU
         hKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790348840; x=1790953640;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VJeJx/1VJEA6Gj+/UQ35Ewf5IweeZceECI410Tb+a58=;
        b=KUtLOng2gt6GTcAfTtAolclWjF+0sytXRf7BYZnMCqloWhCO4p9yt1eysNc+IwLJTT
         OEhi5OrbjWfml2tjc1QKEOgIUyK6mTzBBY/HYt6uZZgDPZVKI3tR9esDxU2MbigLdViz
         uMVj5ox1RyMTSqZtupS9mJbLWRUv0CkknLabF0LvCUe9KmNHlGuWcKzzkurGZDpOwq9i
         5Zlfu5gjpDenTn3TZCjr1ahTTuu0GpvGjWLht0HSvVI5iSXyUwzhoVuHCRlSKmS0DCXD
         ztGVZiCo+Iisvh8kFXF6okod43it/2cB+hDXmmrNx0Z62GZXpTA6DDOip5MGu1IEgJii
         n6kg==
X-Forwarded-Encrypted: i=1; AKwUvBxG5L8ukZ9uNle/kMwPZeMVlHbxOgDsqGxp9Ar/WbEM5i4qT0QbLTqoE7DhUttuuW4C2xoWqELHzLIju4NWmQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mJlHX9xME/G6xIkBA36ayRXnsSi8jo81ALsrnfCf7YiDXkAV+O
	JelVFtRz0odZFr+muLBHW6WMpWywz4Qg0rjKBEEbyQQCgJswwtAgvBwJTc9S196KLtI=
X-Gm-Gg: AYBFou21w30L/x1+YFAvyjEZyEM30ZJMqD6g7KKXX7J4sA9wMCvAi1Lxp5KCqhfh7EM
	bqZFXplYGUQnpl7AoR3M1hAbZz9lcLe0tH8HlZFTbXNgaz7jUxvtJCj/e+3qOM4ZiAl7AAGDbK8
	JhnkknbDPYdfKPxYwYj47DRIVd+eMVjtF4NV/FN2rFJkEruHm3EQnPECdfcWVNVWjnNVUTHlId0
	C1Kf4aaJKKP2DukXNVE0aDUBvATOAb7k54hOaVkivkhFNoKQOrxhoqjxuRBeoGAXCd8CjxwCJcC
	z7O4PBQ9Sy9HrVAy1H9TR9f1rVaq8Blk00TDfb2uZzGNWsJQW8GGI0+A8bP1072KAIn1uFAOS8s
	ZjRhwyUKFSDKosFZeQ27bekOmNqeWgMSXlcrTqGt8psu2dToXPNci5wkM6X4aQvT/F42XZdDdJk
	YdtH5IsfYD/UfBKxtXcMcxi3WTT0yozjdX/7wBXg28vCZuK5ZcQoPwuNofRRe+YB3kztxfQAWAC
	hwFSN84epMGSw==
X-Received: by 2002:a17:903:37cd:b0:2dd:c053:c208 with SMTP id d9443c01a7336-2df7dc1ee10mr45697225ad.36.1790348839685;
        Fri, 25 Sep 2026 08:07:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:448f:6909:f2ff:6dca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df9142bfd4sm12487185ad.52.2026.09.25.08.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:07:18 -0700 (PDT)
Date: Fri, 25 Sep 2026 09:07:15 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 06/12] remoteproc: virtio: add bounce buffering for
 data buffers
Message-ID: <araOI_duKIAbphq6@p14s>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-6-dac8c5eb4aa9@valla.it>
 <arKlvZGqu2nt6Ci0@p14s>
 <arLXthhYbKkwZ9zY@bywater>
 <CANLsYkwNOukGX68=NVvwNP7iudP3EcKN6C2L2o9nVCTRxFVxFg@mail.gmail.com>
 <arP38OEaabFFu8lJ@bywater>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arP38OEaabFFu8lJ@bywater>

On Wed, Sep 23, 2026 at 06:05:35PM +0200, Francesco Valla wrote:
> On Wed, Sep 23, 2026 at 08:44:41AM -0600, Mathieu Poirier wrote:
> > On Tue, 22 Sept 2026 at 13:39, Francesco Valla <francesco@valla.it> wrote:
> > >
> > > On Tue, Sep 22, 2026 at 09:58:53AM -0600, Mathieu Poirier wrote:
> > > > On Wed, Sep 16, 2026 at 11:10:51PM +0200, Francesco Valla wrote:
> > > > > Depending on the driver originating them, data buffers used for virtio
> > > > > communication can either:
> > > > >
> > > > >   - already be allocated from the coherent memory area that is
> > > > >     accessible by the remote processor; this is the case of rpmsg
> > > > >     and the rproc flavor of virtio-console;
> > > > >   - be allocated from generic kmem, and thus not accessible directly by
> > > > >     the remote processor.
> > > > >
> > > > > Exploiting the map operations, which are used by the virtio framework
> > > > > when VIRTIO_F_ACCESS_PLATFORM is part of a vdev's feature flags, add
> > > > > bounce buffering for the second case: when the map() callback is called
> > > > > for a buffer, one or more pages of coherent memory are allocated and
> > > > > data is copied to them, then they are exposed to the remote processor;
> > > > > the data is  then bounced back on unmap().
> > > > >
> > > > > The first case is not impacted, since buffers already suitable for
> > > > > remote transmission are passed through.
> > > > >
> > > > > With the bounce buffering in place, any kind of virtio device can be
> > > > > supported through the remoteproc-virtio transport, at least from a
> > > > > data exchange standpoint.
> > > >
> > > > Is this _necessary_ for the imx93 platform you are implementing feature for?
> > > >
> > >
> > > If I don't want to fundamentally change how the remoteproc integration
> > > works (i.e.: using buffers only from a pre-shared area), yes. While in
> > > my test environment the Cortex-M33 serving as remoteproc is able to
> > > access the whole RAM space, that is not always the case.
> > 
> > The first sentence tells me it is mandatory while the second says it
> > is not.  I understand the use case but don't want to bloat the
> > subsystem with code that is trying to address a problem you currently
> > don't have.
> > 
> 
> Let me rephrase: while on i.MX93 the Cortex-M33 can theoretically access
> the whole RAM space, that is not a good idea from a security point of
> view and can be the source of a number of bugs. The target is to
> statically define a static shared memory area (as I am doing on i.MX95)
> and only use that.

As Robin pointed out, have you looked at using a restricted-dma-pool for that?
Note that I am not familiar with the concept but open to go that way if it can
work for us.

Robin, can you point us to a simple example we could look at?

> 
> > 
> > > This is even more important for mixed-criticality-ready processors (say:
> > > i.MX95), where access to different memory areas si defined even before
> > > the various application cores are started.
> > >
> > > For the sake of completeness, there *might be* a completely different
> > > approach that would work: modify every virtio driver to make sure they
> > > allocate buffers from the pre-shared memory area (that is, the coherent
> > > memory pool). That approach would even avoid the bounce buffering and
> > > allow for zero-copy transmission. I even started working on that,
> > > defining virtio helpers to do the allocations instead of using raw
> > > kmallocs, but then I dropped the idea because of the magnitude of the
> > > changes required.
> > >
> > > > >
> > > > > Signed-off-by: Francesco Valla <francesco@valla.it>
> > > > > ---
> > > > >  drivers/remoteproc/remoteproc_virtio.c | 182 +++++++++++++++++++++++++++++++--
> > > > >  include/linux/remoteproc.h             |  14 +++
> > > > >  2 files changed, 190 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> > > > > index cfd66d9d1c9e..d21b3b8044df 100644
> > > > > --- a/drivers/remoteproc/remoteproc_virtio.c
> > > > > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > > > > @@ -241,7 +241,14 @@ static void rproc_virtio_reset(struct virtio_device *vdev)
> > > > >     dev_dbg(&vdev->dev, "reset !\n");
> > > > >  }
> > > > >
> > > > > -/* provide the vdev features as retrieved from the firmware */
> > > > > +/* Provide the vdev features as retrieved from the firmware, plus the following
> > > > > + * additional ones:
> > > > > + *   - VIRTIO_F_VERSION_1 that is required by some non-rpmsg virtio devices
> > > > > + *   - VIRTIO_F_ACCESS_PLATFORM to force usage of the map operations
> > > > > + */
> > > > > +#define RPROC_VIRTIO_STATIC_FEATURES \
> > > > > +   ((1ULL << VIRTIO_F_VERSION_1) | (1ULL << VIRTIO_F_ACCESS_PLATFORM))
> > > > > +
> > > > >  static u64 rproc_virtio_get_features(struct virtio_device *vdev)
> > > > >  {
> > > > >     struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
> > > > > @@ -249,7 +256,7 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
> > > > >
> > > > >     rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
> > > > >
> > > > > -   return rsc->dfeatures | (1ULL << VIRTIO_F_VERSION_1);
> > > > > +   return rsc->dfeatures | RPROC_VIRTIO_STATIC_FEATURES;
> > > > >  }
> > > > >
> > > > >  static void rproc_transport_features(struct virtio_device *vdev)
> > > > > @@ -275,16 +282,16 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
> > > > >     /* Give virtio_rproc a chance to accept features. */
> > > > >     rproc_transport_features(vdev);
> > > > >
> > > > > -   /* Make sure we don't have any features > 32 bits except VIRTIO_F_VERSION_1 */
> > > > > +   /* Make sure we don't have any features > 32 bits */
> > > > >     if (WARN_ON_ONCE((u32)vdev->features !=
> > > > > -                    (vdev->features & ~(1ULL << VIRTIO_F_VERSION_1))))
> > > > > +                    (vdev->features & ~RPROC_VIRTIO_STATIC_FEATURES)))
> > > > >             return -1;
> > > > >
> > > > >     /*
> > > > >      * Remember the finalized features of our vdev, and provide it
> > > > >      * to the remote processor once it is powered on.
> > > > >      */
> > > > > -   rsc->gfeatures = vdev->features & ~(1ULL << VIRTIO_F_VERSION_1);
> > > > > +   rsc->gfeatures = vdev->features & ~RPROC_VIRTIO_STATIC_FEATURES;
> > > > >
> > > > >     return 0;
> > > > >  }
> > > > > @@ -337,6 +344,151 @@ static const struct virtio_config_ops rproc_virtio_config_ops = {
> > > > >     .set            = rproc_virtio_set,
> > > > >  };
> > > > >
> > > > > +static inline unsigned int rproc_virtio_bounce_slot(struct device *dma_dev,
> > > > > +                                               dma_addr_t dma_handle)
> > > > > +{
> > > > > +   const dma_addr_t dma_base = dma_dev_coherent_base(dma_dev);
> > > > > +
> > > > > +   return (dma_handle - dma_base) >> PAGE_SHIFT;
> > > > > +}
> > > > > +
> > > > > +static dma_addr_t rproc_virtio_map_page(union virtio_map map, struct page *page,
> > > > > +                                   unsigned long offset, size_t size,
> > > > > +                                   enum dma_data_direction dir,
> > > > > +                                   unsigned long attrs)
> > > > > +{
> > > > > +   struct device *dev = map.dma_dev;
> > > > > +   struct rproc_vdev *rvdev = dev_get_drvdata(dev);
> > > > > +   dma_addr_t dma_base = dma_dev_coherent_base(dev);
> > > > > +   size_t dma_size = dma_dev_coherent_size(dev);
> > > > > +   phys_addr_t paddr = page_to_phys(page) + offset;
> > > > > +   void *vaddr = page_to_virt(page) + offset;
> > > > > +   struct rproc_map_record *record;
> > > > > +   dma_addr_t map_handle;
> > > > > +   void *bounce;
> > > > > +
> > > > > +   // No need to allocate a bounce buffer if the memory to map is already
> > > > > +   // part of the device's coherent pool.
> > > > > +   if (paddr >= dma_base && paddr < (dma_base + dma_size)) {
> > > > > +           // The allocation details will be recorded also in this case,
> > > > > +           // indicating that no bounce buffer was allocated.
> > > > > +           map_handle = (dma_addr_t)paddr;
> > > > > +           bounce = NULL;
> > > > > +   } else {
> > > > > +           // Allocate bounce buffer from device coherent memory
> > > > > +           bounce = dma_alloc_coherent(dev, size, &map_handle, GFP_KERNEL | __GFP_ZERO);
> > > > > +           if (!bounce)
> > > > > +                   return DMA_MAPPING_ERROR;
> > > > > +
> > > > > +           // Copy data to bounce buffer
> > > > > +           memcpy(bounce, vaddr, size);
> > > > > +   }
> > > > > +
> > > > > +   // Save bounce details
> > > > > +   record = &rvdev->map_records[rproc_virtio_bounce_slot(dev, map_handle)];
> > > > > +
> > > > > +   record->original = vaddr;
> > > > > +   record->size = size;
> > > > > +   record->bounce = bounce;
> > > > > +
> > > > > +   return map_handle;
> > > > > +}
> > > > > +
> > > > > +static void rproc_virtio_unmap_page(union virtio_map map, dma_addr_t map_handle,
> > > > > +                               size_t size, enum dma_data_direction dir,
> > > > > +                               unsigned long attrs)
> > > > > +{
> > > > > +   struct device *dev = map.dma_dev;
> > > > > +   struct rproc_vdev *rvdev = dev_get_drvdata(dev);
> > > > > +   unsigned int slot = rproc_virtio_bounce_slot(dev, map_handle);
> > > > > +   struct rproc_map_record *record = &rvdev->map_records[slot];
> > > > > +
> > > > > +   WARN_ON(size != record->size);
> > > > > +
> > > > > +   // If a bounce buffer was used, copy data back to original one
> > > > > +   if (record->bounce) {
> > > > > +           memcpy(record->original, record->bounce, record->size);
> > > > > +
> > > > > +           dma_free_coherent(dev, record->size, record->bounce, map_handle);
> > > > > +   }
> > > > > +
> > > > > +   record->original = NULL;
> > > > > +   record->size = 0;
> > > > > +   record->bounce = NULL;
> > > > > +}
> > > > > +
> > > > > +static void rproc_virtio_sync_single_for_cpu(union virtio_map map,
> > > > > +                                        dma_addr_t map_handle,
> > > > > +                                        size_t size,
> > > > > +                                        enum dma_data_direction dir)
> > > > > +{
> > > > > +   struct device *dev = map.dma_dev;
> > > > > +
> > > > > +   dma_sync_single_range_for_cpu(dev, (map_handle & PAGE_MASK),
> > > > > +                                 offset_in_page(map_handle), size, dir);
> > > > > +}
> > > > > +
> > > > > +static void rproc_virtio_sync_single_for_device(union virtio_map map,
> > > > > +                                           dma_addr_t map_handle,
> > > > > +                                           size_t size,
> > > > > +                                           enum dma_data_direction dir)
> > > > > +{
> > > > > +   struct device *dev = map.dma_dev;
> > > > > +
> > > > > +   dma_sync_single_range_for_device(dev, (map_handle & PAGE_MASK),
> > > > > +                                    offset_in_page(map_handle), size, dir);
> > > > > +}
> > > > > +
> > > > > +static void *rproc_virtio_alloc(union virtio_map map, size_t size,
> > > > > +                           dma_addr_t *map_handle, gfp_t gfp)
> > > > > +{
> > > > > +   struct device *dev = map.dma_dev;
> > > > > +
> > > > > +   return dma_alloc_coherent(dev, size, map_handle, gfp);
> > > > > +}
> > > > > +
> > > > > +static void rproc_virtio_free(union virtio_map map, size_t size, void *vaddr,
> > > > > +                         dma_addr_t map_handle, unsigned long attrs)
> > > > > +{
> > > > > +   struct device *dev = map.dma_dev;
> > > > > +
> > > > > +   dma_free_coherent(dev, size, vaddr, map_handle);
> > > > > +}
> > > > > +
> > > > > +static bool rproc_virtio_need_sync(union virtio_map map, dma_addr_t map_handle)
> > > > > +{
> > > > > +   struct device *dev = map.dma_dev;
> > > > > +
> > > > > +   return dma_need_sync(dev, map_handle);
> > > > > +}
> > > > > +
> > > > > +static int rproc_virtio_mapping_error(union virtio_map map, dma_addr_t map_handle)
> > > > > +{
> > > > > +   if (unlikely(map_handle == DMA_MAPPING_ERROR))
> > > > > +           return -ENOMEM;
> > > > > +
> > > > > +   return 0;
> > > > > +}
> > > > > +
> > > > > +static inline size_t rproc_virtio_max_mapping_size(union virtio_map map)
> > > > > +{
> > > > > +   struct device *dev = map.dma_dev;
> > > > > +
> > > > > +   return dma_dev_coherent_size(dev);
> > > > > +}
> > > > > +
> > > > > +static const struct virtio_map_ops rproc_virtio_map_ops = {
> > > > > +   .map_page = rproc_virtio_map_page,
> > > > > +   .unmap_page = rproc_virtio_unmap_page,
> > > > > +   .sync_single_for_cpu = rproc_virtio_sync_single_for_cpu,
> > > > > +   .sync_single_for_device = rproc_virtio_sync_single_for_device,
> > > > > +   .alloc = rproc_virtio_alloc,
> > > > > +   .free = rproc_virtio_free,
> > > > > +   .need_sync = rproc_virtio_need_sync,
> > > > > +   .mapping_error = rproc_virtio_mapping_error,
> > > > > +   .max_mapping_size = rproc_virtio_max_mapping_size,
> > > > > +};
> > > > > +
> > > > >  /*
> > > > >   * This function is called whenever vdev is released, and is responsible
> > > > >   * to decrement the remote processor's refcount which was taken when vdev was
> > > > > @@ -355,6 +507,8 @@ static void rproc_virtio_dev_release(struct device *dev)
> > > > >     of_reserved_mem_device_release(&rvdev->pdev->dev);
> > > > >     dma_release_coherent_memory(&rvdev->pdev->dev);
> > > > >
> > > > > +   kvfree(rvdev->map_records);
> > > > > +
> > > > >     put_device(&rvdev->pdev->dev);
> > > > >  }
> > > > >
> > > > > @@ -429,13 +583,29 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
> > > > >             of_reserved_mem_device_init_by_idx(dev, np, 0);
> > > > >     }
> > > > >
> > > > > +   /* Allocate one tracking record for each page of the device reserved
> > > > > +    * memory. Contiguous memory is not required for this array, which can
> > > > > +    * also be quite big (depending on the size of the coherent memory), so
> > > > > +    * let's use vmalloc for this allocation.
> > > > > +    */
> > > > > +   rvdev->map_records = kvcalloc(dma_dev_coherent_size(dev) >> PAGE_SHIFT,
> > > > > +                                 sizeof(*rvdev->map_records),
> > > > > +                                 GFP_KERNEL);
> > > > > +   if (!rvdev->map_records) {
> > > > > +           dev_err(dev, "failed to allocate memory for map records\n");
> > > > > +           return -ENOMEM;
> > > > > +   }
> > > > > +
> > > > >     /* Allocate virtio device */
> > > > >     vdev = kzalloc_obj(*vdev);
> > > > > -   if (!vdev)
> > > > > +   if (!vdev) {
> > > > > +           kvfree(rvdev->map_records);
> > > > >             return -ENOMEM;
> > > > > +   }
> > > > >
> > > > >     vdev->id.device = id;
> > > > >     vdev->config = &rproc_virtio_config_ops;
> > > > > +   vdev->map = &rproc_virtio_map_ops;
> > > > >     vdev->dev.parent = dev;
> > > > >     vdev->dev.release = rproc_virtio_dev_release;
> > > > >
> > > > > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> > > > > index c3ba51fe9e54..2ff48b505ac0 100644
> > > > > --- a/include/linux/remoteproc.h
> > > > > +++ b/include/linux/remoteproc.h
> > > > > @@ -339,10 +339,23 @@ struct rproc_vring {
> > > > >     struct virtqueue *vq;
> > > > >  };
> > > > >
> > > > > +/**
> > > > > + * struct rproc_map_record - remoteproc map record
> > > > > + * @original:      original virtual address
> > > > > + * @num: allocation size
> > > > > + * @bounce: bounce buffer virtual address (NULL if not used)
> > > > > + */
> > > > > +struct rproc_map_record {
> > > > > +   void *original;
> > > > > +   size_t size;
> > > > > +   void *bounce;
> > > > > +};
> > > > > +
> > > > >  /**
> > > > >   * struct rproc_vdev - remoteproc state for a supported virtio device
> > > > >   * @subdev: handle for registering the vdev as a rproc subdevice
> > > > >   * @pdev: remoteproc virtio platform device
> > > > > + * @map_records: array of map records
> > > > >   * @id: virtio device id (as in virtio_ids.h)
> > > > >   * @node: list node
> > > > >   * @rproc: the rproc handle
> > > > > @@ -358,6 +371,7 @@ struct rproc_vdev {
> > > > >     unsigned int id;
> > > > >     struct list_head node;
> > > > >     struct rproc *rproc;
> > > > > +   struct rproc_map_record *map_records;
> > > > >     u32 rsc_offset;
> > > > >     u32 index;
> > > > >     unsigned int num_vrings;
> > > > >
> > > > > --
> > > > > 2.55.0
> > > > >
> > >
> > > Regards,
> > > Francesco
> > >
