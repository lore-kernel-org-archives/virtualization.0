Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1973A1DB
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171425; cv=none; b=k8iRxDI0FSCjOo0YAMWViSbJBesQewbEbOYW5JDoB1iU4/biSGSZmjlEUzo1hLBpSj8vU12uZVU38SEhAHyM5CQGiWBLrkpUNdRhdmUPCSuR6sZYGmjeSkyh+j095XZe2ZAOAKZK78gDnYhO9CJZdDdr12E1LHtEbAOTj3qhKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171425; c=relaxed/simple;
	bh=DuoiT32hrREpQjwv70vqfHXSsE1kJ8DEdQVs2+NvCzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emlpOYTuXeflQ7Q7RJh2hrnGqKpELjY59bbkYk19U10SreMhw+Zz1bc97CaGsFx1jzqV15bYYt9HDeoKAFHNSuARMQ5XjixX4OAQSMCc1IcvZOdtepirZgLKcbsMGp11853kZgcjq2sntY9uj+XTAM7xgPlybop6G1Dml7FsTTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOWdz2Qa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOWdz2Qa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713171422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGL5zcF64qi2X9MvQMDZmoC7CATicE6vSII/9tNteR0=;
	b=SOWdz2QaNe1wPVM12wUWr25WcUrc8QbfyG/Lmg+PhqqVK/W0EZVoHz1UtgH2DH5q8WcS1h
	hGnwr7e1jHnDARgWxm9d2uTy4IUQoqfknDeFoiMKKcw3TjSvY7r9+ZjYWVFFp+ldVM5JKL
	1tKVAXEbziYy0oraUdWBzcDaBLtDWpw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-kLgrnaGwNiW5ljBQQllirA-1; Mon, 15 Apr 2024 04:56:58 -0400
X-MC-Unique: kLgrnaGwNiW5ljBQQllirA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a2fdf6eb3bso2800988a91.1
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 01:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713171417; x=1713776217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGL5zcF64qi2X9MvQMDZmoC7CATicE6vSII/9tNteR0=;
        b=IkTDNoLkhrzhkMv7BgSZowOknsLhcVx/gD8wA//+mMYIBoiELIf+XUVr7iLwtlqbbx
         xTHOfwmYtBNzOz92j0oQnXEQXo3hXbqlgSrHKJ9gdbdPDTzaJz6sVTY5+RHhMSqnS3Xi
         1nmVUB3NrYaput/7KqEWR/PwkM6cyTTShvkC2CobFGVSs5bUwo4Jjem9dBi+tjBBuk9d
         xegveV8Wps3NZRRXvXWj00VtCnRRL0ZGnjlqSZttQ1UCK/SgGsjKQEDbzADhG7GCymQo
         b59BvhSegpnKOg0yPVbVpBWqBEHwv3QvqkTs6OvkCc3lVjuxQeH+Eo8sGmA6zCGQIOOC
         BATQ==
X-Gm-Message-State: AOJu0Yxi72PX8145rO2RSLuUo110s5be3cXUMRVujMLunUxqWUt/zDms
	1uk97cfx/OWqcdgunwhxtPiUPTzOzrv/ygReiRt0FxCgW8fQpy/28+xJUjbrzDTEYvKNC30PRkc
	iZi+BkmH22RSdkEJXl32By0GhnoFn1CESqdD9ANoRtFW3w79Shi3cPd3JJlME+RJi/PVC8/vkZT
	xoU92eBAxq3qAsaBJu7XR4LbR1ixsytjVW+P4ahm8=
X-Received: by 2002:a17:90a:3ee6:b0:2a4:9c64:2a50 with SMTP id k93-20020a17090a3ee600b002a49c642a50mr6197422pjc.45.1713171417304;
        Mon, 15 Apr 2024 01:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1ycXvOOkXzcLvZ/UiRzQEVe5y2DFBsHwkgPYGN3FIgytNECKEcsc78aAvriOycxG1X1yDU1eJto5H8B28XAc=
X-Received: by 2002:a17:90a:3ee6:b0:2a4:9c64:2a50 with SMTP id
 k93-20020a17090a3ee600b002a49c642a50mr6197413pjc.45.1713171416970; Mon, 15
 Apr 2024 01:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-4-xuanzhuo@linux.alibaba.com> <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
 <1712900153.3715405-1-xuanzhuo@linux.alibaba.com> <CACGkMEvKC6JpsznW57GgxFBMhmMSk4eCZPvESpew9j5qfp9=RA@mail.gmail.com>
 <1713146919.8867755-1-xuanzhuo@linux.alibaba.com> <CACGkMEvmaH9NE-5VDBPpZOpAAg4bX39Lf0-iGiYzxdV5JuZWww@mail.gmail.com>
 <1713170201.06163-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713170201.06163-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 16:56:45 +0800
