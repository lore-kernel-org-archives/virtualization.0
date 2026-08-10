Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13440372EEF
	for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349234; cv=none; b=DXj6BJhEp/MYU6nud980ltelIzR/RKn/dwuna3hbKygVyIJtCb2oyKh3GLrQf1d8OxtC3Gp2S9HO1BrzTVaVdju6qF2BZoApStw0q5Q34LkDKYglt1Mh/okDUWM9ouNbom8oggXF50ugMrFrmKQxOlg7bmh948T/5sN7ZQKTI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349234; c=relaxed/simple;
	bh=GmjbX1NHkXBLv/FHmi9swAkkunNfGLyNVsBGsQsGvOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jDNVTEnUQ0zNZ7ScOPfzfr4p/h8CAdYtSGHE3ZoF0GE/9REr3PIr6R5G3OtrjePfzFQ7xLZggmrscO8x9a+sOgZSqKhkoAYnwLQCAVOX/geMV5gAycuLCmrRW1uk54qqtm1oml35d3EzK5S9c2kClKpKq62mMJkSu6Gt5ylvX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bdyJlDwK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdyJlDwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786349232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4dFVWyu3xzRnl6oCpTVpkogt182ZU5pdL31lNneQJ8=;
	b=bdyJlDwKRZl3oRBMddrfW2MrQQbW2ebo8OZoi0SOBzXDKw2Zw6O3qZkcRTCEJU80D9L3LM
	3EKRNpqMlEb9KfxcFqusig/vbtF8NvjYsr10Gdma2NRrPR80L8T5pA9fp16n15z4QVIkOC
	IB0gVBkZvhLsMAf71FOEYgxRqZU0vnU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-Xrj0-G0eNX6JfT4TBDrkQw-1; Mon, 10 Aug 2026 04:07:10 -0400
X-MC-Unique: Xrj0-G0eNX6JfT4TBDrkQw-1
X-Mimecast-MFC-AGG-ID: Xrj0-G0eNX6JfT4TBDrkQw_1786349229
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso15308235e9.1
        for <virtualization@lists.linux.dev>; Mon, 10 Aug 2026 01:07:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786349229; x=1786954029;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B4dFVWyu3xzRnl6oCpTVpkogt182ZU5pdL31lNneQJ8=;
        b=dZ3gEAqSRnvhv8HmbppLfXHYBBwzvA7e/mydTwvsIz+gs9mO1cmRp5m5YvG2YS44iz
         /GgGYM7GUAeSLWX5qGMtxuQ+wyf6oZkAAIXymrb2SCUaTgyytj4UNs4sijJ4z6bxWgLQ
         bA1c0xFOIOdxmx5Rm9Hqa5w214d1V6CPSE6tUNQUjbVmo9TbvtIm4+IYJCbjaIOlaT7Q
         8loGgrlkbh+lo5o+E0/X8vm57Xr7bzyT1zdPmBI/SNqe/9fVa8buyLO0V8I8yiYb7I5Y
         iPIqId/4R09A6Ss4eYOL4KMcxInFOGKhdsuJ0aGamNpFnSxueq4Vf50h3Y4BX58fhvFo
         BYzA==
X-Forwarded-Encrypted: i=1; AHgh+RoB+zwvK7ZrNin6bqxkmO/89M7++O8KWNHrqoxfbpW0ns5aesFYNKymeM7n2pkD+baoVRcgYrhllrxmD+rHpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHtnY+yGg5IJoj3d5HssEtViOPGS4K4okgWwiECINOwoS9n0T/
	+K+rZl1okL+tZYLzqlGH2jgjO7sIQYr/8kRpLyKlWlyJ8Gd/7gSWX+Qjde/t7Cd5NUlVKmMJCCA
	00Ipng5PRQbRwl0nfjVJcByfQ/ZDYgDUPr6N2wPaM+Pas4TFHoIXf1PcihiPj9cxffvS2
X-Gm-Gg: AR+sD10Gk4Aq0WPbw5fkTgf+r+UfxCtxVrZA3zyzvSwG4SSqwIqa1jVJIyarIFeOPvJ
	o9G7PWZBbBRkWo1gj6etZpB+3T9Ww178NkU9GGB/YsKQRCygm8xOELy4draBpapqb8OLo1tp9fu
	3O71Sp0eWfbTCcV1Z5lUYp6lAM41Z9xB3TLNJP08GKLLvZZC+4PN+/QIRMM00Nw2fYHJrUNNoHB
	BFpDnnymNAXxk2gbt4I/T88PsqZyy0S1BnWtu7v4FR78lb4t3YIHHef9/LTut1+uud3YIeDGGS9
	E3znFX1TZrDGSbTx8gWAFb3s91U2Zr79AGaJbHMZ0oWAT2MjnlWgKzu/lqmA8rmxNYrzJvK+8Xz
	+oqUqhzo+w4K1hnjoiHgfGg==
