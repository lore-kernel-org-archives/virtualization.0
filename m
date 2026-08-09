Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A3222565
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786315148; cv=none; b=b9MEIfwBVHEurEzFip9vhy729MG1Cp4iAVj4rQJY8xBpsjTKYBjrPraBer6fkLAdjBErnMKBGWx+okgdr6ri4yY5SZCJb+GGN4j/vRwBf3CqnjlUgs6jfDXHcFSUTx3yqrjoqYYtS710Thg2uMHVjNmvUD1vdE3Buxx45lazHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786315148; c=relaxed/simple;
	bh=Dalg7cFF6fX6NBgGcwFkLq/lmC3Wtsp6551VddC7th4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=W22MuSFv4NtfTdpZHFKSpI/tKixsGFV0tQqF+s1jllhiQzR6H+Dh1MsbXKg/vlboycQ7I9TWcKyQTWSQjO8JZS8Fs0jhtu33MrQXyi3clV4VmzA8w6tWIv+SObvahthMV5VU8D8UA5caQrbj9mWO0i1wyEEeJRl9FkFNF/hsZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CpunZpNw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpunZpNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786315143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7C2qCr+WzFNSvamGWqb4SdQPSKgxPv5LMVE7xVp544=;
	b=CpunZpNw0HIR9ZDlee97s2ce3uLCsqkBanv1joaLLD5VNtR7KJvvCuTDU0yv300JDvEsM6
	MvYD03uF+jhU5I6u11qUzhN7CP4+dAq5Nwsba7g1M4ylBNmn+4vMU3KF+r9bh2bxXZrLAK
	dQMIfk/VpmevXdDmgsuU6CpxFC8tjnw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-OqVpqigFMwuSXj9BiO1kIw-1; Sun, 09 Aug 2026 18:39:01 -0400
X-MC-Unique: OqVpqigFMwuSXj9BiO1kIw-1
X-Mimecast-MFC-AGG-ID: OqVpqigFMwuSXj9BiO1kIw_1786315140
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767b782so11311145e9.2
        for <virtualization@lists.linux.dev>; Sun, 09 Aug 2026 15:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786315140; x=1786919940;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7C2qCr+WzFNSvamGWqb4SdQPSKgxPv5LMVE7xVp544=;
        b=gk29jOIxf/bIHcOO9MNjsbZ2CddZxwTJc7GCQh8QVn0hT0UCeQa18AcAE0RMESaMa3
         1HsZ8FS/oLqL20bvWBq8apfePBizIg9JvPWvm62bsDUugXB1vVoDE5No7A76LioVijPU
         c36gHG4wVlp+Of3XTqAVIMi8f2gQltR96t+sh893Do/aBcNiqGAHeDfDg6iI614n2XHz
         sfkU8dbapitcLyFWZcvB/eE8/o1DVk0esjXywhOp55Q+c+7jCKzKDMQ6iYTxZCnZpFER
         ChnNxyCTOtRN/nfzoUrr93ZjtBm4v05fK+XXdO9/HnI2yFeePsC/wfemE3yWaQa/kqda
         ye2A==
X-Forwarded-Encrypted: i=1; AHgh+RoW3gqprIMbTMzprwmN1hQTwp3ax9CbLgmrnHUR5olzXpN10sB5+AWjMAHnEFcCubQFSIOkrzvzBUuS0WaNKg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw96P4jbXT5LFwFMIVO7rnNqFZ5t+ZR6CBGECfA4R/HLiVYEjeA
	1465IaCXG8r9kDEnHBAAv7xWOdDGFFL5HyH7QcDSQptYwHMxxZmVcjzTzjPhDADBdfGL8flr3c+
	dSwdTy3S0imaGLY0Ow+ud5YB9b+CE3dWGR85OOWSKXzITqnDyOIytsCFZkK17ZsG7k2FK
X-Gm-Gg: AR+sD10u0FKBnXALeFe3194ZFJY/3K879mDCnz3l2zsyzWcYkPgeJ17RBX5UDIJxD8I
	IHdQT9BpWoV42TGvemGBIKAFd9rkzqzuqUzhcZ5Px+557mBgQz1VVBsPjk522XqtWoMmDSit1Pu
	x+lPr8eFImB3T/mE1TtyZ1qq3WtWxDB+PryM0LZsdcGK7MyvD/TichLRRztk1qrv/3mbr/oNbDb
	20kpKo5uNdjsK6YIv6o/f93FoqRem//aiAUwtkOvY21YY3uQ6PrTkDUIyWgROhCR8GMdm/PYy9r
	6k6vzNtpIEm0xbg6Sy4yUDmXdrcQdLM95wmEBxaPIKsnG4+afS4KweeK1gZedPzc6ndABB/4fxq
	ahA4SGv+F+NMysotOMI4Evg==
X-Received: by 2002:a05:600c:b85:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-4995e0dff0amr241811145e9.15.1786315139769;
        Sun, 09 Aug 2026 15:38:59 -0700 (PDT)
X-Received: by 2002:a05:600c:b85:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-4995e0dff0amr241810375e9.15.1786315138115;
        Sun, 09 Aug 2026 15:38:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220a6d9sm30985227f8f.34.2026.08.09.15.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 15:38:56 -0700 (PDT)
Date: Sun, 9 Aug 2026 18:38:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	nh-open-source@amazon.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 06/12] virtio: add a device memory buffer region
 allocator
Message-ID: <20260809181455-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260809182010.32931-7-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260809182010.32931-7-graf@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Eb4SnMyj_vAuFGAJJ2DamnlWMhKmj2q7GU2-GgwEX_c_1786315140
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 09, 2026 at 06:20:04PM +0000, Alexander Graf wrote:
> In preparation to support VIRTIO_F_DMB, create a mechanism to allocate
> and map memory from the Device Memory Buffer (DMB). The DMB is a shared
> memory region a device exposes and owns. A device that negotiates the
> feature expects its virtqueues and all the buffers we hand it to live in
> that region, and every address we publish to it is a byte offset into
> the region.
> 
> Add virtio_dmb_init(), which locates the region by the shared memory id
> the device reports and builds a page-granular allocator over it, and
> virtio_dmb_destroy() to tear that down. Add virtio_dmb_map_ops, a struct
> virtio_map_ops implementation that hands out allocations from that
> allocator as region offsets: alloc() places a virtqueue area in the
> region, map_page() copies a buffer that lives elsewhere into it and
> copies it back on unmap. The map operations reach that allocator through
> a new dmb member of union virtio_map.
> 
> The shared memory id is transport specific, so add a get_dmb_shm_id()
> callback to struct virtio_config_ops for a transport to report it. A
> transport that does not implement it must not accept VIRTIO_F_DMB. Add
> CONFIG_VIRTIO_DMB to enable this support. It defaults to y, and a kernel
> that will never meet such a device can turn it off to leave the
> allocator and its bookkeeping out.
> 
> Link: https://lore.kernel.org/virtio-comment/20260804161202.38619-1-graf@amazon.com/
> Assisted-by: Kiro:claude-opus-5 checkpatch sparse
> Signed-off-by: Alexander Graf <graf@amazon.com>




> ---
>  drivers/virtio/Kconfig        |   15 +
>  drivers/virtio/Makefile       |    3 +-
>  drivers/virtio/virtio_dmb.c   | 1317 +++++++++++++++++++++++++++++++++
>  drivers/virtio/virtio_dmb.h   |   28 +
>  include/linux/virtio.h        |    3 +
>  include/linux/virtio_config.h |    8 +


Really >1000 lines to implement a virtio specific allocator?

Can't we start e.g. with gen alloc and maybe xarray if you
need some metadata?


I guess virtio sync is annoying, it gets handle + offset is that the
issue? We can fix them though. Or let's just not support them. There
were there for premapped originally but now it uses page pool.

Maybe I will send a patch to drop sync completely.