Message-ID: <CACGkMEvsXN+7HpeirxzR2qek_znHp8GtjiT+8hmt3tHHM9Zbgg@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@li=
nux.alibaba.com> wrote:
> > > > > > >
> > > > > > > Now, we chain the pages of big mode by the page's private var=
iable.
> > > > > > > But a subsequent patch aims to make the big mode to support
> > > > > > > premapped mode. This requires additional space to store the d=
ma addr.
> > > > > > >
> > > > > > > Within the sub-struct that contains the 'private', there is n=
o suitable
> > > > > > > variable for storing the DMA addr.
> > > > > > >
> > > > > > >                 struct {        /* Page cache and anonymous p=
ages */
> > > > > > >                         /**
> > > > > > >                          * @lru: Pageout list, eg. active_lis=
t protected by
> > > > > > >                          * lruvec->lru_lock.  Sometimes used =
as a generic list
> > > > > > >                          * by the page owner.
> > > > > > >                          */
> > > > > > >                         union {
> > > > > > >                                 struct list_head lru;
> > > > > > >
> > > > > > >                                 /* Or, for the Unevictable "L=
RU list" slot */
> > > > > > >                                 struct {
> > > > > > >                                         /* Always even, to ne=
gate PageTail */
> > > > > > >                                         void *__filler;
> > > > > > >                                         /* Count page's or fo=
lio's mlocks */
> > > > > > >                                         unsigned int mlock_co=
unt;
> > > > > > >                                 };
> > > > > > >
> > > > > > >                                 /* Or, free page */
> > > > > > >                                 struct list_head buddy_list;
> > > > > > >                                 struct list_head pcp_list;
> > > > > > >                         };
> > > > > > >                         /* See page-flags.h for PAGE_MAPPING_=
FLAGS */
> > > > > > >                         struct address_space *mapping;
> > > > > > >                         union {
> > > > > > >                                 pgoff_t index;          /* Ou=
r offset within mapping. */
> > > > > > >                                 unsigned long share;    /* sh=
are count for fsdax */
> > > > > > >                         };
> > > > > > >                         /**
> > > > > > >                          * @private: Mapping-private opaque d=
ata.
> > > > > > >                          * Usually used for buffer_heads if P=
agePrivate.
> > > > > > >                          * Used for swp_entry_t if PageSwapCa=
che.
> > > > > > >                          * Indicates order in the buddy syste=
m if PageBuddy.
> > > > > > >                          */
> > > > > > >                         unsigned long private;
> > > > > > >                 };
> > > > > > >
> > > > > > > But within the page pool struct, we have a variable called
> > > > > > > dma_addr that is appropriate for storing dma addr.
> > > > > > > And that struct is used by netstack. That works to our advant=
age.
> > > > > > >
> > > > > > >                 struct {        /* page_pool used by netstack=
 */
> > > > > > >                         /**
> > > > > > >                          * @pp_magic: magic value to avoid re=
cycling non
> > > > > > >                          * page_pool allocated pages.
> > > > > > >                          */
> > > > > > >                         unsigned long pp_magic;
> > > > > > >                         struct page_pool *pp;
> > > > > > >                         unsigned long _pp_mapping_pad;
> > > > > > >                         unsigned long dma_addr;
> > > > > > >                         atomic_long_t pp_ref_count;
> > > > > > >                 };
> > > > > > >
> > > > > > > On the other side, we should use variables from the same sub-=
struct.
> > > > > > > So this patch replaces the "private" with "pp".
> > > > > > >
> > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > ---
> > > > > >
> > > > > > Instead of doing a customized version of page pool, can we simp=
ly
> > > > > > switch to use page pool for big mode instead? Then we don't nee=
d to
> > > > > > bother the dma stuffs.
> > > > >
> > > > >
> > > > > The page pool needs to do the dma by the DMA APIs.
> > > > > So we can not use the page pool directly.
> > > >
> > > > I found this:
> > > >
> > > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do the DM=
A
> > > >                                         * map/unmap
> > > >
> > > > It seems to work here?
> > >
> > >
> > > I have studied the page pool mechanism and believe that we cannot use=
 it
> > > directly. We can make the page pool to bypass the DMA operations.
> > > This allows us to handle DMA within virtio-net for pages allocated fr=
om the page
> > > pool. Furthermore, we can utilize page pool helpers to associate the =
DMA address
> > > to the page.
> > >
> > > However, the critical issue pertains to unmapping. Ideally, we want t=
o return
> > > the mapped pages to the page pool and reuse them. In doing so, we can=
 omit the
> > > unmapping and remapping steps.
> > >
> > > Currently, there's a caveat: when the page pool cache is full, it dis=
connects
> > > and releases the pages. When the pool hits its capacity, pages are re=
linquished
> > > without a chance for unmapping.
> >
> > Technically, when ptr_ring is full there could be a fallback, but then
> > it requires expensive synchronization between producer and consumer.
> > For virtio-net, it might not be a problem because add/get has been
> > synchronized. (It might be relaxed in the future, actually we've
> > already seen a requirement in the past for virito-blk).
>
> The point is that the page will be released by page pool directly,
> we will have no change to unmap that, if we work with page pool.

I mean if we have a fallback, there would be no need to release these
pages but put them into a link list.

>
> >
> > > If we were to unmap pages each time before
> > > returning them to the pool, we would negate the benefits of bypassing=
 the
> > > mapping and unmapping process altogether.
> >
> > Yes, but the problem in this approach is that it creates a corner
> > exception where dma_addr is used outside the page pool.
>
> YES. This is a corner exception. We need to introduce this case to the pa=
ge
> pool.
>
> So for introducing the page-pool to virtio-net(not only for big mode),
> we may need to push the page-pool to support dma by drivers.

Adding Jesper for some comments.

>
> Back to this patch set, I think we should keep the virtio-net to manage
> the pages.
>
> What do you think?

I might be wrong, but I think if we need to either

1) seek a way to manage the pages by yourself but not touching page
pool metadata (or Jesper is fine with this)
2) optimize the unmap for page pool

or even

3) just do dma_unmap before returning the page back to the page pool,
we don't get all the benefits of page pool but we end up with simple
codes (no fallback for premapping).

Thanks


>
> Thanks
>
> >
> > Maybe for big mode it doesn't matter too much if there's no
> > performance improvement.
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > >
> > > >
> > >
> >
>