X-Received: by 2002:a05:600c:1912:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499619928f5mr202686385e9.10.1786349228421;
        Mon, 10 Aug 2026 01:07:08 -0700 (PDT)
X-Received: by 2002:a05:600c:1912:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-499619928f5mr202685355e9.10.1786349227606;
        Mon, 10 Aug 2026 01:07:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-39-98.inter.net.il. [80.230.39.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea27ef0sm314197285e9.9.2026.08.10.01.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 01:07:07 -0700 (PDT)
Date: Mon, 10 Aug 2026 04:07:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>
Cc: Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 06/12] virtio: add a device memory buffer region
 allocator
Message-ID: <20260810040540-mutt-send-email-mst@kernel.org>
References: <20260809182010.32931-1-graf@amazon.com>
 <20260809182010.32931-7-graf@amazon.com>
 <20260809181455-mutt-send-email-mst@kernel.org>
 <6f34275a-6320-4be1-b8e4-b96aa3289344@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6f34275a-6320-4be1-b8e4-b96aa3289344@amazon.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FlpgIm8gBcrUx_rUm5R3FvLuPeYXxl-3EQKfs5gUUks_1786349229
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2026 at 07:57:13AM +0000, Graf (AWS), Alexander wrote:
> 
> On 10.08.26 00:38, Michael S. Tsirkin wrote:
> > On Sun, Aug 09, 2026 at 06:20:04PM +0000, Alexander Graf wrote:
> >> In preparation to support VIRTIO_F_DMB, create a mechanism to allocate
> >> and map memory from the Device Memory Buffer (DMB). The DMB is a shared
> >> memory region a device exposes and owns. A device that negotiates the
> >> feature expects its virtqueues and all the buffers we hand it to live in
> >> that region, and every address we publish to it is a byte offset into
> >> the region.
> >>
> >> Add virtio_dmb_init(), which locates the region by the shared memory id
> >> the device reports and builds a page-granular allocator over it, and
> >> virtio_dmb_destroy() to tear that down. Add virtio_dmb_map_ops, a struct
> >> virtio_map_ops implementation that hands out allocations from that
> >> allocator as region offsets: alloc() places a virtqueue area in the
> >> region, map_page() copies a buffer that lives elsewhere into it and
> >> copies it back on unmap. The map operations reach that allocator through
> >> a new dmb member of union virtio_map.
> >>
> >> The shared memory id is transport specific, so add a get_dmb_shm_id()
> >> callback to struct virtio_config_ops for a transport to report it. A
> >> transport that does not implement it must not accept VIRTIO_F_DMB. Add
> >> CONFIG_VIRTIO_DMB to enable this support. It defaults to y, and a kernel
> >> that will never meet such a device can turn it off to leave the
> >> allocator and its bookkeeping out.
> >>
> >> Link: https://lore.kernel.org/virtio-comment/20260804161202.38619-1-graf@amazon.com/
> >> Assisted-by: Kiro:claude-opus-5 checkpatch sparse
> >> Signed-off-by: Alexander Graf <graf@amazon.com>
> >
> >
> >
> >> ---
> >>   drivers/virtio/Kconfig        |   15 +
> >>   drivers/virtio/Makefile       |    3 +-
> >>   drivers/virtio/virtio_dmb.c   | 1317 +++++++++++++++++++++++++++++++++
> >>   drivers/virtio/virtio_dmb.h   |   28 +
> >>   include/linux/virtio.h        |    3 +
> >>   include/linux/virtio_config.h |    8 +
> >
> > Really >1000 lines to implement a virtio specific allocator?
> >
> > Can't we start e.g. with gen alloc and maybe xarray if you
> > need some metadata?
> >
> >
> > I guess virtio sync is annoying, it gets handle + offset is that the
> > issue? We can fix them though. Or let's just not support them. There
> > were there for premapped originally but now it uses page pool.
> >
> > Maybe I will send a patch to drop sync completely.
> 
> 
> I started off with gen_alloc. And then over time it slowly morphed into 
> what you're seeing here when I ran into issues with multi-queue 
> allocations (split the buffer by VQ pair so that we don't run into lock 
> contention) and zero-copy vsock transfers (by keeping DMB buffers 
> statically allocated).
> 
> I agree that it's a bit much for the initial post. How about I revert 
> back to the gen_alloc variant and we look at the optimizations as 
> follow-up? Since everything is guest driven, we can play with them as 
> much as we like in future improvements.
> 
> 
> Alex

Indeed. Or improve gen alloc)

-- 
MST

