Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98830239E9B
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786315280; cv=none; b=cysCg94LpuMs8+wTkM1T3oF3g43ZshkB1+Dme+ij/L6CGE58BIk1LO9NxY19eCYlUkDZZdDZcWoOBdMwGeWAgKEbBgJ3Z8qa2E5xRTyIPMOOMU/eOx25lJ4v52H42LqgEvixDSocTGty8mWB/+M13mDyF/QXhgFDcm2cyg5XCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786315280; c=relaxed/simple;
	bh=7/jFbs7ebHD48NSkuexeto4Myis82qtGGvDmYNvv/OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XdFhNKWa4uAD874ktLPJP73N/3aMpxqpky0IfCh0nwk9M9drZvRaAztRQ2O+xzpkJ1Mk2wJo/jtMNXdDVRIGW0qB595up85bigWanZ2LKDIvKohPbAL09Pn9cTW6yjR/a1rmBhdYTqmKCmFmquFTjpMPek14G2/KIWFM5Lf9hYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSzd1/l2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSzd1/l2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786315275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kdws6qaQNZhfbB6OQDyEII45v5VcuvHzuWtsJhj3o9I=;
	b=iSzd1/l24ggbWpsGxwXtnA/oJv0xfdCCUb8dU6W7HCit0rqtTLIP+FrtdlzM6mBpAKOfvr
	tBH3iJTwJpVDKbLoHS7A/CmJSWPVbDg5mcGXWdh59cRYf8qAuXDRFoilgln14t/6cg42LG
	K1TgI47Q1U+Rnj0kcvRkOSVJ36blI0Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-BbtL0VIkMUOTSRwVDH584Q-1; Sun, 09 Aug 2026 18:41:08 -0400
X-MC-Unique: BbtL0VIkMUOTSRwVDH584Q-1
X-Mimecast-MFC-AGG-ID: BbtL0VIkMUOTSRwVDH584Q_1786315267
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so12800865e9.1
        for <virtualization@lists.linux.dev>; Sun, 09 Aug 2026 15:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786315267; x=1786920067;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdws6qaQNZhfbB6OQDyEII45v5VcuvHzuWtsJhj3o9I=;
        b=XewRlJ/jNmfTYDcyGiG4s8mLdxP7bHlLg1CYPcx1VWuXcwYFqLErX8d9WcSYMBeBUj
         EWu7aAbL2GTvfGaRM5M4sPKbwqJUKKXLafOxDV2xTsoKIR0jHNTNHHToHseU8h+mSNVs
         KwqXJuPMV4w8yNQg0Ae2APERIED8O1fLyOCNo/kVTW1Bx6sXaX9RnzYPPgo7wLMf0xjK
         xjYxW8O4HGddQ/ugsPvc5nlLt1XwI3uqE4qrZevvlzAofQrjiboDKYBI6x8P8PXfkCWI
         ifQ2fcxBpJnDT3ygxjyyelh4uT6m/GVyIZomWYarasgoKWp1pGYy491+b9IRwEmI5P2F
         IkFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKhtBQqW6V/hOIOOXS2cll51qSMl8P4hiDqxD5sX3sOMnENXh5K67DY6BX9XyzxH7f9g+8hdc9GOq+RjJrxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzimCIyOX2QXEWvLfSPk9LDXMmWM50hpjmTEgZdGRHOlA6U4Mz2
	56RONdwJKv/Jt5TJVFQb39ihKNASbCzJl80nvmZ8tXMuO0p2iVkfm1FCIX8uP7loCiuuCtvjcZC
	OKDSpSBanN0d9I+qhHk61YBKovLrwg4TjO0EY87mRy1fsYCYO3NQ4qzKgkv54qhXl24UH
X-Gm-Gg: AR+sD117TAMEYJHChfX88KfQgQ6Q2kpsBoSAEF15KOcCyxeG2opQ+W+kjsNieHnolBI
	ivhbP9xZuBLR9iJDu2K8oGGvtKWi4c0h/DWWXEq4orMDLLIaZE8I1wNvm6jjCLwU2OcBC5N+KIC
	80PHoAxhfounRUnfH8t324/Xc/nLAckodBBlHpzUwpfOL7Qd2anwcPGTgMkBrpLxI7MsFcnQkiq
	iF3M1iGuAx6uskVUGQEFHG5b1VqvQDs8oTNPiSJCjeum7WksDMi2jpvj//G3RngW1CaYO0Ru50s
	0mLpmGb+gWsPMiOSjPwbC+GHCqW8HWN75QWXgF8x8hWY7zSNZtn03TwSlCpcZy8JMgFH286t/cj
	pPvz99lUiJJlx6p4TEKTHfg==
X-Received: by 2002:a05:600c:3b0a:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-4994e71d7b0mr484703075e9.5.1786315266318;
        Sun, 09 Aug 2026 15:41:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0a:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-4994e71d7b0mr484702395e9.5.1786315265154;
        Sun, 09 Aug 2026 15:41:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bb81731sm176140795e9.0.2026.08.09.15.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 15:41:03 -0700 (PDT)
Date: Sun, 9 Aug 2026 18:41:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 12/12] virtio: guarantee a virtqueue can publish its
 first descriptor chain
Message-ID: <20260809184014-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260809182010.32931-13-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260809182010.32931-13-graf@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2N1JC-8aJOhnfYV9SGvHtWihNlEnQHtRQX4Plo7cM50_1786315267
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 09, 2026 at 06:20:10PM +0000, Alexander Graf wrote:
> A device's pool is shared by every virtqueue it has and nothing
> partitions it between them, so a virtqueue that asks late can get
> nothing at all. virtnet_open() pre-fills the receive queues in index
> order and discards the result, and a queue that came up with nothing is
> one the device cannot signal a completion on.
> 
> Withhold a range of the pool from ordinary claims and let a virtqueue
> whose ring is empty draw on it for one descriptor chain.

Why bother? one chain can just go inline in the ring.

