Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3A579F3
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163423; cv=none; b=rUGW4Xi1Ino6MwJEE9Ukjk/DtqnwWiGtHhTMqdZXMzNKYWes2piaIus28H8KYsxdx/c2EJGB98WZqyPECPhP41hi5gJaVs6uNwO4fbeDKk7EaynPuITBombt6llL4fJ5t/6xnLzIw7EWPyNe2A9RWkQBu4Gn/713u/yIup6m9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163423; c=relaxed/simple;
	bh=RdIcOgcyiT6r7xyimlOz033BkAjT325a724NR+BTJDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiAKNLnL9UnVVAqyCWeHVBR+LA8l50dJgNd++OX/v6ZFsxC/qD7fst7oa2AQpTMqeVhcZaqIkmO2S2+YJXF4jyutsAmakR85AurpU+JVk+TAl9PGRPAyoJukDjIHhrd4n4QeklQIwPzskV5NYsh0oi+jvy7ONq0uUNnbnGbZzcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOTW6ne2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOTW6ne2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713163420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0FkEixV1SMoS6JyP0TAohi0iz3dd2viGE7qnjR2PVE=;
	b=iOTW6ne2rCX1T3GE1+NnwdToxJP+044Y1Z5N58IYV9h1XcBdZr809/ecxj9Qre28zcvrnW
	5sL+YXxYxpvrIQKtR/JgF2+NZURg6kJiQzjRS5yG0V91IqBn0d12yp2KUCr2TINmCPvSgf
	lkDgvr7X0fh52mrGDXx2kyXsMImbaoE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284--0Q-XL9oMRe-Q8BMkpFeuw-1; Mon, 15 Apr 2024 02:43:37 -0400
X-MC-Unique: -0Q-XL9oMRe-Q8BMkpFeuw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c66a69ec8eso2221208a12.3
        for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 23:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163416; x=1713768216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0FkEixV1SMoS6JyP0TAohi0iz3dd2viGE7qnjR2PVE=;
        b=td+yKtqEIdXNR1ag3GE1P4AuGobQLsgVY0zmdSPc/Ur7h6eh5X7hV24FYOgDzNKk9d
         V5uv5JhNCHbQ7bwgrgesWZ6TOUtE4n621TwjsQt6Vruu1SAxjdIdb1G+9KzEjUumUQXj
         n2R3yfm3J4Uy30DRGt/yU1EErh+9bBIJqcAw8AYyHpp1UFnevucqJzBBHtdt196XMPVs
         OCIepC0N6v2gLAk4xmLhNaBR1/3N2ahchSbm0s6NC3mmnKd+6LOdgXdemWTxl6o6Sbfj
         tnqR3ryaUFLJF0uZlyZx71lVEGbLF+BzkJysHcDZSJPVZgMo+HKJ8KAT/caBeBfZ5tyQ
         oeNw==
X-Gm-Message-State: AOJu0YwkUiYvgabKk7hi2zzShHiXmlwkaGjolkjMWWCROmUg6R0hzVik
	0f8VpymTZMGuVm5Hoi+B9bwlLaUOd4mF7vBVCaVGjVgK0fZxIVWnrMipC3X9QRwc7E1zydxQhWr
	itUIWqkAc7CKdR/uY/PI9FfH/3zZMKvSvxZyY3//Cd9F3/7vLA6WElNaqM9tbC8sQTNwtP9VpuT
	/v+hstkuKfkRJ+hW8wkgcJBjM9ev1+BH9pfrOcO+E=
X-Received: by 2002:a05:6a21:3a48:b0:1a7:88c3:85ed with SMTP id zu8-20020a056a213a4800b001a788c385edmr14550804pzb.1.1713163416526;
        Sun, 14 Apr 2024 23:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUyo+zFu6fYAaRPwm/zOTfDzl7Vl14Ykftwb8RTn2Y4Y7aLacbTxtUkyTSDzmwFgYIej6ULDJqX0cFq2ZnkoE=
X-Received: by 2002:a05:6a21:3a48:b0:1a7:88c3:85ed with SMTP id
 zu8-20020a056a213a4800b001a788c385edmr14550792pzb.1.1713163416259; Sun, 14
 Apr 2024 23:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-4-xuanzhuo@linux.alibaba.com> <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
 <1712900153.3715405-1-xuanzhuo@linux.alibaba.com> <CACGkMEvKC6JpsznW57GgxFBMhmMSk4eCZPvESpew9j5qfp9=RA@mail.gmail.com>
 <1713146919.8867755-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713146919.8867755-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 14:43:24 +0800