>  6 files changed, 1373 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/virtio/virtio_dmb.c
>  create mode 100644 drivers/virtio/virtio_dmb.h
> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index ce5bc0d9ea28..b6b5a36c3c21 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -188,6 +188,21 @@ config VIRTIO_DEBUG
>  
>  	  If unsure, say N.
>  
> +config VIRTIO_DMB
> +	bool "Device Memory Buffer support"
> +	depends on VIRTIO
> +	default y
> +	help
> +	  Support devices that place their virtqueues and buffers in a shared
> +	  memory region they own, rather than in memory the driver allocates.
> +
> +	  Enabling this adds a page allocator and per-page bookkeeping, both
> +	  of which are set up only for a device that negotiates the feature.
> +	  When disabled the feature is never accepted and such a device is
> +	  driven as an ordinary one.
> +
> +	  If unsure, say Y.
> +
>  config VIRTIO_RTC
>  	tristate "Virtio RTC driver"
>  	depends on VIRTIO
> diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
> index eefcfe90d6b8..ba785ff44a16 100644
> --- a/drivers/virtio/Makefile
> +++ b/drivers/virtio/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
> +virtio-dmb-$(CONFIG_VIRTIO_DMB) := virtio_dmb.o
> +obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o $(virtio-dmb-y)
>  obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
>  obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
> diff --git a/drivers/virtio/virtio_dmb.c b/drivers/virtio/virtio_dmb.c
> new file mode 100644
> index 000000000000..42126f928bc0
> --- /dev/null
> +++ b/drivers/virtio/virtio_dmb.c
> @@ -0,0 +1,1317 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Device Memory Buffer support for virtio devices.
> + *
> + * A device that negotiates VIRTIO_F_DMB owns one shared memory region, the
> + * Device Memory Buffer, that holds its virtqueues and the buffers they
> + * reference.  Every address the driver publishes to such a device is a byte
> + * offset from the start of that region.
> + *
> + * This file provides an allocator over the region and the virtio_map_ops
> + * implementation that turns allocations into those offsets.  A mapping handle
> + * belonging to a DMB device is a region offset and nothing else: no code
> + * outside these operations may treat it as a DMA address.
> + *
> + * The region is shared with the device, which may read or write any of it at
> + * any time.  Nothing this file reads back from the region is used to compute
> + * a kernel address, a length or an index.  Handles and their sizes arrive
> + * from the ring's own bookkeeping in kernel memory, and are range-checked
> + * anyway so that a bug there cannot reach outside the arrays below.
> + */
> +
> +#include <linux/align.h>
> +#include <linux/bitmap.h>
> +#include <linux/bits.h>
> +#include <linux/cache.h>
> +#include <linux/cpumask.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/export.h>
> +#include <linux/highmem.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/limits.h>
> +#include <linux/log2.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +#include <linux/spinlock.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +
> +#include "virtio_dmb.h"
> +
> +/* No source recorded for this slot: it holds no bounced mapping. */
> +#define DMB_SRC_NONE		((phys_addr_t)-1)
> +
> +/**
> + * struct virtio_dmb_slot - what one PAGE_SIZE slot of the pool records
> + * @src: physical address this slot bounces, DMB_SRC_NONE for a virtqueue area
> + * @end: one past the last slot of the allocation this slot belongs to, or
> + *	zero when the slot is free
> + * @tail: how many bytes of slot @end - 1 the allocation covers, PAGE_SIZE when
> + *	its length is a whole number of pages, zero when the slot is free
> + *
> + * Every slot of an allocation records the same @end and the same @tail, so a
> + * handle that points into the middle of one still yields both the allocation's
> + * extent in slots and its end in bytes from a single read.
> + *
> + * @tail is what makes the length a mapping is bounced against a byte count
> + * rather than a page count.  It is bounded by PAGE_SIZE, so u32 holds it on
> + * every configuration, which a whole length would not: virtio_dmb_op_alloc()
> + * bounds a request by the entire pool and a pool may exceed 4 GiB.
> + */
> +struct virtio_dmb_slot {
> +	phys_addr_t	src;
> +	u32		end;
> +	u32		tail;
> +};
> +
> +/*
> + * Bounds on how many slots one area covers.
> + *
> + * The floor is one cacheline of bitmap, so that no two areas contend on the
> + * line their separate locks exist to keep apart, and at least 512 slots.  On a
> + * 64-byte line those coincide; a wider line raises the floor, which is
> + * correct.  Either way the floor is a power of two of at least BITS_PER_LONG,
> + * which is what makes an area own whole bitmap words and what makes the area
> + * of a slot a shift; virtio_dmb_init() asserts both rather than leaving them
> + * to inspection.
> + *
> + * The ceiling has no counterpart in kernel/dma/swiotlb.c, which this geometry
> + * otherwise follows, and it is needed because the search differs: swiotlb
> + * finds a run through a per-slot free-run list, while this sweeps a bitmap,
> + * so the cost of one search here is linear in the size of an area.  Without a
> + * ceiling that cost grows with the region, which is the thing being bounded.
> + */
> +#define DMB_AREA_CACHELINE_SLOTS	((unsigned int)L1_CACHE_BYTES * BITS_PER_BYTE)
> +#define DMB_AREA_MIN_SLOTS		(DMB_AREA_CACHELINE_SLOTS > 512u ? \
> +					 DMB_AREA_CACHELINE_SLOTS : 512u)
> +#define DMB_AREA_MAX_SLOTS		4096u
> +
> +/**
> + * struct virtio_dmb_area - one independently locked range of the pool
> + * @used: slots of this area that are allocated; exact under @lock
> + * @index: slot this area's next search starts from, relative to the area base
> + * @lock: covers this area's bits of the pool bitmap, @used and @index
> + *
> + * Cacheline-aligned where that means anything, so that two areas' locks do not
> + * share a line; the alignment compiles away on !SMP, where nothing contends.
> + */
> +struct virtio_dmb_area {
> +	unsigned int	used;
> +	unsigned int	index;
> +	/* Serialises this area's bits of the pool bitmap, @used and @index. */
> +	spinlock_t	lock;
> +} ____cacheline_aligned_in_smp;
> +
> +/**
> + * struct virtio_dmb - driver-side state for one Device Memory Buffer
> + * @vdev: the device that owns the region, for message context
> + * @map_va: what memremap() returned, for memunmap()
> + * @map_phys: physical base of the region, for release_mem_region()
> + * @map_len: length of the claimed and mapped part of the region
> + * @map_claimed: whether request_mem_region() succeeded for that range
> + * @prev_map: map operations the transport had installed, restored on teardown
> + * @prev_vmap: mapping token that went with @prev_map
> + * @base_va: kernel address the pool starts at, inside the mapping
> + * @base_off: pool start as an offset from the start of the region
> + * @nslots: pool size in PAGE_SIZE slots
> + * @bitmap: @nslots bits, set when the slot is allocated
> + * @slots: @nslots slot records
> + * @areas: the @nareas ranges the pool is divided into
> + * @nareas: how many areas the pool is divided into
> + * @area_slots: slots one area covers, a power of two; the last area covers
> + *	fewer when @nslots is not a multiple of it
> + * @area_shift: ilog2(@area_slots), so slot >> @area_shift names its area
> + * @shm_id: shared memory id the device reported for the region
> + */
> +struct virtio_dmb {
> +	struct virtio_device	*vdev;
> +	void			*map_va;
> +	phys_addr_t		 map_phys;
> +	size_t			 map_len;
> +	bool			 map_claimed;
> +	const struct virtio_map_ops *prev_map;
> +	union virtio_map	 prev_vmap;
> +	void			*base_va;
> +	u64			 base_off;
> +	unsigned int		 nslots;
> +	unsigned long		*bitmap;
> +	struct virtio_dmb_slot	*slots;
> +	struct virtio_dmb_area	*areas;
> +	unsigned int		 nareas;
> +	unsigned int		 area_slots;
> +	unsigned int		 area_shift;
> +	u16			 shm_id;
> +};
> +
> +/* First slot of area @i. */
> +static unsigned int virtio_dmb_area_base(const struct virtio_dmb *dmb,
> +					 unsigned int i)
> +{
> +	return i << dmb->area_shift;
> +}
> +
> +/* Slots area @i covers.  The last area is short unless nslots divides. */
> +static unsigned int virtio_dmb_area_len(const struct virtio_dmb *dmb,
> +					unsigned int i)
> +{
> +	return min(dmb->area_slots,
> +		   dmb->nslots - virtio_dmb_area_base(dmb, i));
> +}
> +
> +static unsigned int virtio_dmb_slots(size_t size)
> +{
> +	return DIV_ROUND_UP(size, PAGE_SIZE);
> +}
> +
> +static size_t virtio_dmb_pool_size(const struct virtio_dmb *dmb)
> +{
> +	return (size_t)dmb->nslots << PAGE_SHIFT;
> +}
> +
> +/*
> + * The largest buffer mapping this pool will serve: the smaller of an eighth of
> + * the pool and half of one area, but never less than one page.  That floor is
> + * what governs a region at the four-slot minimum, since an eighth of four
> + * pages rounds down to nothing.
> + *
> + * The eighth is a choice, not a derived value: it bounds the capacity one
> + * mapping can deny the rest of the device to seven eighths of the pool, so
> + * that a device with several virtqueues can still make forward progress while
> + * one large mapping is outstanding.
> + *
> + * The half-area is derived, and it is the reason this function has to be
> + * consulted rather than the eighth alone.  An allocation has to lie inside one
> + * area, because that is what lets one lock cover it and what lets the release
> + * path find that lock from the slot index.  Half rather than all of an area is
> + * headroom: a request the size of a whole area could only ever be satisfied by
> + * a completely empty one, and an area may be as small as
> + * DMB_AREA_MIN_SLOTS, so there is no expectation that one is empty.  The
> + * figure is half of the nominal area size, so a request at the cap can exceed
> + * the short last area outright; that costs a claim in one area out of nareas
> + * and the walk tries the others.
> + *
> + * The cap applies to map_page() only.  An alloc() is a virtqueue area, which
> + * is structural rather than in-flight: it lives for as long as the queue
> + * does and no back-pressure can defer it, so a cap on it could only shrink a
> + * queue on a region that is too small, or refuse one outright where the ring
> + * layout cannot be shrunk.  Sizing the region for the areas as well as the
> + * buffers is the device's obligation.
> + */
> +static size_t virtio_dmb_max_mapping(const struct virtio_dmb *dmb)
> +{
> +	size_t eighth = ALIGN_DOWN(virtio_dmb_pool_size(dmb) / 8, PAGE_SIZE);
> +	size_t half_area = ((size_t)dmb->area_slots / 2) << PAGE_SHIFT;
> +
> +	return max_t(size_t, min(eighth, half_area), PAGE_SIZE);
> +}
> +
> +/*
> + * Claim @nr contiguous slots from area @i, or -ENOMEM when that one area
> + * cannot satisfy the request.  Takes and drops that area's lock and touches
> + * no other area's state, so no path ever holds two of these locks and there
> + * is no ordering between them to get right.
> + */
> +static long virtio_dmb_area_claim(struct virtio_dmb *dmb, unsigned int i,
> +				  unsigned int nr)
> +{
> +	struct virtio_dmb_area *area = &dmb->areas[i];
> +	unsigned int base = virtio_dmb_area_base(dmb, i);
> +	unsigned int end = base + virtio_dmb_area_len(dmb, i);
> +	unsigned long flags, slot;
> +
> +	spin_lock_irqsave(&area->lock, flags);
> +
> +	/*
> +	 * Exact, and inside the lock.  Written as a subtraction from the
> +	 * area's own length rather than as len - used < nr, which underflows.
> +	 */
> +	if (nr > (end - base) - area->used)
> +		goto not_found;
> +
> +	/*
> +	 * Both sweeps are bounded at the area end, so an allocation cannot
> +	 * span two areas and the release path can find one lock from the slot
> +	 * index.  bitmap_find_next_zero_area() returns a value whose sum with
> +	 * @nr exceeds the size it was given when it finds nothing, so that sum
> +	 * is the test; the whole-pool "slot >= nslots" form does not transfer.
> +	 */
> +	slot = bitmap_find_next_zero_area(dmb->bitmap, end,
> +					  base + area->index, nr, 0);
> +	if (slot + nr > end && area->index)
> +		slot = bitmap_find_next_zero_area(dmb->bitmap, end, base,
> +						  nr, 0);
> +	if (slot + nr > end)
> +		goto not_found;
> +
> +	bitmap_set(dmb->bitmap, slot, nr);
> +	area->used += nr;
> +	area->index = slot + nr < end ? slot + nr - base : 0;
> +
> +	spin_unlock_irqrestore(&area->lock, flags);
> +
> +	return slot;
> +
> +not_found:
> +	spin_unlock_irqrestore(&area->lock, flags);
> +
> +	return -ENOMEM;
> +}
> +
> +/*
> + * Claim @nr contiguous slots.  Returns the first slot, or -ENOMEM when no
> + * area can satisfy the request.  Exhaustion is a routine condition: the
> + * region's length bounds how much virtqueue data can be in flight.  What a
> + * caller makes of it is the caller's, and it is not always back-pressure: a
> + * network receive fill has nothing to push back on when it cannot post a
> + * buffer, and repolls instead.  Reporting it at any level a working device
> + * would print would therefore be a log flood, and it is the only signal an
> + * undersized region produces at all, so it is reported through dynamic debug
> + * where it costs nothing until somebody asks for it.
> + *
> + * Next fit within one area, from a hint that advances past each claim and
> + * rewinds to each release, beginning in the area belonging to the running CPU
> + * and then trying each other area in turn.  So a multi-slot request can fail
> + * while the total free count would have satisfied it: a map_page() request is
> + * bounded by virtio_dmb_max_mapping(), which keeps it inside one area, but
> + * fragmentation within that area can still cost capacity and fail an
> + * individual mapping.  Nothing is moved to recover: handles are live in
> + * descriptors the device is reading.
> + *
> + * The walk visits every area and tests capacity inside that area's lock, so a
> + * refusal is a true statement about the pool rather than about one area.  It
> + * releases the lock and restores interrupts between areas, which is what
> + * bounds the interrupts-off window to a single area's sweep; the total work in
> + * the failing case is a whole-pool sweep either way.
> + */
> +static long virtio_dmb_claim(struct virtio_dmb *dmb, unsigned int nr)
> +{
> +	unsigned int i, start;
> +	long ret;
> +
> +	/*
> +	 * raw_smp_processor_id() and not smp_processor_id(): the index is
> +	 * computed before any lock is taken, so preemption or migration
> +	 * between the read and the claim only changes which area is tried
> +	 * first.  kernel/dma/swiotlb.c picks its home area on the same
> +	 * reasoning.
> +	 */
> +	start = raw_smp_processor_id() % dmb->nareas;
> +	i = start;
> +	do {
> +		ret = virtio_dmb_area_claim(dmb, i, nr);
> +		if (ret >= 0)
> +			return ret;
> +
> +		if (++i >= dmb->nareas)
> +			i = 0;
> +	} while (i != start);
> +
> +	/*
> +	 * The geometry rather than a free count: there is no instant at which
> +	 * a total free count is true under per-area locking, so printing one
> +	 * would mean either a walk taking every lock or a torn read.
> +	 */
> +	dev_dbg_ratelimited(&dmb->vdev->dev,
> +			    "device memory buffer has no run of %u pages in any of %u areas of %u pages\n",
> +			    nr, dmb->nareas, dmb->area_slots);
> +
> +	return -ENOMEM;
> +}
> +
> +static void virtio_dmb_release(struct virtio_dmb *dmb, unsigned int slot,
> +			       unsigned int nr)
> +{
> +	struct virtio_dmb_area *area;
> +	unsigned long flags;
> +	unsigned int i, a;
> +
> +	if (dev_WARN_ONCE(&dmb->vdev->dev,
> +			  !nr || slot >= dmb->nslots || nr > dmb->nslots - slot,
> +			  "bad device memory buffer slot range %u+%u\n",
> +			  slot, nr))
> +		return;
> +
> +	/*
> +	 * One area holds the whole allocation, so one lock covers it.  The
> +	 * allocator establishes that by bounding both of its sweeps at an area
> +	 * end; enforce it here rather than inherit it, because this is the path
> +	 * that depends on it to pick a lock at all, and picking the wrong one
> +	 * would clear bits and adjust a count under a lock that does not cover
> +	 * either.
> +	 */
> +	a = slot >> dmb->area_shift;
> +	if (dev_WARN_ONCE(&dmb->vdev->dev,
> +			  ((slot + nr - 1) >> dmb->area_shift) != a,
> +			  "device memory buffer allocation %u+%u spans two areas\n",
> +			  slot, nr))
> +		return;
> +	area = &dmb->areas[a];
> +
> +	spin_lock_irqsave(&area->lock, flags);
> +
> +	/*
> +	 * Releasing a range that is not wholly allocated would put slots that
> +	 * a different allocation now owns back on the free list, which is what
> +	 * a second release of one handle does.  The bitmap is the only record
> +	 * that can answer whether that is happening, and the test costs less
> +	 * than the bitmap_clear() it guards.
> +	 */
> +	if (dev_WARN_ONCE(&dmb->vdev->dev,
> +			  find_next_zero_bit(dmb->bitmap, slot + nr, slot) <
> +				slot + nr,
> +			  "device memory buffer double release %u+%u\n",
> +			  slot, nr))
> +		goto out;
> +
> +	/*
> +	 * Clear the records before the bits, so that a slot reachable from the
> +	 * free list never carries an extent that virtio_dmb_resolve() would
> +	 * trust.  Doing it here rather than in the callers covers every
> +	 * release path with one copy of the invariant.
> +	 *
> +	 * WRITE_ONCE() because virtio_dmb_resolve() reads these three fields
> +	 * without the lock, which is the pattern
> +	 * tools/memory-model/Documentation/access-marking.txt calls
> +	 * "Lock-Protected Writes With Lockless Reads" and asks to be marked on
> +	 * both sides.
> +	 */
> +	for (i = slot; i < slot + nr; i++) {
> +		WRITE_ONCE(dmb->slots[i].src, DMB_SRC_NONE);
> +		WRITE_ONCE(dmb->slots[i].end, 0);
> +		WRITE_ONCE(dmb->slots[i].tail, 0);
> +	}
> +
> +	bitmap_clear(dmb->bitmap, slot, nr);
> +	area->used -= nr;
> +	area->index = slot - virtio_dmb_area_base(dmb, a);
> +
> +out:
> +	spin_unlock_irqrestore(&area->lock, flags);
> +}
> +
> +/**
> + * struct virtio_dmb_ref - a handle resolved against the pool
> + * @slot: the slot the handle lands in
> + * @nr: slots the allocation still holds from @slot on
> + * @src: the physical address @slot bounces, or DMB_SRC_NONE for a queue area
> + *
> + * @nr and @src are derived from the same read of the record that validated the
> + * handle, so the extent a caller releases and the pages the copy touches are
> + * the ones that were checked and not a later re-read of a field another CPU may
> + * meanwhile have cleared.
> + */
> +struct virtio_dmb_ref {
> +	unsigned int	slot;
> +	unsigned int	nr;
> +	phys_addr_t	src;
> +};
> +
> +/* Extra conditions virtio_dmb_resolve() enforces for particular callers. */
> +#define DMB_RESOLVE_BOUNCED	BIT(0)	/* must be a mapping, not a queue area */
> +#define DMB_RESOLVE_WHOLE	BIT(1)	/* must be the allocation's first slot */
> +
> +/*
> + * Turn a handle and a length into a slot index and an extent, rejecting
> + * anything that does not lie wholly inside the pool.  The bound is exclusive,
> + * so a handle at the end of the pool and a zero length are both refused.  The
> + * arithmetic is done in u64 so that it cannot wrap where dma_addr_t is
> + * narrower.
> + *
> + * A handle may point into the middle of a mapping, because
> + * virtqueue_map_sync_single_range_for_cpu() and its counterpart pass
> + * handle + offset, so the extent is taken from the slot the handle lands in
> + * rather than from the first slot of the allocation.  That rejects a handle
> + * released twice, a length that runs past the end of its allocation, and a
> + * range that would continue into a neighbouring one.
> + *
> + * The length is checked in bytes, not in pages.  A page-granular check would
> + * pass a length ending anywhere inside the allocation's last slot, which is up
> + * to PAGE_SIZE - 1 bytes past what was mapped, and virtio_dmb_copy() would
> + * then touch the page after the source run.  swiotlb_bounce() keeps the same
> + * bound in alloc_size (kernel/dma/swiotlb.c:890) and clamps an over-long
> + * mapping to it, because it has callers it cannot refuse.  Every caller here
> + * passes a length the map side recorded, so an over-long one is a caller bug
> + * and the copy is refused outright rather than truncated.
> + *
> + * DMB_RESOLVE_BOUNCED additionally requires the allocation to be one this file
> + * bounced rather than a virtqueue area.  DMB_RESOLVE_WHOLE requires the handle
> + * to be the start of its allocation, which is what the callers that release it
> + * need: mid-extent tolerance exists for the sync ops alone, and a mid-extent
> + * release would free the tail of an allocation and leak its head for good.
> + *
> + * The resolved slot is read without the lock, which is legitimate for a caller
> + * that owns it: virtio_dmb_claim() published it exclusively to this caller, so
> + * nothing else writes it.  The DMB_RESOLVE_WHOLE test also reads the preceding
> + * slot, which the caller does not own, and that read rests on a different
> + * argument, stated where it is made.
> + */
> +static bool virtio_dmb_resolve(struct virtio_dmb *dmb, dma_addr_t handle,
> +			       size_t size, unsigned int rflags,
> +			       struct virtio_dmb_ref *ref)
> +{
> +	u64 off, end, limit;
> +	phys_addr_t src;
> +	u32 slot_end, tail;
> +
> +	if (!size || (u64)handle < dmb->base_off)
> +		goto bad_handle;
> +
> +	off = (u64)handle - dmb->base_off;
> +	if (check_add_overflow(off, (u64)size, &end))
> +		goto bad_handle;
> +	if (end > (u64)virtio_dmb_pool_size(dmb))
> +		goto bad_handle;
> +
> +	ref->slot = off >> PAGE_SHIFT;
> +
> +	/*
> +	 * Snapshot the record here, once.  Every test below, the extent the
> +	 * caller goes on to release and the pages virtio_dmb_copy() touches are
> +	 * taken from these three reads rather than from a second look at the
> +	 * entry, so what was validated is what gets used.  Reading the slot
> +	 * without the lock is legitimate for a caller that owns it, as above,
> +	 * but the callers these tests exist to catch are exactly the ones that
> +	 * do not own it, and for those another CPU may be writing the entry.
> +	 */
> +	slot_end = READ_ONCE(dmb->slots[ref->slot].end);
> +	tail = READ_ONCE(dmb->slots[ref->slot].tail);
> +	src = READ_ONCE(dmb->slots[ref->slot].src);
> +
> +	if (dev_WARN_ONCE(&dmb->vdev->dev, !slot_end,
> +			  "device memory buffer handle %pad holds no allocation\n",
> +			  &handle))
> +		return false;
> +
> +	/* The allocation's exclusive end in bytes, reachable from any slot. */
> +	limit = ((u64)(slot_end - 1) << PAGE_SHIFT) + tail;
> +
> +	if (dev_WARN_ONCE(&dmb->vdev->dev, end > limit,
> +			  "device memory buffer handle %pad length %zu leaves its allocation\n",
> +			  &handle, size))
> +		return false;
> +
> +	/*
> +	 * Allocations are disjoint and every slot of one records the same end,
> +	 * so the preceding slot shares that end if and only if this slot is not
> +	 * the first of the allocation.
> +	 *
> +	 * That slot may belong to another caller, which is the read the
> +	 * ownership argument above does not cover.  Disjointness covers it
> +	 * instead: a neighbouring allocation ends at or before this slot and a
> +	 * free slot records zero, so whichever of the two a concurrent
> +	 * virtio_dmb_record() or virtio_dmb_release() leaves visible, neither
> +	 * can equal slot_end.
> +	 */
> +	if ((rflags & DMB_RESOLVE_WHOLE) &&
> +	    dev_WARN_ONCE(&dmb->vdev->dev,
> +			  !IS_ALIGNED(off, PAGE_SIZE) ||
> +			  (ref->slot &&
> +			   READ_ONCE(dmb->slots[ref->slot - 1].end) == slot_end),
> +			  "device memory buffer handle %pad is not the start of its allocation\n",
> +			  &handle))
> +		return false;
> +
> +	if ((rflags & DMB_RESOLVE_BOUNCED) &&
> +	    dev_WARN_ONCE(&dmb->vdev->dev, src == DMB_SRC_NONE,
> +			  "device memory buffer handle %pad holds no mapping\n",
> +			  &handle))
> +		return false;
> +
> +	ref->nr = slot_end - ref->slot;
> +	ref->src = src;
> +	return true;
> +
> +bad_handle:
> +	dev_WARN_ONCE(&dmb->vdev->dev, 1,
> +		      "device memory buffer handle %pad length %zu out of range\n",
> +		      &handle, size);
> +	return false;
> +}
> +
> +/*
> + * Copy between the region and the pages a mapping bounces.  @ref is what
> + * virtio_dmb_resolve() validated for this handle, or what the map side has just
> + * recorded; every source address is derived from its snapshot rather than from
> + * dmb->slots[], which this function does not read at all, so validation and use
> + * cannot disagree about where the source is.  Walk the source one page at a
> + * time through kmap_local_page(): the source may be highmem, and the per-slot
> + * record is a physical address precisely so that no assumption about a linear
> + * kernel mapping across the mapping's pages is needed.  The region side needs
> + * no such split, being one contiguous mapping.
> + */
> +static void virtio_dmb_copy(struct virtio_dmb *dmb,
> +			    const struct virtio_dmb_ref *ref,
> +			    dma_addr_t handle, size_t size, bool to_region)
> +{
> +	size_t off = (size_t)((u64)handle - dmb->base_off);
> +	phys_addr_t base = ref->src - ((phys_addr_t)ref->slot << PAGE_SHIFT);
> +	size_t done = 0;
> +
> +	while (done < size) {
> +		size_t pos = off + done;
> +		phys_addr_t src = base + pos;
> +		unsigned int in_src = offset_in_page(src);
> +		void *region = dmb->base_va + pos;
> +		size_t n;
> +		void *va;
> +
> +		n = min(size - done, (size_t)PAGE_SIZE - in_src);
> +
> +		va = kmap_local_page(pfn_to_page(PHYS_PFN(src)));
> +		if (to_region)
> +			memcpy(region, va + in_src, n);
> +		else
> +			memcpy(va + in_src, region, n);
> +		kunmap_local(va);
> +
> +		done += n;
> +	}
> +}
> +
> +/*
> + * Record @nr slots from @slot as one allocation of @size bytes bouncing @src.
> + *
> + * Each slot carries the source address of its own page rather than only the
> + * first slot carrying the address of the mapping.  That is what makes
> + * virtio_dmb_copy() independent of which slot of the allocation a handle
> + * resolved to: taking the slot index back off the recorded address yields the
> + * same base from any slot of the mapping.  The sync ops do resolve to a slot
> + * in the middle of one, being handed handle + offset.
> + *
> + * The tail is recorded on every slot for the same reason, so that the byte end
> + * of the allocation is derivable from a mid-extent handle without also knowing
> + * which slot the allocation starts at.
> + */
> +static void virtio_dmb_record(struct virtio_dmb *dmb, unsigned int slot,
> +			      unsigned int nr, size_t size, phys_addr_t src)
> +{
> +	unsigned int i;
> +	u32 tail;
> +
> +	/*
> +	 * @nr is virtio_dmb_slots(size) at both call sites, so the last slot
> +	 * carries between 1 and PAGE_SIZE bytes and the cast cannot truncate.
> +	 */
> +	tail = (u32)(size - ((size_t)(nr - 1) << PAGE_SHIFT));
> +
> +	for (i = 0; i < nr; i++) {
> +		WRITE_ONCE(dmb->slots[slot + i].src,
> +			   src == DMB_SRC_NONE ?
> +			   DMB_SRC_NONE : src + ((phys_addr_t)i << PAGE_SHIFT));
> +		WRITE_ONCE(dmb->slots[slot + i].end, slot + nr);
> +		WRITE_ONCE(dmb->slots[slot + i].tail, tail);
> +	}
> +}
> +
> +static void *virtio_dmb_op_alloc(union virtio_map map, size_t size,
> +				 dma_addr_t *map_handle, gfp_t gfp)
> +{
> +	struct virtio_dmb *dmb = map.dmb;
> +	unsigned int nr, slot;
> +	void *va;
> +	long ret;
> +
> +	/*
> +	 * The allocation-behaviour bits of gfp are ignored, because claiming
> +	 * slots neither sleeps nor allocates; __GFP_NOWARN is honoured, for
> +	 * the reason the failure path below gives.  The result is zeroed
> +	 * because this stands in for dma_alloc_coherent(), whose callers rely
> +	 * on that.
> +	 */
> +	if (!size)
> +		return NULL;
> +
> +	/*
> +	 * Bound the request before a slot count is derived from it, as
> +	 * map_page() does.  The bound is the whole pool rather than the
> +	 * fraction of it virtio_dmb_max_mapping() reports, for the reason
> +	 * that function gives.  It is not the effective limit: every search
> +	 * is bounded at one pool area, so an allocation larger than
> +	 * area_slots pages fails even on an empty pool.
> +	 */
> +	if (size > virtio_dmb_pool_size(dmb))
> +		goto no_room;
> +
> +	nr = virtio_dmb_slots(size);
> +	ret = virtio_dmb_claim(dmb, nr);
> +	if (ret < 0)
> +		goto no_room;
> +	slot = ret;
> +
> +	va = dmb->base_va + ((size_t)slot << PAGE_SHIFT);
> +	memset(va, 0, (size_t)nr << PAGE_SHIFT);
> +	virtio_dmb_record(dmb, slot, nr, size, DMB_SRC_NONE);
> +
> +	*map_handle = dmb->base_off + ((u64)slot << PAGE_SHIFT);
> +	return va;
> +
> +no_room:
> +	/*
> +	 * A buffer that does not fit is back-pressure and stays quiet, but
> +	 * this is a virtqueue area: no back-pressure can defer it, and a
> +	 * region sized for the buffers but not for the areas otherwise fails
> +	 * queue setup with nothing to tell it apart from every other reason
> +	 * find_vqs() can fail, and it is the one of those a larger region
> +	 * fixes.
> +	 *
> +	 * Which is why __GFP_NOWARN has to be honoured rather than ignored.
> +	 * vring_alloc_queue_split() walks the queue size down from the size
> +	 * the device asked for and marks every attempt but the last with the
> +	 * flag, so warning regardless would print a line for every attempt
> +	 * but the last, for a probe that then succeeds.  Dynamic debug still carries the
> +	 * message, which is what a packed ring has to rely on: none of its
> +	 * three areas can be made smaller and all three set the flag.
> +	 */
> +	if (gfp & __GFP_NOWARN)
> +		dev_dbg(&dmb->vdev->dev,
> +			"no room for a %zu-byte virtqueue area in %u pages\n",
> +			size, dmb->nslots);
> +	else
> +		dev_warn(&dmb->vdev->dev,
> +			 "no room for a %zu-byte virtqueue area in %u pages\n",
> +			 size, dmb->nslots);
> +	return NULL;
> +}
> +
> +/*
> + * DMB_RESOLVE_WHOLE alone: there is deliberately no converse of
> + * DMB_RESOLVE_BOUNCED insisting that the allocation is a virtqueue area.  A
> + * caller reaching this with a mapping has called free() on something it got
> + * from map_page(), and would lose the copy-out that unmap_page() does; the
> + * bytes it loses are its own, and the only in-tree caller of the exported
> + * virtqueue_map_free_coherent() is vring_free_queue(), which frees an area.
> + * Refusing here would trade that for a leak of the slots, which is worse.
> + */
> +static void virtio_dmb_op_free(union virtio_map map, size_t size, void *vaddr,
> +			       dma_addr_t map_handle, unsigned long attrs)
> +{
> +	struct virtio_dmb *dmb = map.dmb;
> +	struct virtio_dmb_ref ref;
> +
> +	if (!virtio_dmb_resolve(dmb, map_handle, size, DMB_RESOLVE_WHOLE, &ref))
> +		return;
> +
> +	virtio_dmb_release(dmb, ref.slot, ref.nr);
> +}
> +
> +static dma_addr_t virtio_dmb_op_map_page(union virtio_map map,
> +					 struct page *page,
> +					 unsigned long offset, size_t size,
> +					 enum dma_data_direction dir,
> +					 unsigned long attrs)
> +{
> +	struct virtio_dmb *dmb = map.dmb;
> +	phys_addr_t src = page_to_phys(page) + offset;
> +	struct virtio_dmb_ref ref;
> +	unsigned int nr, slot;
> +	dma_addr_t handle;
> +	long ret;
> +
> +	if (!size || size > virtio_dmb_max_mapping(dmb))
> +		return DMA_MAPPING_ERROR;
> +
> +	nr = virtio_dmb_slots(size);
> +	ret = virtio_dmb_claim(dmb, nr);
> +	if (ret < 0)
> +		return DMA_MAPPING_ERROR;
> +	slot = ret;
> +
> +	virtio_dmb_record(dmb, slot, nr, size, src);
> +
> +	handle = dmb->base_off + ((u64)slot << PAGE_SHIFT);
> +
> +	ref.slot = slot;
> +	ref.nr = nr;
> +	ref.src = src;
> +
> +	/*
> +	 * Copy the caller's buffer in whatever the direction is, and without
> +	 * honouring DMA_ATTR_SKIP_CPU_SYNC.  swiotlb_tbl_map_single() bounces
> +	 * unconditionally for the same two reasons: a device that writes less
> +	 * than the whole buffer must leave the rest of the caller's bytes
> +	 * intact, and the mapped bytes must not reach the device as whatever
> +	 * the slot held before.
> +	 *
> +	 * Those bytes and no others.  size need not be a multiple of
> +	 * PAGE_SIZE, and [size, nr << PAGE_SHIFT) keeps what the slots held
> +	 * before: a freed virtqueue area, an earlier mapping of this device,
> +	 * or what the device left there itself.  Nothing outside a mapping's
> +	 * own length is ever copied in, so the device reads nothing there
> +	 * that the region did not already hold for it, and the descriptor
> +	 * carries a length.  swiotlb leaves the remainder of its last slot
> +	 * the same way.
> +	 */
> +	virtio_dmb_copy(dmb, &ref, handle, size, true);
> +
> +	return handle;
> +}
> +
> +static void virtio_dmb_op_unmap_page(union virtio_map map,
> +				     dma_addr_t map_handle, size_t size,
> +				     enum dma_data_direction dir,
> +				     unsigned long attrs)
> +{
> +	struct virtio_dmb *dmb = map.dmb;
> +	struct virtio_dmb_ref ref;
> +
> +	if (!virtio_dmb_resolve(dmb, map_handle, size,
> +				DMB_RESOLVE_BOUNCED | DMB_RESOLVE_WHOLE, &ref))
> +		return;
> +
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +	    (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
> +		virtio_dmb_copy(dmb, &ref, map_handle, size, false);
> +
> +	/*
> +	 * The slot count comes from what map_page() recorded rather than from
> +	 * the caller's size, so a mismatched size cannot release a different
> +	 * number of slots than were claimed.
> +	 */
> +	virtio_dmb_release(dmb, ref.slot, ref.nr);
> +}
> +
> +static void virtio_dmb_op_sync_single_for_cpu(union virtio_map map,
> +					      dma_addr_t map_handle,
> +					      size_t size,
> +					      enum dma_data_direction dir)
> +{
> +	struct virtio_dmb *dmb = map.dmb;
> +	struct virtio_dmb_ref ref;
> +
> +	/* A zero-length sync is a no-op and not a bad handle. */
> +	if (!size)
> +		return;
> +
> +	if (!virtio_dmb_resolve(dmb, map_handle, size, DMB_RESOLVE_BOUNCED,
> +				&ref))
> +		return;
> +
> +	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
> +		virtio_dmb_copy(dmb, &ref, map_handle, size, false);
> +}
> +
> +static void virtio_dmb_op_sync_single_for_device(union virtio_map map,
> +						 dma_addr_t map_handle,
> +						 size_t size,
> +						 enum dma_data_direction dir)
> +{
> +	struct virtio_dmb *dmb = map.dmb;
> +	struct virtio_dmb_ref ref;
> +
> +	/* A zero-length sync is a no-op and not a bad handle. */
> +	if (!size)
> +		return;
> +
> +	if (!virtio_dmb_resolve(dmb, map_handle, size, DMB_RESOLVE_BOUNCED,
> +				&ref))
> +		return;
> +
> +	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
> +		virtio_dmb_copy(dmb, &ref, map_handle, size, true);
> +}
> +
> +static bool virtio_dmb_op_need_sync(union virtio_map map, dma_addr_t map_handle)
> +{
> +	/* Every mapping is a bounce, so every sync is a real copy. */
> +	return true;
> +}
> +
> +static int virtio_dmb_op_mapping_error(union virtio_map map,
> +				       dma_addr_t map_handle)
> +{
> +	/*
> +	 * DMA_MAPPING_ERROR is the value virtio_ring reserves.  Offset 0 is
> +	 * reserved too, by the proposal and by every device implementation
> +	 * that reads a queue address of zero as a queue that was never
> +	 * programmed, so it is not an address this driver may publish either.
> +	 * Nothing allocated here yields it, because the pool starts after the
> +	 * first byte of the region for the reason virtio_dmb_init() gives, but
> +	 * a premapped buffer carries an address its caller obtained and
> +	 * vring_map_one_sg() asks this operation to judge that one.  Whether
> +	 * such an address came from this map cannot be answered here, and a
> +	 * containment test would answer a different question, but zero can be
> +	 * answered: it is the one value the proposal rules out outright.
> +	 */
> +	if (map_handle == DMA_MAPPING_ERROR || !map_handle)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static size_t virtio_dmb_op_max_mapping_size(union virtio_map map)
> +{
> +	return virtio_dmb_max_mapping(map.dmb);
> +}
> +
> +static const struct virtio_map_ops virtio_dmb_map_ops = {
> +	.map_page		= virtio_dmb_op_map_page,
> +	.unmap_page		= virtio_dmb_op_unmap_page,
> +	.sync_single_for_cpu	= virtio_dmb_op_sync_single_for_cpu,
> +	.sync_single_for_device	= virtio_dmb_op_sync_single_for_device,
> +	.alloc			= virtio_dmb_op_alloc,
> +	.free			= virtio_dmb_op_free,
> +	.need_sync		= virtio_dmb_op_need_sync,
> +	.mapping_error		= virtio_dmb_op_mapping_error,
> +	.max_mapping_size	= virtio_dmb_op_max_mapping_size,
> +};
> +
> +/*
> + * Whether the device still has virtqueues.  vqs_list_lock is what protects
> + * that list against a concurrent adder.  No caller here can race one, because
> + * every path that reaches this runs under the device lock and before or after
> + * the driver's find_vqs(), but the invariant is worth enforcing rather than
> + * inheriting from callers this file does not control.
> + */
> +static bool virtio_dmb_vqs_live(struct virtio_device *vdev)
> +{
> +	bool live;
> +
> +	spin_lock(&vdev->vqs_list_lock);
> +	live = !list_empty(&vdev->vqs);
> +	spin_unlock(&vdev->vqs_list_lock);
> +
> +	return live;
> +}
> +
> +/**
> + * virtio_dmb_destroy - release the Device Memory Buffer state of a device
> + * @vdev: the device
> + *
> + * Does nothing unless @vdev is currently using a Device Memory Buffer, and
> + * refuses if the device still has virtqueues: they would be left pointing
> + * into a region that is no longer mapped.  The mapping and the physical
> + * region claim then stay behind until something deletes those virtqueues and
> + * calls again, which unbinding the driver does: virtio_dev_remove() calls the
> + * driver's remove() before this.
> + */
> +void virtio_dmb_destroy(struct virtio_device *vdev)
> +{
> +	struct virtio_dmb *dmb;
> +
> +	/*
> +	 * vdev->map identifies which member of vdev->vmap is live, so it is
> +	 * also the test for whether the union holds a Device Memory Buffer.
> +	 */
> +	if (vdev->map != &virtio_dmb_map_ops)
> +		return;
> +
> +	/*
> +	 * A virtqueue keeps the mapping token it was created with, while
> +	 * vdev->map is consulted afresh on every dispatch.  Clearing vdev->map
> +	 * therefore does not disarm a live virtqueue, it redirects that
> +	 * virtqueue's copy of the token into the DMA API, where the pointer
> +	 * this frees would be used as a struct device.  Refuse instead and
> +	 * leak the mapping, which is unconditionally better than a
> +	 * use-after-free.
> +	 *
> +	 * Reported rather than warned about, because a driver that left its
> +	 * virtqueues in place is not the only way to get here.  A device that
> +	 * fails to report its region on the way back from a suspend takes
> +	 * virtio_device_restore() to its error path, which calls this, and a
> +	 * driver with no freeze callback still has its virtqueues at that
> +	 * point, correctly.  A condition a correct driver can satisfy must
> +	 * not taint the kernel.
> +	 */
> +	if (virtio_dmb_vqs_live(vdev)) {
> +		dev_warn(&vdev->dev,
> +			 "device memory buffer not released, virtqueues are still live\n");
> +		return;
> +	}
> +
> +	dmb = vdev->vmap.dmb;
> +
> +	/* Put back exactly what the transport had installed. */
> +	vdev->map = dmb->prev_map;
> +	vdev->vmap = dmb->prev_vmap;
> +
> +	memunmap(dmb->map_va);
> +	if (dmb->map_claimed)
> +		release_mem_region(dmb->map_phys, dmb->map_len);
> +	kvfree(dmb->slots);
> +	kfree(dmb->areas);
> +	bitmap_free(dmb->bitmap);
> +	kfree(dmb);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dmb_destroy);
> +
> +/**
> + * virtio_dmb_init - make a device's Device Memory Buffer state current
> + * @vdev: the device, with feature negotiation complete
> + *
> + * Reads the shared memory id the device reports, locates the region, builds
> + * an allocator over it and routes every mapping of the device through it.
> + * When the feature is not negotiated, releases any state a previous
> + * negotiation left behind.
> + *
> + * The operation is "make the state match what the device reports now", and it
> + * is reached again from resume and from reset completion.  A device that
> + * reports the region it reported last time keeps the state it already has, so
> + * handles held by a virtqueue that outlived the transition stay valid.  A
> + * device that reports a different region has the state rebuilt when no
> + * virtqueue is live, and is refused otherwise: a virtqueue holds kernel
> + * addresses inside the mapping and cannot be redirected into a new one.
> + *
> + * A caller that gets an error must set the FAILED device status bit, and must
> + * not touch the device for anything else before it does.  The device has
> + * already confirmed the feature by the time this runs, so it is entitled to
> + * assume the driver will address it through the region; the bit is what tells
> + * it the driver gave up instead.
> + *
> + * Return: 0 on success, or a negative errno.
> + */
> +int virtio_dmb_init(struct virtio_device *vdev)
> +{
> +	struct virtio_shm_region region;
> +	struct virtio_dmb *dmb;
> +	unsigned int nslots, skew;
> +	unsigned int area_slots, nareas, target, i;
> +	u64 base_off, slots = 0;
> +	size_t map_len;
> +	u16 shm_id;
> +	int err;
> +
> +	if (!virtio_has_feature(vdev, VIRTIO_F_DMB)) {
> +		/*
> +		 * The feature may have been withdrawn across re-negotiation.
> +		 *
> +		 * virtio_dmb_destroy() refuses under live virtqueues, and
> +		 * returning 0 after a refusal would leave this file's map
> +		 * operations installed for a device that has not negotiated the
> +		 * feature, so every later mapping would resolve a handle
> +		 * against a region the device no longer agrees it has.  Report
> +		 * the refusal to the caller instead, which sets the FAILED
> +		 * device status bit.  No path reaches this today: it needs map
> +		 * operations an earlier negotiation installed, which unbinding
> +		 * destroys, so only the restore path can find them, and that
> +		 * path hands finalize_features() the word already accepted
> +		 * rather than the offer, so a transport could drop the feature
> +		 * there only in reaction to a device that changed what it
> +		 * offers after the driver bound, and no reset does that.
> +		 */
> +		virtio_dmb_destroy(vdev);
> +		if (vdev->map == &virtio_dmb_map_ops)
> +			return -EBUSY;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Without both of these the region cannot be located at all, which is
> +	 * what keeps a transport that does not implement them from offering
> +	 * the feature in the first place.
> +	 */
> +	if (!vdev->config->get_dmb_shm_id || !vdev->config->get_shm_region) {
> +		dev_warn(&vdev->dev,
> +			 "transport cannot locate a device memory buffer\n");
> +		return -EINVAL;
> +	}
> +
> +	/* The feature is only defined together with VIRTIO_F_ACCESS_PLATFORM. */
> +	if (!virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM)) {
> +		dev_warn(&vdev->dev,
> +			 "device memory buffer without VIRTIO_F_ACCESS_PLATFORM\n");
> +		return -EINVAL;
> +	}
> +
> +	err = vdev->config->get_dmb_shm_id(vdev, &shm_id);
> +	if (err)
> +		return err;
> +
> +	/* A region is looked up by a u8 id. */
> +	if (shm_id > U8_MAX) {
> +		dev_warn(&vdev->dev,
> +			 "device memory buffer id %u out of range\n", shm_id);
> +		return -EINVAL;
> +	}
> +
> +	if (!virtio_get_shm_region(vdev, &region, shm_id)) {
> +		dev_warn(&vdev->dev,
> +			 "cannot locate device memory buffer region %u\n",
> +			 shm_id);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * The region base carries no alignment guarantee, but every virtqueue
> +	 * layout requires one of the areas placed in it.  Start the pool at a
> +	 * PAGE_SIZE-aligned address and record the skew, so that page-granular
> +	 * allocation makes every absolute address aligned.
> +	 *
> +	 * PAGE_SIZE - skew is the distance from the start of the region to the
> +	 * first aligned address strictly after it, so the pool never begins at
> +	 * the region's first byte and no handle is ever 0.  The proposal
> +	 * reserves offset 0: it is not the address of any structure the driver
> +	 * places in the region, and a device may treat it as an error.  A device
> +	 * that predates the reservation reads a queue address of 0 as the queue
> +	 * never having been programmed and ignores it, so the value is unusable
> +	 * either way.  Keeping it out of the pool costs one page of an
> +	 * already-aligned region and nothing at all of a misaligned one, whose
> +	 * leading partial page was unusable regardless.
> +	 */
> +	skew = offset_in_page(region.addr);
> +	base_off = PAGE_SIZE - skew;
> +
> +	if (region.len > base_off)
> +		slots = (region.len - base_off) >> PAGE_SHIFT;
> +
> +	/*
> +	 * The least a region could hold: one minimally-sized virtqueue plus
> +	 * one buffer in flight against it.  A packed queue costs three
> +	 * allocations, a descriptor ring and two event structures, and a split
> +	 * queue up to two when the transport aligns its areas to PAGE_SIZE, so
> +	 * four slots is the floor for either layout.
> +	 *
> +	 * Four slots is four pages of pool, which is five pages of region for
> +	 * a region whose base is already aligned, since the page the pool
> +	 * starts after is not part of it.
> +	 *
> +	 * That derivation counts one virtqueue.  A device that also offers an
> +	 * administration virtqueue has its areas allocated from the same region
> +	 * through the same path, and one administration command occupies
> +	 * several slots more, so four pages is a floor such a device is
> +	 * misconfigured to sit on rather than a size it can work at.
> +	 *
> +	 * This floor is enforced, but it is a floor and not a sufficiency
> +	 * check.  How much a device actually needs depends on how many
> +	 * virtqueues its driver creates and how deep they are, neither of
> +	 * which is known here: this runs during feature negotiation, before
> +	 * find_vqs().  A region above this floor but still too small fails
> +	 * there instead, which for a split ring reduces the queue depth and
> +	 * for a packed ring fails the queue.
> +	 *
> +	 * The upper bounds are what a slot index, a mapping length and a
> +	 * published handle can each represent.  The mapping length bound is
> +	 * exclusive because the length mapped is base_off larger than the
> +	 * pool, and base_off is a whole page where the region base is
> +	 * aligned: at the last representable slot count that sum would wrap
> +	 * to zero on a 32-bit size_t.
> +	 */
> +	if (slots < 4 || slots > UINT_MAX ||
> +	    slots >= (u64)(SIZE_MAX >> PAGE_SHIFT) ||
> +	    base_off + (slots << PAGE_SHIFT) - 1 >
> +			DMA_BIT_MASK(BITS_PER_TYPE(dma_addr_t))) {
> +		dev_warn(&vdev->dev,
> +			 "device memory buffer region holds %llu usable pages\n",
> +			 slots);
> +		return -EINVAL;
> +	}
> +	nslots = slots;
> +
> +	/* Nothing outside the pool and the bytes ahead of it is used. */
> +	map_len = base_off + ((size_t)nslots << PAGE_SHIFT);
> +
> +	/*
> +	 * The transport reports the region in 64 bits while a resource is
> +	 * addressed in resource_size_t.  Refuse a region that does not fit
> +	 * rather than claim and map a truncated one.
> +	 */
> +	if (region.addr > (u64)(resource_size_t)-1 - map_len) {
> +		dev_warn(&vdev->dev,
> +			 "device memory buffer region at 0x%llx is not addressable\n",
> +			 region.addr);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Everything that identifies the region is known now and nothing has
> +	 * been touched yet, so an unchanged region can be adopted instead of
> +	 * being torn down and rebuilt identically.  That is what lets a
> +	 * virtqueue which outlived a suspend or a reset keep handles that are
> +	 * still valid, and it is why no separate freeze-time teardown is
> +	 * needed.  A region that moved can be neither adopted nor replaced
> +	 * under live virtqueues, so refuse without a warning: a device that
> +	 * moves its region while its driver still has virtqueues is
> +	 * misbehaving, which is not evidence of a kernel bug.
> +	 */
> +	if (vdev->map == &virtio_dmb_map_ops) {
> +		dmb = vdev->vmap.dmb;
> +
> +		if (dmb->shm_id == shm_id && dmb->map_phys == region.addr &&
> +		    dmb->map_len == map_len)
> +			return 0;
> +
> +		if (virtio_dmb_vqs_live(vdev))
> +			return -EBUSY;
> +
> +		virtio_dmb_destroy(vdev);
> +	}
> +
> +	dmb = kzalloc(sizeof(*dmb), GFP_KERNEL);
> +	if (!dmb)
> +		return -ENOMEM;
> +
> +	dmb->vdev = vdev;
> +	dmb->shm_id = shm_id;
> +	dmb->base_off = base_off;
> +	dmb->map_phys = region.addr;
> +	dmb->map_len = map_len;
> +
> +	/*
> +	 * A shared memory region need not lie in a BAR the transport already
> +	 * claimed, so record a claim on the range here.  The claim is
> +	 * advisory: where the region does lie in such a BAR the transport's
> +	 * own claim already covers it, and that is not a conflict with
> +	 * anything, so it must not fail the device.  A foreign driver cannot
> +	 * own another device's BAR range either, so a refusal here is not
> +	 * evidence that anything is wrong.
> +	 */
> +	dmb->map_claimed = request_mem_region(region.addr, map_len,
> +					      "virtio-dmb") != NULL;
> +	if (!dmb->map_claimed)
> +		dev_dbg(&vdev->dev,
> +			"device memory buffer region at 0x%llx already reserved\n",
> +			region.addr);
> +
> +	/*
> +	 * MEMREMAP_DEC because the region is memory shared with the device,
> +	 * which is what the proposal requires of a driver wherever the platform
> +	 * distinguishes that from memory private to the driver.  Without it
> +	 * x86's arch_memremap_wb() applies the guest's own encryption to the
> +	 * mapping, and the device would see ciphertext wherever a guest encrypts
> +	 * its memory.  x86 is the only architecture that reads the flag; arm64
> +	 * ignores it and reaches ioremap_prot() instead, where a realm guest's
> +	 * hook finds the region is not protected memory and shares the mapping.
> +	 * Anywhere else that draws the distinction, the proposal forbids the
> +	 * device from offering the feature at all.
> +	 */
> +	dmb->map_va = memremap(region.addr, map_len,
> +			       MEMREMAP_WB | MEMREMAP_DEC);
> +	if (!dmb->map_va) {
> +		/*
> +		 * memremap() is silent, and every sibling failure in this
> +		 * function names itself.  Without this the device is left with
> +		 * the FAILED status bit set and nothing saying why.
> +		 */
> +		dev_warn(&vdev->dev,
> +			 "cannot map device memory buffer region at 0x%llx\n",
> +			 region.addr);
> +		err = -ENOMEM;
> +		goto err_unclaim;
> +	}
> +
> +	/*
> +	 * The skew was derived from the physical base, so the pool is aligned
> +	 * in the mapping only if the mapping kept that page offset.  Check it
> +	 * rather than assume it.
> +	 */
> +	if (offset_in_page(dmb->map_va) != skew) {
> +		dev_warn(&vdev->dev,
> +			 "device memory buffer mapping is not page-congruent\n");
> +		err = -EINVAL;
> +		goto err_unmap;
> +	}
> +
> +	dmb->base_va = dmb->map_va + (size_t)base_off;
> +
> +	dmb->bitmap = bitmap_zalloc(nslots, GFP_KERNEL);
> +	if (!dmb->bitmap) {
> +		err = -ENOMEM;
> +		goto err_unmap;
> +	}
> +
> +	/* A zeroed record has end == 0, which is what marks a slot free. */
> +	dmb->slots = kvcalloc(nslots, sizeof(*dmb->slots), GFP_KERNEL);
> +	if (!dmb->slots) {
> +		err = -ENOMEM;
> +		goto err_free_bitmap;
> +	}
> +
> +	/*
> +	 * Divide the pool into independently locked areas, so that mappings on
> +	 * different CPUs do not serialise on one lock and the interrupts-off
> +	 * window of one search does not grow with the region.  This is the
> +	 * structure kernel/dma/swiotlb.c adopted in commit 20347fca71a3
> +	 * ("swiotlb: split up the global swiotlb lock"), for the same reason.
> +	 *
> +	 * area_slots is the power of two and nareas is derived from it, which
> +	 * is the reverse of swiotlb.  swiotlb indexes areas with a mask and
> +	 * rounds its pool size up to suit; a region's length is the device's
> +	 * and cannot be rounded up, and dividing a power-of-two area count into
> +	 * it would leave area_slots neither a power of two nor a multiple of
> +	 * BITS_PER_LONG.  That matters for correctness rather than for tuning:
> +	 * bitmap_set() and bitmap_clear() are non-atomic read-modify-write on
> +	 * an unsigned long, so two areas sharing a bitmap word under separate
> +	 * locks would lose updates.  A power-of-two area_slots at least
> +	 * BITS_PER_LONG makes every area own whole words, and makes the area of
> +	 * a slot a shift.  The cost is one division per claim where swiotlb has
> +	 * a mask, which is a fraction of the two copies every mapping already
> +	 * performs.
> +	 *
> +	 * num_possible_cpus() and not num_online_cpus(), so that the division
> +	 * is sized for the CPUs that can run rather than for the ones running
> +	 * when the region is installed, which on a guest that onlines the rest
> +	 * later would divide the pool for one.  Nothing is allocated per CPU
> +	 * and no area belongs to one, so a CPU going away strands no capacity
> +	 * and there is no hotplug callback.  A pool too small to divide that
> +	 * far yields fewer areas than CPUs, which then share.
> +	 */
> +	BUILD_BUG_ON(DMB_AREA_MIN_SLOTS > DMB_AREA_MAX_SLOTS);
> +	BUILD_BUG_ON(DMB_AREA_MIN_SLOTS < BITS_PER_LONG);
> +	BUILD_BUG_ON(!is_power_of_2(DMB_AREA_MIN_SLOTS));
> +
> +	target = nslots / roundup_pow_of_two(num_possible_cpus());
> +	if (target < DMB_AREA_MIN_SLOTS)
> +		/* rounddown_pow_of_two(0) is undefined. */
> +		area_slots = DMB_AREA_MIN_SLOTS;
> +	else
> +		area_slots = clamp_t(unsigned int,
> +				     rounddown_pow_of_two(target),
> +				     DMB_AREA_MIN_SLOTS, DMB_AREA_MAX_SLOTS);
> +
> +	nareas = DIV_ROUND_UP(nslots, area_slots);
> +
> +	dmb->areas = kcalloc(nareas, sizeof(*dmb->areas), GFP_KERNEL);
> +	if (!dmb->areas) {
> +		err = -ENOMEM;
> +		goto err_free_slots;
> +	}
> +
> +	for (i = 0; i < nareas; i++)
> +		spin_lock_init(&dmb->areas[i].lock);
> +
> +	dmb->nslots = nslots;
> +	dmb->nareas = nareas;
> +	dmb->area_slots = area_slots;
> +	dmb->area_shift = ilog2(area_slots);
> +
> +	/* Published last: until now nothing routes a mapping here. */
> +	dmb->prev_map = vdev->map;
> +	dmb->prev_vmap = vdev->vmap;
> +	vdev->vmap.dmb = dmb;
> +	vdev->map = &virtio_dmb_map_ops;
> +
> +	/*
> +	 * The feature moves every virtqueue of this device into a region and
> +	 * changes what every address published to it means, and it activates
> +	 * from a value the device supplies that nothing else records.  Report
> +	 * the three facts about it that are recoverable nowhere else, on the
> +	 * device that negotiated it, and the derived area geometry with them so
> +	 * that it is visible without debugfs.
> +	 */
> +	dev_info(&vdev->dev,
> +		 "device memory buffer %u at %pa, %u usable pages in %u areas of %u pages\n",
> +		 shm_id, &dmb->map_phys, nslots, dmb->nareas,
> +		 dmb->area_slots);
> +
> +	return 0;
> +
> +err_free_slots:
> +	kvfree(dmb->slots);
> +err_free_bitmap:
> +	bitmap_free(dmb->bitmap);
> +err_unmap:
> +	memunmap(dmb->map_va);
> +err_unclaim:
> +	if (dmb->map_claimed)
> +		release_mem_region(dmb->map_phys, dmb->map_len);
> +	kfree(dmb);
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtio_dmb_init);
> +
> +MODULE_DESCRIPTION("Virtio device memory buffer allocator");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/virtio/virtio_dmb.h b/drivers/virtio/virtio_dmb.h
> new file mode 100644
> index 000000000000..69fbcbb9c2c0
> --- /dev/null
> +++ b/drivers/virtio/virtio_dmb.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Device Memory Buffer support for virtio devices.
> + */
> +#ifndef _DRIVERS_VIRTIO_VIRTIO_DMB_H
> +#define _DRIVERS_VIRTIO_VIRTIO_DMB_H
> +
> +struct virtio_device;
> +
> +#if IS_ENABLED(CONFIG_VIRTIO_DMB)
> +
> +int virtio_dmb_init(struct virtio_device *vdev);
> +void virtio_dmb_destroy(struct virtio_device *vdev);
> +
> +#else
> +
> +static inline int virtio_dmb_init(struct virtio_device *vdev)
> +{
> +	return 0;
> +}
> +
> +static inline void virtio_dmb_destroy(struct virtio_device *vdev)
> +{
> +}
> +
> +#endif /* CONFIG_VIRTIO_DMB */
> +
> +#endif /* _DRIVERS_VIRTIO_VIRTIO_DMB_H */
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 93e573c56563..cd3fe82ff328 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -44,12 +44,15 @@ struct virtqueue {
>  };
>  
>  struct vduse_vq_group;
> +struct virtio_dmb;
>  
>  union virtio_map {
>  	/* Device that performs DMA */
>  	struct device *dma_dev;
>  	/* VDUSE specific virtqueue group for doing map */
>  	struct vduse_vq_group *group;
> +	/* Device Memory Buffer holding the virtqueues and their buffers */
> +	struct virtio_dmb *dmb;
>  };
>  
>  int virtqueue_add_outbuf(struct virtqueue *vq,
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 69f84ea85d71..a6780aa85966 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -96,6 +96,13 @@ struct virtqueue_info {
>   * @set_vq_affinity: set the affinity for a virtqueue (optional).
>   * @get_vq_affinity: get the affinity for a virtqueue (optional).
>   * @get_shm_region: get a shared memory region based on the index.
> + * @get_dmb_shm_id: get the shared memory id of the Device Memory Buffer
> + *	(optional).
> + *	vdev: the device
> + *	id: where to store the shared memory id
> + *	Returns 0 on success or error status
> + *	Only valid once VIRTIO_F_DMB has been negotiated.  A transport that
> + *	does not implement this must not accept VIRTIO_F_DMB.
>   * @disable_vq_and_reset: reset a queue individually (optional).
>   *	vq: the virtqueue
>   *	Returns 0 on success or error status
> @@ -135,6 +142,7 @@ struct virtio_config_ops {
>  						 int index);
>  	bool (*get_shm_region)(struct virtio_device *vdev,
>  			       struct virtio_shm_region *region, u8 id);
> +	int (*get_dmb_shm_id)(struct virtio_device *vdev, u16 *id);
>  	int (*disable_vq_and_reset)(struct virtqueue *vq);
>  	int (*enable_vq_after_reset)(struct virtqueue *vq);
>  };