> vring_map_reserve_attr() marks those mappings with a new attrs bit,
> VIRTIO_MAP_ATTR_RESERVE, which asks a bounded map implementation to
> serve them out of the withheld range and which it may ignore.
> VIRTIO_MAP_ATTR_MASK collects the attrs bits virtio owns, which
> virtqueue_map_page_attrs() strips before any dma_map_*() call.
> 
> VIRTIO_MAP_RESERVE_PAGES bounds what one chain may draw at 32 pages,
> enough for a page-granular chain at the default CONFIG_MAX_SKB_FRAGS.
> Size the withheld range as one chain's allowance plus one page for each
> virtqueue beyond the one drawing the chain; an allowance per virtqueue
> would be a permanent shortage, since only an empty ring may draw.
> virtio_dmb_note_vqs() takes the count from vp_modern_find_vqs(), which
> counts the administration virtqueue too, and the size it arrives at
> appears in a second probe-time message and in dmb/reserved_pages.
> 
> The new VIRTIO_DMB_KUNIT_TEST option covers the range's geometry and the
> withdrawal of the feature, neither of which we reach on a real device.
> 
> That way a virtqueue that comes up against a full pool publishes its
> first chain and gets a completion to wait for.
> 
> Assisted-by: Kiro:claude-opus-5 checkpatch sparse
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  .../driver-api/virtio/virtio-dmb.rst          | 178 +++++++++--
>  drivers/virtio/Kconfig                        |  13 +
>  drivers/virtio/virtio_dmb.c                   | 247 ++++++++++++++--
>  drivers/virtio/virtio_dmb.h                   |   6 +
>  drivers/virtio/virtio_dmb_test.c              | 279 ++++++++++++++++++
>  drivers/virtio/virtio_pci_modern.c            |  18 +-
>  drivers/virtio/virtio_ring.c                  |  84 +++++-
>  include/linux/virtio_config.h                 |  33 +++
>  8 files changed, 784 insertions(+), 74 deletions(-)
>  create mode 100644 drivers/virtio/virtio_dmb_test.c
> 
> diff --git a/Documentation/driver-api/virtio/virtio-dmb.rst b/Documentation/driver-api/virtio/virtio-dmb.rst
> index 610db080dee5..d84f0771f010 100644
> --- a/Documentation/driver-api/virtio/virtio-dmb.rst
> +++ b/Documentation/driver-api/virtio/virtio-dmb.rst
> @@ -302,15 +302,18 @@ So a device must offer at least::
>                  + sum over virtqueues of
>                      [ ring_pages(num) + num * slots(max_request) ]
>                      * PAGE_SIZE
> +                + reserved * PAGE_SIZE
>  
>    where the leading PAGE_SIZE covers the bytes ahead of the pool, and is
>    a whole page because a device cannot know the guest's page size and so
>    cannot know whether its region base is aligned to one,
>    slots(max_request) is the largest slots(request) value from the
>    formula above the driver can produce for one request on that queue,
> -  and ring_pages(num) is the pages one virtqueue's Descriptor, Driver and
> +  ring_pages(num) is the pages one virtqueue's Descriptor, Driver and
>    Device Areas occupy: ceil(vring_size(num, align) / PAGE_SIZE) for a
> -  split ring, and ceil(num * 16 / PAGE_SIZE) + 2 for a packed one
> +  split ring, and ceil(num * 16 / PAGE_SIZE) + 2 for a packed one,
> +  and reserved is the range withheld from ordinary claims, described
> +  under "The withheld range" below
>  
>  A device that also offers an administration virtqueue pays for it out of
>  the same region: its virtqueue areas are allocated through the same path,
> @@ -391,6 +394,13 @@ the ones it goes on to use: ``virtnet_find_vqs()`` creates
>    floor_slots = rings + Q * B_rx + tx_min + ctrl   multi-queue works: one
>                                                     receive buffer per queue
>    work_slots  = rings + rx_fill + tx_min + ctrl    receive rings full
> +  reserved    = min(32 + V - 1, pages / 2)     withheld, and zero below 256
> +                                               pages; a short last pool
> +                                               area can add to it, see
> +                                               below.  The V there counts
> +                                               an administration virtqueue
> +                                               too where a device has one
> +  region_slots = work_slots + reserved         what a device must offer
>  
>  Every term above assumes ``VIRTIO_F_INDIRECT_DESC``, which is what the
>  ``+ 3`` and the ``ctrl`` table account for.  Without it a chain occupies one
> @@ -402,25 +412,33 @@ so ``rx_fill`` and not ``floor_slots`` is the working figure.  For a split
>  ring, x86_64, 4 KiB pages, ``MAX_SKB_FRAGS`` 17, mergeable receive buffers
>  and ``C = 1``:
>  
> -=====  =====  =======  =========  ============  ==========
> -Q      num    rings    rx_fill    work_slots    work MiB
> -=====  =====  =======  =========  ============  ==========
> -1      256    6        256        287           1.1
> -4      256    18       1024       1127          4.4
> -8      256    34       2048       2247          8.8
> -8      1024   119      8192       8476          33.1
> -16     1024   231      16384      16940         66.2
> -32     1024   455      32768      33868         132.3
> -64     1024   903      65536      67724         264.5
> -=====  =====  =======  =========  ============  ==========
> -
> -Two things to take from it.  ``rx_fill`` dominates: it is 65536 slots of the
> -67724 sixty-four queue pairs come to, so sizing a region for multiple queues
> -is "how many receive buffers will be posted" to within three and a quarter
> -percent, and the virtqueue rings are the smaller part of what is left -- 903
> -slots against ``tx_min``'s 1280.  And the pool areas of the previous
> -subsection do not appear at all, because they cost guest memory rather than
> -region pages.
> +=====  =====  =======  =========  ============  ==========  ========  ========
> +Q      num    rings    rx_fill    work_slots    work MiB    reserved  region
> +=====  =====  =======  =========  ============  ==========  ========  ========
> +1      256    6        256        287           1.1         34        321
> +4      256    18       1024       1127          4.4         40        1167
> +8      256    34       2048       2247          8.8         48        2295
> +8      1024   119      8192       8476          33.1        48        8524
> +16     1024   231      16384      16940         66.2        64        17004
> +32     1024   455      32768      33868         132.3       96        33964
> +64     1024   903      65536      67724         264.5       160       67884
> +=====  =====  =======  =========  ============  ==========  ========  ========
> +
> +``region`` is ``region_slots``, the figure to offer; ``work MiB`` is
> +``work_slots`` in mebibytes and excludes ``reserved``.  The
> +sixty-four-queue-pair row is 265.2 MiB of region against the 264.5
> +``work_slots`` alone comes to.
> +
> +Three things to take from it.  ``rx_fill`` dominates: it is 65536 slots of
> +the 67884 a sixty-four-queue-pair region comes to, so sizing a region for
> +multiple queues is "how many receive buffers will be posted" to within three
> +and a half percent, and the virtqueue rings are the smaller part of what is
> +left -- 903 slots against ``tx_min``'s 1280.  ``reserved`` is small and grows
> +with the virtqueue count rather than with the region -- 160 slots at
> +sixty-four queue pairs, under a quarter of one percent -- but it is not
> +optional, because it is withheld rather than merely spent.  And the pool
> +areas of the previous subsection do not appear at all, because they cost
> +guest memory rather than region pages.
>  
>  The receive buffer mode is a twenty-fold multiplier the device cannot
>  predict.  A driver that negotiates any of ``VIRTIO_NET_F_GUEST_TSO4``,
> @@ -432,6 +450,83 @@ which is 160.8 MiB instead of 8.8.  A device offering guest segmentation
>  offload without ``MRG_RXBUF`` must size for that.  Offering ``MRG_RXBUF``
>  is the better answer.
>  
> +The withheld range
> +------------------
> +
> +Part of the pool is withheld from ordinary claims so that a virtqueue
> +whose ring is empty can publish a chain whatever the others have mapped::
> +
> +  reserved = 0                            if pages < 256
> +           = min(32 + V - 1, pages / 2)   otherwise, plus the last pool
> +                                          area's page count where that
> +                                          area is short enough to split
> +                                          the range -- see below
> +
> +One page for each of the ``V`` virtqueues, and a chain's allowance of 32
> +pages on top, less the one page already counted for whichever virtqueue
> +draws the chain.  A virtqueue may draw on the range only while its ring is
> +empty, and only for one chain of up to 32 pages, which the ring asks for by
> +setting ``VIRTIO_MAP_ATTR_RESERVE`` on the mapping.  That is the case worth
> +protecting: a virtqueue with nothing published has no completion of its own
> +to be woken by, because the device cannot signal a used buffer on a queue
> +with no buffers posted, so it depends entirely on its owner retrying.  A
> +virtqueue that has published a chain does not need the guarantee, and does
> +not get it.
> +
> +Both terms follow from that restriction.  Because a running virtqueue
> +cannot draw, the range is contended only by the virtqueues that have
> +published nothing; there are at most ``V`` of those, and what each of them
> +needs is the one page that takes its ring from empty to non-empty.  The 31
> +pages left over, plus that virtqueue's own one, are then a whole chain for
> +whichever of them is publishing more than a single page.
> +
> +So the guarantee is: every virtqueue can obtain one page that no running
> +virtqueue can take, and one virtqueue at a time can obtain a whole chain.
> +For virtio_net that is the whole of it at any queue count, because a
> +mergeable receive buffer is one slot and a linear transmit is one slot: the
> +resident draw is ``2 * Q + 5`` pages against the ``31 + V`` withheld, and
> +``2 * Q + 5 <= 2 * Q + 32`` holds for every ``Q``.  What is *not*
> +guaranteed is ``V`` simultaneous multi-page first chains.  A second
> +virtqueue whose first chain needs more than its one page competes for the
> +32 and, losing, gets ``-ENOMEM`` -- the value it got before the range
> +existed, and one every caller answers by retrying later rather than by
> +waiting for a completion it has not got.  Sizing the range for ``V`` whole
> +chains instead would withhold ``32 * V``, which on a small region is a
> +fixed fraction of the pool and is capacity the transmit path then does not
> +have; that trades a rare mapping failure for a permanent shortage, so the
> +quantity is deliberately not the product of the two worst cases.
> +
> +The range is the tail of the pool, and an allocation has to lie inside one
> +pool area, so a whole chain needs 32 of the withheld pages contiguous within
> +one area and not merely free.  Where the last pool area is shorter than 32
> +pages the range straddles the boundary below it, and where the piece above
> +that boundary and the piece below are both shorter than a chain, the range
> +is widened by the short area's length so that the piece below it is a whole
> +``31 + V`` pages.  That costs under 32 pages and only where ``pages`` is just
> +above a multiple of ``area_pages``; no row of the table above reaches it, and
> +neither does any region whose page count is a multiple of ``area_pages`` or at
> +least 32 above one.
> +
> +The guarantee holds for every virtqueue on any pool of 256 pages or more, and
> +below that the range is inert altogether, because it would withhold more than
> +it protects.  Above ninety-seven virtqueues the half-of-the-pool bound is the
> +later of the two conditions, and the pool has to be ``62 + 2 * V`` pages or
> +more instead.  Every row of the table above is far clear of both: the
> +tightest is 287 pages against the 68 three virtqueues need.  That bound is
> +not a policy, only what keeps the ordinary range non-empty; where it does
> +bind, the pool has fewer pages than the virtqueues alone want and the
> +guarantee covers as many of them as it has pages for.
> +
> +This is a floor and not a fair share.  A single busy virtqueue may still
> +use everything outside the withheld range: on a 16 MiB region with eight
> +queue pairs and depth-1024 rings that is 3928 of 4095 pages, the region
> +less the 48 withheld and the 119 the virtqueue areas hold.  The range is
> +sized from every virtqueue the transport creates, which is the driver's
> +count plus an administration virtqueue where the device offers one, and
> +which over-counts a device that offers more queue pairs than the driver
> +uses; over-counting withholds one page per unused virtqueue and never
> +denies capacity.
> +
>  An undersized multi-queue region fails in two ways, and both are
>  properties of the network driver's existing behaviour rather than of the
>  region.
> @@ -439,12 +534,16 @@ region.
>  First, cross-queue starvation.  ``virtnet_open()`` pre-fills the receive
>  queues in index order and discards the result, so queue 0 takes what it
>  needs before queue 1 asks.  A region that cannot hold every queue's fill
> -leaves the later queues with no buffers at all; the device's receive
> -steering then drops whatever it sends to them, and transmit fails on every
> -queue with ``tx_fifo_errors``, ``tx_dropped`` and a rate-limited
> -``Unexpected TXQ`` message.  Pool areas do not help: at
> -``virtnet_open()`` every fill runs on whichever CPU brought the link up, so
> -they all share one home area.  Areas give preference, never reservation.
> +leaves the later queues with far fewer buffers than the earlier ones; the
> +device's receive steering then drops most of what it sends to them, and
> +transmit fails on those queues with ``tx_fifo_errors``, ``tx_dropped`` and
> +a rate-limited ``Unexpected TXQ`` message.  Pool areas do not help: at
> +``virtnet_open()`` every fill runs on whichever CPU brought the link up,
> +so they all share one home area, and areas give preference rather than
> +reservation.  The withheld range bounds how bad this gets -- no virtqueue
> +is left unable to publish anything at all -- but one buffer per queue is a
> +floor for forward progress, not a working receive ring.  Sizing the region
> +for ``region_slots`` is what avoids it.
>  
>  Second, a receive queue that holds no buffers and cannot refill spends
>  softirq time without making progress.  ``try_fill_recv()`` reports failure
> @@ -624,6 +723,14 @@ The claimed range also appears in ``/proc/iomem`` as
>  appears nowhere else at all.  The three counts appear again in
>  ``dmb/pages``, ``dmb/areas`` and ``dmb/area_pages`` below.
>  
> +A second line follows when the driver creates its virtqueues, because the
> +count they come to is not known any earlier::
> +
> +  virtio_net virtio5: device memory buffer withholds 48 of 4095 pages for 17 virtqueues
> +
> +That is the withheld range of the previous section, and the virtqueue count
> +it was sized from.  It appears again in ``dmb/reserved_pages``.
> +
>  With ``CONFIG_VIRTIO_DEBUG`` the state of the region is also available
>  under the device's virtio debugfs directory, in ``dmb/``.  The directory
>  exists only while the device has a region, so a device that did not
> @@ -643,11 +750,20 @@ they accept may change or go away.
>    ``area_pages`` divides ``pages``.  Both are fixed when the region is
>    installed and are the same two values the probe-time message prints.
>  
> +``reserved_pages``
> +  how many pages are withheld from ordinary claims so that a virtqueue whose
> +  ring is empty can publish a chain.  Zero until the driver asks for its
> +  virtqueues, and zero for good on a pool too small for the mechanism to
> +  mean anything.  Not subtracted from ``pages``: the withheld pages are
> +  part of the pool and are counted in ``used_pages`` when a virtqueue draws
> +  on them.
> +
>  ``used_pages``
> -  how many of them are allocated.  One counter maintained across all areas
> -  rather than a sum of per-area figures read at different moments, so it
> -  never reports a torn total; it is raised just outside the area lock, so a
> -  read taken during a claim or a release can lag the bitmap by that claim.
> +  how many of the pool's pages are allocated.  One counter maintained
> +  across all areas rather than a sum of per-area figures read at different
> +  moments, so it never reports a torn total; it is raised just outside the
> +  area lock, so a read taken during a claim or a release can lag the bitmap
> +  by that claim.
>  
>  ``used_pages_hiwater``
>    the largest ``used_pages`` has been.  This, rather than a sample of
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 67a7dc1a87df..628ce92edf81 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -204,6 +204,19 @@ config VIRTIO_DMB
>  
>  	  If unsure, say Y.
>  
> +config VIRTIO_DMB_KUNIT_TEST
> +	bool "Device Memory Buffer allocator tests" if !KUNIT_ALL_TESTS
> +	depends on VIRTIO_DMB && KUNIT=y
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Tests for the geometry of the range the allocator withholds so that
> +	  a virtqueue with an empty ring can publish its first descriptor
> +	  chain, and for what becomes of a region when a negotiation drops
> +	  the feature.  Neither case arises on a device anyone is likely to
> +	  build, so a test rather than a measurement is what keeps both true.
> +
> +	  If unsure, say N.
> +
>  config VIRTIO_RTC
>  	tristate "Virtio RTC driver"
>  	depends on VIRTIO
> diff --git a/drivers/virtio/virtio_dmb.c b/drivers/virtio/virtio_dmb.c
> index fe556d585f24..773b5bb38dc6 100644
> --- a/drivers/virtio/virtio_dmb.c
> +++ b/drivers/virtio/virtio_dmb.c
> @@ -128,6 +128,7 @@ struct virtio_dmb_area {
>   * @area_slots: slots one area covers, a power of two; the last area covers
>   *	fewer when @nslots is not a multiple of it
>   * @area_shift: ilog2(@area_slots), so slot >> @area_shift names its area
> + * @nvqs: virtqueues the transport created, which sizes the withheld range
>   * @total_used: slots allocated across every area, exact; CONFIG_VIRTIO_DEBUG
>   * @used_hiwater: the largest @total_used has been since the last reset through
>   *	debugfs, or since init; CONFIG_VIRTIO_DEBUG
> @@ -152,6 +153,7 @@ struct virtio_dmb {
>  	unsigned int		 nareas;
>  	unsigned int		 area_slots;
>  	unsigned int		 area_shift;
> +	unsigned int		 nvqs;
>  #ifdef CONFIG_VIRTIO_DEBUG
>  	/*
>  	 * Exact occupancy for the two debugfs files, kept outside the area
> @@ -286,26 +288,116 @@ static void virtio_dmb_inc_alloc_failed(struct virtio_dmb *dmb)
>  #endif /* CONFIG_VIRTIO_DEBUG */
>  
>  /*
> - * Claim @nr contiguous slots from area @i, or -ENOMEM when that one area
> - * cannot satisfy the request.  Takes and drops that area's lock and touches
> - * no other area's state, so no path ever holds two of these locks and there
> - * is no ordering between them to get right.
> + * Slots withheld from ordinary claims so that a virtqueue with an empty ring
> + * can publish a chain even when every other virtqueue has filled the rest of
> + * the pool.  A virtqueue with nothing published has no completion of its own
> + * to be woken by, because the device cannot signal a used buffer on a queue
> + * with no buffers posted, so it depends entirely on its owner retrying; one
> + * that has published a chain does not.
> + *
> + * One page for every virtqueue, and the rest of one chain's allowance on top.
> + * Both terms follow from who can draw: only a virtqueue whose ring is empty
> + * may, so the range is contended by the virtqueues that have published
> + * nothing and never by the ones that are running.  At most nvqs of those
> + * exist, each needing the one page that takes its ring from empty to
> + * non-empty, and VIRTIO_MAP_RESERVE_PAGES less that one page is then what is
> + * left for whichever of them is publishing a chain longer than a single page.
> + *
> + * Withholding a whole chain's allowance for every virtqueue instead would be
> + * sizing for a state the device cannot be in, and it costs
> + * nvqs * VIRTIO_MAP_RESERVE_PAGES -- on a small pool a fixed fraction of it,
> + * which is capacity the transmit path then does not have.  That trades a
> + * mapping failure which is rare for a shortage which is permanent, so the
> + * quantity is deliberately not a product of the two worst cases.
> + *
> + * The range is the tail of the pool, but an allocation lies inside one area,
> + * so a whole chain needs VIRTIO_MAP_RESERVE_PAGES of the range contiguous
> + * within one area rather than merely free.  Where the last area is short the
> + * range straddles the boundary below it and the two pieces are the last
> + * area's length and the remainder; when both fall short of a chain, no area
> + * holds one however much of the range is free.  Widening the range by the
> + * short area's length in that case moves its start down to the boundary,
> + * which gives the piece below a full VIRTIO_MAP_RESERVE_PAGES + nvqs - 1
> + * slots.  It costs the short area's length, which is under
> + * VIRTIO_MAP_RESERVE_PAGES because that is the case being tested for, and it
> + * is reached only where nslots is just above a multiple of area_slots, so no
> + * geometry in Documentation/driver-api/virtio/virtio-dmb.rst pays for it.
> + *
> + * Sized for every virtqueue the transport creates, which over-counts a device
> + * offering more queue pairs than the driver uses.  Over-counting withholds one
> + * page per unused virtqueue and never denies capacity.  The half-of-the-pool
> + * bound is not part of the policy: it is what keeps the ordinary range
> + * non-empty, and where it binds the pool has fewer pages than the virtqueues
> + * alone want, so the guarantee covers as many of them as it has pages for.
> + * Zero on a pool too small for the mechanism to mean anything, where it is
> + * inert rather than crippling, and zero until the count is known.
> + */
> +static unsigned int virtio_dmb_reserved(const struct virtio_dmb *dmb)
> +{
> +	unsigned int nvqs = READ_ONCE(dmb->nvqs);
> +	unsigned int last, reserved;
> +
> +	if (!nvqs || dmb->nslots < 8 * VIRTIO_MAP_RESERVE_PAGES)
> +		return 0;
> +
> +	reserved = min(VIRTIO_MAP_RESERVE_PAGES + nvqs - 1, dmb->nslots / 2);
> +
> +	/*
> +	 * reserved is at least VIRTIO_MAP_RESERVE_PAGES here, so the
> +	 * subtraction cannot wrap: the branch is taken only where last is
> +	 * below it.  Both pieces short of a chain bounds reserved below 2 *
> +	 * VIRTIO_MAP_RESERVE_PAGES, and nslots is at least 8 of them, so the
> +	 * widened range is still inside the half-of-the-pool bound and leaves
> +	 * the ordinary range a whole area less the reserve.
> +	 */
> +	last = virtio_dmb_area_len(dmb, dmb->nareas - 1);
> +	if (last < VIRTIO_MAP_RESERVE_PAGES &&
> +	    reserved - last < VIRTIO_MAP_RESERVE_PAGES)
> +		reserved += last;
> +
> +	return reserved;
> +}
> +
> +/*
> + * virtio_dmb_note_vqs() records the count that sizes the range above.  It is
> + * defined further down, next to the other entry points, because it has to test
> + * vdev->map against this file's operations.
> + */
> +
> +/*
> + * Claim @nr contiguous slots from area @i, bounded above at @end_max so that
> + * an ordinary claim cannot reach the withheld range.  Returns the first slot,
> + * or -ENOMEM when that one area cannot satisfy the request.  Takes and drops
> + * that area's lock and touches no other area's state, so no path ever holds
> + * two of these locks and there is no ordering between them to get right.
>   */
>  static long virtio_dmb_area_claim(struct virtio_dmb *dmb, unsigned int i,
> -				  unsigned int nr)
> +				  unsigned int nr, unsigned int end_max)
>  {
>  	struct virtio_dmb_area *area = &dmb->areas[i];
>  	unsigned int base = virtio_dmb_area_base(dmb, i);
> -	unsigned int end = base + virtio_dmb_area_len(dmb, i);
> +	unsigned int len = virtio_dmb_area_len(dmb, i);
> +	unsigned int end = min(base + len, end_max);
>  	unsigned long flags, slot;
>  
> +	if (end <= base)
> +		return -ENOMEM;
> +
>  	spin_lock_irqsave(&area->lock, flags);
>  
>  	/*
>  	 * Exact, and inside the lock.  Written as a subtraction from the
> -	 * area's own length rather than as len - used < nr, which underflows.
> +	 * length being searched rather than as len - used < nr, which
> +	 * underflows.
> +	 *
> +	 * @area->used counts the whole area, including any withheld slots in
> +	 * use, so for the one area that straddles @end_max this is
> +	 * conservative: it can refuse an ordinary claim that area could have
> +	 * satisfied, and the walk then tries the next one.  It cannot admit a
> +	 * claim the area could not satisfy.  That is the only approximation
> +	 * here, and it is confined to at most one area out of @nareas.
>  	 */
> -	if (nr > (end - base) - area->used)
> +	if (area->used >= end - base || nr > (end - base) - area->used)
>  		goto not_found;
>  
>  	/*
> @@ -314,9 +406,13 @@ static long virtio_dmb_area_claim(struct virtio_dmb *dmb, unsigned int i,
>  	 * index.  bitmap_find_next_zero_area() returns a value whose sum with
>  	 * @nr exceeds the size it was given when it finds nothing, so that sum
>  	 * is the test; the whole-pool "slot >= nslots" form does not transfer.
> +	 *
> +	 * @area->index is relative to the whole area, so it can point past a
> +	 * clamped @end; starting the sweep there would search nothing, hence
> +	 * the min().  The second sweep from the base then covers the range.
>  	 */
>  	slot = bitmap_find_next_zero_area(dmb->bitmap, end,
> -					  base + area->index, nr, 0);
> +					  min(base + area->index, end), nr, 0);
>  	if (slot + nr > end && area->index)
>  		slot = bitmap_find_next_zero_area(dmb->bitmap, end, base,
>  						  nr, 0);
> @@ -325,7 +421,7 @@ static long virtio_dmb_area_claim(struct virtio_dmb *dmb, unsigned int i,
>  
>  	bitmap_set(dmb->bitmap, slot, nr);
>  	area->used += nr;
> -	area->index = slot + nr < end ? slot + nr - base : 0;
> +	area->index = slot + nr < base + len ? slot + nr - base : 0;
>  
>  	spin_unlock_irqrestore(&area->lock, flags);
>  
> @@ -343,9 +439,39 @@ static long virtio_dmb_area_claim(struct virtio_dmb *dmb, unsigned int i,
>  	return -ENOMEM;
>  }
>  
> +/* One pass over every area, each bounded at @end_max. */
> +static long virtio_dmb_walk(struct virtio_dmb *dmb, unsigned int nr,
> +			    unsigned int end_max)
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
> +		ret = virtio_dmb_area_claim(dmb, i, nr, end_max);
> +		if (ret >= 0)
> +			return ret;
> +
> +		if (++i >= dmb->nareas)
> +			i = 0;
> +	} while (i != start);
> +
> +	return -ENOMEM;
> +}
> +
>  /*
>   * Claim @nr contiguous slots.  Returns the first slot, or -ENOMEM when no
> - * area can satisfy the request.  Exhaustion is a routine condition: the
> + * area can satisfy the request.  @reserved permits the withheld tail of the
> + * pool, and is set only for a mapping of the first chain a virtqueue is
> + * publishing.  Exhaustion is a routine condition: the
>   * region's length bounds how much virtqueue data can be in flight.  What a
>   * caller makes of it is the caller's, and it is not always back-pressure: a
>   * network receive fill has nothing to push back on when it cannot post a
> @@ -371,28 +497,32 @@ static long virtio_dmb_area_claim(struct virtio_dmb *dmb, unsigned int i,
>   * bounds the interrupts-off window to a single area's sweep; the total work in
>   * the failing case is a whole-pool sweep either way.
>   */
> -static long virtio_dmb_claim(struct virtio_dmb *dmb, unsigned int nr)
> +static long virtio_dmb_claim(struct virtio_dmb *dmb, unsigned int nr,
> +			     bool reserved)
>  {
> -	unsigned int i, start;
>  	long ret;
>  
>  	/*
> -	 * raw_smp_processor_id() and not smp_processor_id(): the index is
> -	 * computed before any lock is taken, so preemption or migration
> -	 * between the read and the claim only changes which area is tried
> -	 * first.  kernel/dma/swiotlb.c picks its home area on the same
> -	 * reasoning.
> +	 * The bitmap is its own accounting for the withheld range: bounding
> +	 * the search is what bounds the sum, so no counter is added to a
> +	 * production build's hot path.
>  	 */
> -	start = raw_smp_processor_id() % dmb->nareas;
> -	i = start;
> -	do {
> -		ret = virtio_dmb_area_claim(dmb, i, nr);
> +	ret = virtio_dmb_walk(dmb, nr, dmb->nslots - virtio_dmb_reserved(dmb));
> +	if (ret >= 0)
> +		return ret;
> +
> +	/*
> +	 * The second walk runs only once the first has failed in every area,
> +	 * so the withheld range is a last resort rather than a second pool.
> +	 * That is not the same as "only when the pool is full": next fit can
> +	 * fail on fragmentation while capacity remains, and this reaches the
> +	 * withheld range then too.
> +	 */
> +	if (reserved) {
> +		ret = virtio_dmb_walk(dmb, nr, dmb->nslots);
>  		if (ret >= 0)
>  			return ret;
> -
> -		if (++i >= dmb->nareas)
> -			i = 0;
> -	} while (i != start);
> +	}
>  
>  	/*
>  	 * The geometry rather than a free count: there is no instant at which
> @@ -733,7 +863,13 @@ static void *virtio_dmb_op_alloc(union virtio_map map, size_t size,
>  		goto no_room;
>  
>  	nr = virtio_dmb_slots(size);
> -	ret = virtio_dmb_claim(dmb, nr);
> +	/*
> +	 * false: a virtqueue area is structural, claimed when a queue is
> +	 * created or resized and never under back-pressure, so letting it into
> +	 * the withheld range would consume the reserve for the life of the
> +	 * queue rather than for one chain.
> +	 */
> +	ret = virtio_dmb_claim(dmb, nr, false);
>  	if (ret < 0)
>  		goto no_room;
>  	slot = ret;
> @@ -811,7 +947,7 @@ static dma_addr_t virtio_dmb_op_map_page(union virtio_map map,
>  		return DMA_MAPPING_ERROR;
>  
>  	nr = virtio_dmb_slots(size);
> -	ret = virtio_dmb_claim(dmb, nr);
> +	ret = virtio_dmb_claim(dmb, nr, attrs & VIRTIO_MAP_ATTR_RESERVE);
>  	if (ret < 0) {
>  		/*
>  		 * Counted here rather than in virtio_dmb_claim(), which
> @@ -1023,6 +1159,21 @@ static int virtio_dmb_alloc_failed_get(void *data, u64 *val)
>  DEFINE_DEBUGFS_ATTRIBUTE(virtio_dmb_alloc_failed_fops,
>  			 virtio_dmb_alloc_failed_get, NULL, "%llu\n");
>  
> +/*
> + * A getter rather than debugfs_create_u32(), because the value is derived
> + * from @nvqs and the pool size rather than stored.
> + */
> +static int virtio_dmb_reserved_get(void *data, u64 *val)
> +{
> +	struct virtio_dmb *dmb = data;
> +
> +	*val = virtio_dmb_reserved(dmb);
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(virtio_dmb_reserved_fops, virtio_dmb_reserved_get,
> +			 NULL, "%llu\n");
> +
>  /*
>   * The files go under the device's existing virtio debugfs directory, and exist
>   * only while the device has a region.  They describe one, so their presence is
> @@ -1049,6 +1200,8 @@ static void virtio_dmb_debugfs_init(struct virtio_dmb *dmb)
>  			    &virtio_dmb_hiwater_fops);
>  	debugfs_create_file("alloc_failed", 0400, dir, dmb,
>  			    &virtio_dmb_alloc_failed_fops);
> +	debugfs_create_file("reserved_pages", 0400, dir, dmb,
> +			    &virtio_dmb_reserved_fops);
>  }
>  
>  static void virtio_dmb_debugfs_exit(struct virtio_dmb *dmb)
> @@ -1068,6 +1221,40 @@ static void virtio_dmb_debugfs_exit(struct virtio_dmb *dmb)
>  
>  #endif /* CONFIG_VIRTIO_DEBUG */
>  
> +/**
> + * virtio_dmb_note_vqs - record how many virtqueues the transport created
> + * @vdev: the device
> + * @nvqs: virtqueues about to be created
> + *
> + * Sizes the range withheld so that a virtqueue whose ring is empty can
> + * publish a chain.  Does nothing unless @vdev is using a Device Memory
> + * Buffer.
> + *
> + * Called before the virtqueues exist, so the ring allocations that follow are
> + * ordinary claims and cannot land in the withheld range; and @nvqs therefore
> + * only ever changes while the device has no virtqueues and so no mappings.
> + * WRITE_ONCE() because the claim path reads it without any lock.
> + */
> +void virtio_dmb_note_vqs(struct virtio_device *vdev, unsigned int nvqs)
> +{
> +	struct virtio_dmb *dmb;
> +
> +	if (vdev->map != &virtio_dmb_map_ops)
> +		return;
> +
> +	dmb = vdev->vmap.dmb;
> +	WRITE_ONCE(dmb->nvqs, nvqs);
> +
> +	/*
> +	 * Reported here rather than from virtio_dmb_init(), which runs during
> +	 * feature negotiation and cannot know the count.  One line per probe.
> +	 */
> +	dev_info(&vdev->dev,
> +		 "device memory buffer withholds %u of %u pages for %u virtqueues\n",
> +		 virtio_dmb_reserved(dmb), dmb->nslots, nvqs);
> +}
> +EXPORT_SYMBOL_GPL(virtio_dmb_note_vqs);
> +
>  /*
>   * Whether the device still has virtqueues.  vqs_list_lock is what protects
>   * that list against a concurrent adder.  No caller here can race one, because
> @@ -1524,5 +1711,9 @@ int virtio_dmb_init(struct virtio_device *vdev)
>  }
>  EXPORT_SYMBOL_GPL(virtio_dmb_init);
>  
> +#if IS_ENABLED(CONFIG_VIRTIO_DMB_KUNIT_TEST)
> +#include "virtio_dmb_test.c"
> +#endif
> +
>  MODULE_DESCRIPTION("Virtio device memory buffer allocator");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/virtio/virtio_dmb.h b/drivers/virtio/virtio_dmb.h
> index 69fbcbb9c2c0..38e4c3ecc9cb 100644
> --- a/drivers/virtio/virtio_dmb.h
> +++ b/drivers/virtio/virtio_dmb.h
> @@ -11,6 +11,7 @@ struct virtio_device;
>  
>  int virtio_dmb_init(struct virtio_device *vdev);
>  void virtio_dmb_destroy(struct virtio_device *vdev);
> +void virtio_dmb_note_vqs(struct virtio_device *vdev, unsigned int nvqs);
>  
>  #else
>  
> @@ -23,6 +24,11 @@ static inline void virtio_dmb_destroy(struct virtio_device *vdev)
>  {
>  }
>  
> +static inline void virtio_dmb_note_vqs(struct virtio_device *vdev,
> +				       unsigned int nvqs)
> +{
> +}
> +
>  #endif /* CONFIG_VIRTIO_DMB */
>  
>  #endif /* _DRIVERS_VIRTIO_VIRTIO_DMB_H */
> diff --git a/drivers/virtio/virtio_dmb_test.c b/drivers/virtio/virtio_dmb_test.c
> new file mode 100644
> index 000000000000..d9dff81a8eb3
> --- /dev/null
> +++ b/drivers/virtio/virtio_dmb_test.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Tests for the geometry of the withheld range, and for what becomes of a
> + * region when a negotiation drops the feature.
> + *
> + * Included by virtio_dmb.c rather than compiled on its own, so that the tests
> + * reach its static functions and its private structure without widening
> + * either into a header for their benefit.
> + *
> + * The geometry cases test a property rather than a value: that whatever the
> + * pool size, the area size and the virtqueue count, the withheld range holds
> + * VIRTIO_MAP_RESERVE_PAGES slots that are contiguous *within one area*.  That
> + * qualifier is the whole point.  An allocation cannot span two areas, so a
> + * range that is merely large enough does not guarantee a chain, and a pool
> + * whose last area is short can withhold a range whose two pieces are each too
> + * small.  A region has to be just above a multiple of the area size to reach
> + * it, which no plausible device offers and so no test on real hardware
> + * exercises.
> + */
> +#include <kunit/test.h>
> +
> +/* Geometry only: virtio_dmb_reserved() reads no more of the structure. */
> +static void dmb_test_shape(struct kunit *test, struct virtio_dmb *dmb,
> +			   unsigned int nslots, unsigned int area_slots,
> +			   unsigned int nvqs)
> +{
> +	KUNIT_ASSERT_TRUE(test, is_power_of_2(area_slots));
> +
> +	dmb->nslots = nslots;
> +	dmb->area_slots = area_slots;
> +	dmb->area_shift = ilog2(area_slots);
> +	dmb->nareas = DIV_ROUND_UP(nslots, area_slots);
> +	dmb->nvqs = nvqs;
> +}
> +
> +static struct virtio_dmb *dmb_test_pool(struct kunit *test)
> +{
> +	struct virtio_dmb *dmb = kunit_kzalloc(test, sizeof(*dmb), GFP_KERNEL);
> +
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmb);
> +
> +	return dmb;
> +}
> +
> +/*
> + * The longest run of withheld slots that lies inside a single area, which is
> + * the largest chain the range can serve.
> + */
> +static unsigned int dmb_test_longest_run(const struct virtio_dmb *dmb,
> +					 unsigned int reserved)
> +{
> +	unsigned int i, best = 0;
> +	unsigned int start;
> +
> +	if (!reserved)
> +		return 0;
> +
> +	start = dmb->nslots - reserved;
> +
> +	for (i = 0; i < dmb->nareas; i++) {
> +		unsigned int base = virtio_dmb_area_base(dmb, i);
> +		unsigned int end = base + virtio_dmb_area_len(dmb, i);
> +		unsigned int lo = max(start, base);
> +
> +		if (end > lo)
> +			best = max(best, end - lo);
> +	}
> +
> +	return best;
> +}
> +
> +static void dmb_test_assert_guarantees(struct kunit *test,
> +				       const struct virtio_dmb *dmb)
> +{
> +	unsigned int reserved = virtio_dmb_reserved(dmb);
> +	unsigned int run;
> +
> +	if (!reserved)
> +		return;
> +
> +	/* One virtqueue at a time can obtain a whole chain. */
> +	run = dmb_test_longest_run(dmb, reserved);
> +	KUNIT_EXPECT_GE_MSG(test, run, VIRTIO_MAP_RESERVE_PAGES,
> +			    "nslots=%u area_slots=%u nareas=%u nvqs=%u reserved=%u",
> +			    dmb->nslots, dmb->area_slots, dmb->nareas,
> +			    dmb->nvqs, reserved);
> +
> +	/* Every virtqueue can obtain one page no running virtqueue can take. */
> +	KUNIT_EXPECT_GE_MSG(test, reserved,
> +			    min(dmb->nvqs, dmb->nslots / 2),
> +			    "nslots=%u nvqs=%u reserved=%u",
> +			    dmb->nslots, dmb->nvqs, reserved);
> +
> +	/* The range never takes more than half the pool, nor all of it. */
> +	KUNIT_EXPECT_LE_MSG(test, reserved, dmb->nslots / 2,
> +			    "nslots=%u nvqs=%u reserved=%u",
> +			    dmb->nslots, dmb->nvqs, reserved);
> +}
> +
> +/*
> + * Every area size the allocator can derive, against pool sizes that put the
> + * last area at every length a straddle needs, and virtqueue counts either
> + * side of a chain's allowance.
> + */
> +static void dmb_test_reserve_geometry(struct kunit *test)
> +{
> +	static const unsigned int area_sizes[] = { 512, 1024, 2048, 4096 };
> +	struct virtio_dmb *dmb = dmb_test_pool(test);
> +	unsigned int a, k, tail, nvqs;
> +
> +	for (a = 0; a < ARRAY_SIZE(area_sizes); a++) {
> +		unsigned int area_slots = area_sizes[a];
> +
> +		for (k = 1; k <= 3; k++) {
> +			for (tail = 0; tail <= 2 * VIRTIO_MAP_RESERVE_PAGES;
> +			     tail++) {
> +				unsigned int nslots = k * area_slots + tail;
> +
> +				for (nvqs = 1; nvqs <= 40; nvqs++) {
> +					dmb_test_shape(test, dmb, nslots,
> +						       area_slots, nvqs);
> +					dmb_test_assert_guarantees(test, dmb);
> +				}
> +			}
> +		}
> +	}
> +}
> +
> +/*
> + * The geometries that showed the guarantee was conditional.  Named so that a
> + * revision that reintroduces the pool-tail bound fails here rather than in
> + * the sweep, where the reason is harder to read off.
> + */
> +static void dmb_test_reserve_straddle(struct kunit *test)
> +{
> +	static const struct {
> +		unsigned int nslots, area_slots, nvqs;
> +	} cases[] = {
> +		{ 528, 512, 3 },	/* last area 16, pieces 18 and 16 */
> +		{ 527, 512, 1 },	/* last area 15, pieces 17 and 15 */
> +		{ 4114, 4096, 7 },	/* last area 18, pieces 20 and 18 */
> +		{ 4114, 1024, 7 },	/* same tail, more areas */
> +		{ 1048600, 512, 17 },	/* last area 24, pieces 24 and 24 */
> +		{ 4097, 4096, 17 },	/* last area 1, but 47 below it: fine */
> +		{ 2100, 512, 7 },	/* last area 52: whole range fits it */
> +	};
> +	struct virtio_dmb *dmb = dmb_test_pool(test);
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cases); i++) {
> +		dmb_test_shape(test, dmb, cases[i].nslots, cases[i].area_slots,
> +			       cases[i].nvqs);
> +		dmb_test_assert_guarantees(test, dmb);
> +	}
> +}
> +
> +/*
> + * The sizing table in Documentation/driver-api/virtio/virtio-dmb.rst states a
> + * withheld count for each of its rows, and a device implementer sizes against
> + * it.  Every row's last area is long enough to hold the range, so the area
> + * term must not change any of them.
> + */
> +static void dmb_test_reserve_documented_sizing(struct kunit *test)
> +{
> +	static const struct {
> +		unsigned int nslots, nvqs, reserved;
> +	} rows[] = {
> +		{ 321, 3, 34 },
> +		{ 1167, 9, 40 },
> +		{ 2295, 17, 48 },
> +		{ 8524, 17, 48 },
> +		{ 17004, 33, 64 },
> +		{ 33964, 65, 96 },
> +		{ 67884, 129, 160 },
> +	};
> +	static const unsigned int area_sizes[] = { 512, 1024, 2048, 4096 };
> +	struct virtio_dmb *dmb = dmb_test_pool(test);
> +	unsigned int i, a;
> +
> +	for (i = 0; i < ARRAY_SIZE(rows); i++) {
> +		for (a = 0; a < ARRAY_SIZE(area_sizes); a++) {
> +			dmb_test_shape(test, dmb, rows[i].nslots,
> +				       area_sizes[a], rows[i].nvqs);
> +
> +			KUNIT_EXPECT_EQ_MSG(test, virtio_dmb_reserved(dmb),
> +					    rows[i].reserved,
> +					    "nslots=%u nvqs=%u area_slots=%u",
> +					    rows[i].nslots, rows[i].nvqs,
> +					    area_sizes[a]);
> +			dmb_test_assert_guarantees(test, dmb);
> +		}
> +	}
> +}
> +
> +/* Inert below the threshold, and before the transport reports a count. */
> +static void dmb_test_reserve_inert(struct kunit *test)
> +{
> +	struct virtio_dmb *dmb = dmb_test_pool(test);
> +	unsigned int nslots;
> +
> +	dmb_test_shape(test, dmb, 4096, 512, 0);
> +	KUNIT_EXPECT_EQ(test, virtio_dmb_reserved(dmb), 0);
> +
> +	for (nslots = 4; nslots < 8 * VIRTIO_MAP_RESERVE_PAGES; nslots++) {
> +		dmb_test_shape(test, dmb, nslots, 512, 3);
> +		KUNIT_EXPECT_EQ_MSG(test, virtio_dmb_reserved(dmb), 0,
> +				    "nslots=%u", nslots);
> +	}
> +
> +	dmb_test_shape(test, dmb, 8 * VIRTIO_MAP_RESERVE_PAGES, 512, 1);
> +	KUNIT_EXPECT_EQ(test, virtio_dmb_reserved(dmb),
> +			VIRTIO_MAP_RESERVE_PAGES);
> +}
> +
> +/*
> + * What virtio_dmb_init() does with state an earlier negotiation left behind
> + * when this one did not accept the feature: releases it, and refuses to
> + * release it under a live virtqueue, which holds kernel addresses inside the
> + * mapping.  The refusal is the only error it returns for a device it is taking
> + * the region away from, so it is the one a caller turns into the FAILED status
> + * bit; releasing it is not an error and sets nothing.  Nothing can reach the
> + * refusal, for the reason the function itself gives, so a test is what covers
> + * it.  Its dev_warn() is expected output.
> + */
> +static void dmb_test_withdrawn_feature(struct kunit *test)
> +{
> +	struct virtio_device *vdev;
> +	const struct virtio_map_ops *prev;
> +	struct virtqueue *vq;
> +	struct virtio_dmb *dmb;
> +
> +	vdev = kunit_kzalloc(test, sizeof(*vdev), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vdev);
> +	vq = kunit_kzalloc(test, sizeof(*vq), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vq);
> +	prev = kunit_kzalloc(test, sizeof(*prev), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, prev);
> +
> +	spin_lock_init(&vdev->vqs_list_lock);
> +	INIT_LIST_HEAD(&vdev->vqs);
> +
> +	/* Nothing installed: nothing to release, and not an error. */
> +	KUNIT_EXPECT_EQ(test, virtio_dmb_init(vdev), 0);
> +
> +	/* Not kunit_kzalloc(): the last call below frees this. */
> +	dmb = kzalloc_obj(*dmb, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dmb);
> +	dmb->prev_map = prev;
> +	vdev->map = &virtio_dmb_map_ops;
> +	vdev->vmap.dmb = dmb;
> +	list_add(&vq->list, &vdev->vqs);
> +
> +	/* Installed, under a virtqueue: refused, and left addressable. */
> +	KUNIT_EXPECT_EQ(test, virtio_dmb_init(vdev), -EBUSY);
> +	KUNIT_EXPECT_PTR_EQ(test, vdev->map, &virtio_dmb_map_ops);
> +	KUNIT_EXPECT_PTR_EQ(test, vdev->vmap.dmb, dmb);
> +
> +	/* The same withdrawal with no virtqueue left: released, and no error. */
> +	list_del(&vq->list);
> +	KUNIT_EXPECT_EQ(test, virtio_dmb_init(vdev), 0);
> +	KUNIT_EXPECT_PTR_EQ(test, vdev->map, prev);
> +}
> +
> +static struct kunit_case virtio_dmb_test_cases[] = {
> +	/* Slow: the sweep is tens of thousands of geometries. */
> +	KUNIT_CASE_SLOW(dmb_test_reserve_geometry),
> +	KUNIT_CASE(dmb_test_reserve_straddle),
> +	KUNIT_CASE(dmb_test_reserve_documented_sizing),
> +	KUNIT_CASE(dmb_test_reserve_inert),
> +	KUNIT_CASE(dmb_test_withdrawn_feature),
> +	{}
> +};
> +
> +static struct kunit_suite virtio_dmb_test_suite = {
> +	.name = "virtio_dmb",
> +	.test_cases = virtio_dmb_test_cases,
> +};
> +
> +kunit_test_suite(virtio_dmb_test_suite);
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index c43c1fc6e843..635ff8012f4c 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -19,6 +19,7 @@
>  #define VIRTIO_PCI_NO_LEGACY
>  #define VIRTIO_RING_NO_LEGACY
>  #include "virtio_pci_common.h"
> +#include "virtio_dmb.h"
>  
>  #define VIRTIO_AVQ_SGS_MAX	4
>  
> @@ -803,8 +804,23 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtqueue *vq;
> -	int rc = vp_find_vqs(vdev, nvqs, vqs, vqs_info, desc);
> +	int rc;
>  
> +	/*
> +	 * Before vp_find_vqs(), so that no virtqueue exists yet: the ring
> +	 * allocations it makes are ordinary claims and cannot land in the
> +	 * range this withholds.
> +	 *
> +	 * nvqs counts the virtqueues the driver asked for.  vp_find_vqs()
> +	 * creates one more when the device offers an administration
> +	 * virtqueue, and that one draws on the guarantee like any other -- its
> +	 * only response to a refusal is a cpu_relax() spin -- so count it here
> +	 * rather than leave it as the one virtqueue without a floor.
> +	 */
> +	virtio_dmb_note_vqs(vdev, nvqs +
> +			    virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ));
> +
> +	rc = vp_find_vqs(vdev, nvqs, vqs, vqs_info, desc);
>  	if (rc)
>  		return rc;
>  
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 641ab07be931..6cd82d418c37 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -527,10 +527,44 @@ static int vring_map_errno(const struct vring_virtqueue *vq)
>  	return -ENOMEM;
>  }
>  
> +/*
> + * Whether this mapping may draw on capacity a bounded map implementation
> + * withholds, and account it against the chain's allowance if so.
> + *
> + * Only while the ring is empty, which is exactly the window in which this
> + * virtqueue has no completion of its own to be woken by: the device cannot
> + * signal a used buffer on a queue with no buffers posted.  Every
> + * virtqueue_add_*() path decrements num_free after its mapping loop, so the
> + * test is true for every mapping of a chain going into an empty ring and
> + * false for every mapping after it, with nothing to keep in step.
> + *
> + * @chain_pages accumulates within one virtqueue_add_*() call and dies with
> + * it.  It is charged whether or not the mapping later fails, and a chain that
> + * fails half way therefore over-counts its own allowance and nothing else, so
> + * no bookkeeping can leak.
> + */
> +static unsigned long vring_map_reserve_attr(const struct vring_virtqueue *vq,
> +					    unsigned int *chain_pages,
> +					    size_t size)
> +{
> +	unsigned int pages = DIV_ROUND_UP(size, PAGE_SIZE);
> +
> +	if (*chain_pages + pages > VIRTIO_MAP_RESERVE_PAGES)
> +		return 0;
> +
> +	if (vq->vq.num_free != vring_num(vq))
> +		return 0;
> +
> +	*chain_pages += pages;
> +
> +	return VIRTIO_MAP_ATTR_RESERVE;
> +}
> +
>  /* Map one sg entry. */
>  static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
>  			    enum dma_data_direction direction, dma_addr_t *addr,
> -			    u32 *len, bool premapped, unsigned long attr)
> +			    u32 *len, bool premapped, unsigned long attr,
> +			    unsigned int *chain_pages)
>  {
>  	if (premapped) {
>  		*addr = sg_dma_address(sg);
> @@ -577,7 +611,9 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
>  	 */
>  	*addr = virtqueue_map_page_attrs(&vq->vq, sg_page(sg),
>  					 sg->offset, sg->length,
> -					 direction, attr);
> +					 direction,
> +					 attr | vring_map_reserve_attr(vq, chain_pages,
> +								       sg->length));
>  
>  	if (vring_mapping_error(vq, *addr))
>  		return vring_map_errno(vq);
> @@ -587,13 +623,15 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
>  
>  static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
>  				   void *cpu_addr, size_t size,
> -				   enum dma_data_direction direction)
> +				   enum dma_data_direction direction,
> +				   unsigned int *chain_pages)
>  {
>  	if (!vq->use_map_api)
>  		return (dma_addr_t)virt_to_phys(cpu_addr);
>  
> -	return virtqueue_map_single_attrs(&vq->vq, cpu_addr,
> -					  size, direction, 0);
> +	return virtqueue_map_single_attrs(&vq->vq, cpu_addr, size, direction,
> +					  vring_map_reserve_attr(vq, chain_pages,
> +								 size));
>  }
>  
>  static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
> @@ -717,6 +755,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  	unsigned int i, n, avail, descs_used, err_idx, sg_count = 0;
>  	/* Total length for in-order */
>  	unsigned int total_in_len = 0;
> +	unsigned int chain_pages = 0;
>  	int head;
>  	bool indirect;
>  	int err;
> @@ -783,7 +822,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  				flags |= VRING_DESC_F_NEXT;
>  
>  			err = vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr,
> -					       &len, premapped, attr);
> +					       &len, premapped, attr,
> +				       &chain_pages);
>  			if (err)
>  				goto unmap_release;
>  
> @@ -804,7 +844,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  				flags |= VRING_DESC_F_NEXT;
>  
>  			err = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr,
> -					       &len, premapped, attr);
> +					       &len, premapped, attr,
> +				       &chain_pages);
>  			if (err)
>  				goto unmap_release;
>  
> @@ -821,7 +862,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
>  		/* Now that the indirect table is filled in, map it. */
>  		dma_addr_t addr = vring_map_single(
>  			vq, desc, total_sg * sizeof(struct vring_desc),
> -			DMA_TO_DEVICE);
> +			DMA_TO_DEVICE,
> +			&chain_pages);
>  		if (vring_mapping_error(vq, addr)) {
>  			err = vring_map_errno(vq);
>  			goto unmap_release;
> @@ -1601,6 +1643,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
>  	unsigned int i, n, err_idx, len, total_in_len = 0;
> +	unsigned int chain_pages = 0;
>  	u16 head;
>  	dma_addr_t addr;
>  
> @@ -1624,7 +1667,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
>  			if (vring_map_one_sg(vq, sg, n < out_sgs ?
>  					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
> -					     &addr, &len, premapped, attr))
> +					     &addr, &len, premapped, attr,
> +				       &chain_pages))
>  				goto unmap_release;
>  
>  			desc[i].flags = cpu_to_le16(n < out_sgs ?
> @@ -1647,7 +1691,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	/* Now that the indirect table is filled in, map it. */
>  	addr = vring_map_single(vq, desc,
>  			total_sg * sizeof(struct vring_packed_desc),
> -			DMA_TO_DEVICE);
> +			DMA_TO_DEVICE,
> +			&chain_pages);
>  	if (vring_mapping_error(vq, addr))
>  		goto unmap_release;
>  
> @@ -1740,6 +1785,7 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
>  	unsigned int i, n, c, descs_used, err_idx, len;
> +	unsigned int chain_pages = 0;
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
>  	int err;
> @@ -1799,7 +1845,8 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
>  
>  			err = vring_map_one_sg(vq, sg, n < out_sgs ?
>  					       DMA_TO_DEVICE : DMA_FROM_DEVICE,
> -					       &addr, &len, premapped, attr);
> +					       &addr, &len, premapped, attr,
> +				       &chain_pages);
>  			if (err)
>  				goto unmap_release;
>  
> @@ -1899,6 +1946,7 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
>  	struct vring_packed_desc *desc;
>  	struct scatterlist *sg;
>  	unsigned int i, n, sg_count, err_idx, total_in_len = 0;
> +	unsigned int chain_pages = 0;
>  	__le16 head_flags, flags;
>  	u16 head, avail_used_flags;
>  	bool avail_wrap_counter;
> @@ -1961,7 +2009,8 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
>  
>  			err = vring_map_one_sg(vq, sg, n < out_sgs ?
>  					       DMA_TO_DEVICE : DMA_FROM_DEVICE,
> -					       &addr, &len, premapped, attr);
> +					       &addr, &len, premapped, attr,
> +				       &chain_pages);
>  			if (err)
>  				goto unmap_release;
>  
> @@ -3880,9 +3929,15 @@ dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
>  					   page, offset, size,
>  					   dir, attrs);
>  
> +	/*
> +	 * Strip the bits virtio owns before the DMA API sees them: it defines
> +	 * DMA_ATTR_* over the same word, and a bit outside that set has no
> +	 * defined meaning there.  A map implementation is the only reader of
> +	 * them.
> +	 */
>  	return dma_map_page_attrs(vring_dma_dev(vq),
>  				  page, offset, size,
> -				  dir, attrs);
> +				  dir, attrs & ~VIRTIO_MAP_ATTR_MASK);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_map_page_attrs);
>  
> @@ -3907,7 +3962,8 @@ void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
>  				      map_handle, size, dir, attrs);
>  	else
>  		dma_unmap_page_attrs(vring_dma_dev(vq), map_handle,
> -				     size, dir, attrs);
> +				     size, dir,
> +				     attrs & ~VIRTIO_MAP_ATTR_MASK);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_unmap_page_attrs);
>  
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index a6780aa85966..a25552862ec4 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_VIRTIO_CONFIG_H
>  
>  #include <linux/err.h>
> +#include <linux/bits.h>
>  #include <linux/bug.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_byteorder.h>
> @@ -219,6 +220,38 @@ struct virtio_map_ops {
>  	size_t (*max_mapping_size)(union virtio_map map);
>  };
>  
> +/*
> + * Pages one virtqueue at a time is guaranteed to be able to map through a map
> + * implementation with a bounded pool, whatever the other virtqueues of the
> + * device have mapped.  Enough for one page-granular descriptor chain at the
> + * default CONFIG_MAX_SKB_FRAGS: a network receive buffer in the non-mergeable
> + * case is MAX_SKB_FRAGS + 2 scatterlist entries plus an indirect table, which
> + * is 20 pages where a page is 4 KiB and MAX_SKB_FRAGS is 17.  A chain larger
> + * than this -- a raised CONFIG_MAX_SKB_FRAGS, or entries spanning more than a
> + * page each -- draws on the reserve for as much of itself as fits and is not
> + * guaranteed.  Neither is a second chain of more than one page concurrent
> + * with the first: what every virtqueue is guaranteed is the single page that
> + * takes its ring from empty to non-empty.  Both hold on any pool of eight
> + * times this many pages or more, which is where an implementation withholds
> + * anything at all; below that there is no range and no guarantee.
> + */
> +#define VIRTIO_MAP_RESERVE_PAGES	32u
> +
> +/*
> + * map_page() attrs bits owned by virtio rather than by the DMA API.
> + * DMA_ATTR_* occupies bits 1 to 13 today; these sit above it, and
> + * virtqueue_map_page_attrs() masks them off before any dma_map_*() call, so
> + * the DMA API never sees one.  The gap is deliberate headroom rather than a
> + * partition: whoever grows either range has to check the other.
> + *
> + * VIRTIO_MAP_ATTR_RESERVE: this mapping is part of the first descriptor chain
> + * a virtqueue is publishing, and an implementation with a bounded pool should
> + * satisfy it from capacity withheld for that purpose if it has no other.
> + * An implementation that ignores the bit behaves exactly as before.
> + */
> +#define VIRTIO_MAP_ATTR_RESERVE		BIT(24)
> +#define VIRTIO_MAP_ATTR_MASK		VIRTIO_MAP_ATTR_RESERVE
> +
>  /* If driver didn't advertise the feature, it will never appear. */
>  void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
>  					 unsigned int fbit);