Message-ID: <CACGkMEvmaH9NE-5VDBPpZOpAAg4bX39Lf0-iGiYzxdV5JuZWww@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > >
> > > > > Now, we chain the pages of big mode by the page's private variabl=
e.
> > > > > But a subsequent patch aims to make the big mode to support
> > > > > premapped mode. This requires additional space to store the dma a=
ddr.
> > > > >
> > > > > Within the sub-struct that contains the 'private', there is no su=
itable
> > > > > variable for storing the DMA addr.
> > > > >
> > > > >                 struct {        /* Page cache and anonymous pages=
 */
> > > > >                         /**
> > > > >                          * @lru: Pageout list, eg. active_list pr=
otected by
> > > > >                          * lruvec->lru_lock.  Sometimes used as a=
 generic list
> > > > >                          * by the page owner.
> > > > >                          */
> > > > >                         union {
> > > > >                                 struct list_head lru;
> > > > >
> > > > >                                 /* Or, for the Unevictable "LRU l=
ist" slot */
> > > > >                                 struct {
> > > > >                                         /* Always even, to negate=
 PageTail */
> > > > >                                         void *__filler;
> > > > >                                         /* Count page's or folio'=
s mlocks */
> > > > >                                         unsigned int mlock_count;
> > > > >                                 };
> > > > >
> > > > >                                 /* Or, free page */
> > > > >                                 struct list_head buddy_list;
> > > > >                                 struct list_head pcp_list;
> > > > >                         };
> > > > >                         /* See page-flags.h for PAGE_MAPPING_FLAG=
S */
> > > > >                         struct address_space *mapping;
> > > > >                         union {
> > > > >                                 pgoff_t index;          /* Our of=
fset within mapping. */
> > > > >                                 unsigned long share;    /* share =
count for fsdax */
> > > > >                         };
> > > > >                         /**
> > > > >                          * @private: Mapping-private opaque data.
> > > > >                          * Usually used for buffer_heads if PageP=
rivate.
> > > > >                          * Used for swp_entry_t if PageSwapCache.
> > > > >                          * Indicates order in the buddy system if=
 PageBuddy.
> > > > >                          */
> > > > >                         unsigned long private;
> > > > >                 };
> > > > >
> > > > > But within the page pool struct, we have a variable called
> > > > > dma_addr that is appropriate for storing dma addr.
> > > > > And that struct is used by netstack. That works to our advantage.
> > > > >
> > > > >                 struct {        /* page_pool used by netstack */
> > > > >                         /**
> > > > >                          * @pp_magic: magic value to avoid recycl=
ing non
> > > > >                          * page_pool allocated pages.
> > > > >                          */
> > > > >                         unsigned long pp_magic;
> > > > >                         struct page_pool *pp;
> > > > >                         unsigned long _pp_mapping_pad;
> > > > >                         unsigned long dma_addr;
> > > > >                         atomic_long_t pp_ref_count;
> > > > >                 };
> > > > >
> > > > > On the other side, we should use variables from the same sub-stru=
ct.
> > > > > So this patch replaces the "private" with "pp".
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > >
> > > > Instead of doing a customized version of page pool, can we simply
> > > > switch to use page pool for big mode instead? Then we don't need to
> > > > bother the dma stuffs.
> > >
> > >
> > > The page pool needs to do the dma by the DMA APIs.
> > > So we can not use the page pool directly.
> >
> > I found this:
> >
> > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do the DMA
> >                                         * map/unmap
> >
> > It seems to work here?
>
>
> I have studied the page pool mechanism and believe that we cannot use it
> directly. We can make the page pool to bypass the DMA operations.
> This allows us to handle DMA within virtio-net for pages allocated from t=
he page
> pool. Furthermore, we can utilize page pool helpers to associate the DMA =
address
> to the page.
>
> However, the critical issue pertains to unmapping. Ideally, we want to re=
turn
> the mapped pages to the page pool and reuse them. In doing so, we can omi=
t the
> unmapping and remapping steps.
>
> Currently, there's a caveat: when the page pool cache is full, it disconn=
ects
> and releases the pages. When the pool hits its capacity, pages are relinq=
uished
> without a chance for unmapping.

Technically, when ptr_ring is full there could be a fallback, but then
it requires expensive synchronization between producer and consumer.
For virtio-net, it might not be a problem because add/get has been
synchronized. (It might be relaxed in the future, actually we've
already seen a requirement in the past for virito-blk).

> If we were to unmap pages each time before
> returning them to the pool, we would negate the benefits of bypassing the
> mapping and unmapping process altogether.

Yes, but the problem in this approach is that it creates a corner
exception where dma_addr is used outside the page pool.

Maybe for big mode it doesn't matter too much if there's no
performance improvement.

Thanks

>
> Thanks.
>
>
>
> >
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
>

