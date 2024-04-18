Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55D054776
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413729; cv=none; b=Tfhd0SchFfFb1kMbJCg3gE2u6Ge3O4iROOt3O8tHQSlywDzxynW3/aIxq/NAxj4oORf8inGrvmX5pMGJxsn0KF10X1BCrswReJSEeo81Q5UrCFp5sZbr5e88fkfB4rES5STzfrhyQ7GayA3CzSZRBkK7drNy/PSopJJtH5nzVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413729; c=relaxed/simple;
	bh=BzJPOZ8Gc24VB44AxytHG8AqxpAOpHyv6kYI7e0toq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZ3tFLASEKyr5X0+ebwwK4sS9bKWaLOFI2Tofjv64wGCuW1vuIlb+BJhugaaqi71L3uHl4B7l7jYp+VybmabyJ6CMMUSPWEambP+zwqSFWnFMlV6geOaMMRXt4mafqjFL0OaNk4Bz+CUlUc2yrI93Q2AAGq3e0LXKgZTEovj+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dp6zhy5s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dp6zhy5s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713413725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7d6QfYuYCTBh4c1O8qPFg919EK1uJUbhVxqwoPYbcmA=;
	b=dp6zhy5siorYcHMwwyWSc7M/VGVCtzm10xQFO7hajCHfkK9b9KcLVGgyF4QRAdXXfa4VwE
	pA0gTPf0PK9xUpT7HMKXnEmTx6ECWaIzbNdlTZozYN35nLoRAC5MLCatNE2woj5wiMNFIZ
	uuK8j6Yc1aIC9pZ4naaddB5bbsIa7Zs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-fT7F5Wt8P8Oah9eCj6x73Q-1; Thu, 18 Apr 2024 00:15:22 -0400
X-MC-Unique: fT7F5Wt8P8Oah9eCj6x73Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ece7b7b44fso1099844b3a.0
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 21:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713413721; x=1714018521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d6QfYuYCTBh4c1O8qPFg919EK1uJUbhVxqwoPYbcmA=;
        b=B+/TSY7qhDSESB/xwycezm0nShhXFCtBZF1O4SaYjygoeMPnIixm39MR14Q6hWCtee
         gkz0hz+T23nXlidCxq8MXDFZGzjaDnsXs/GDUKK/CfursRHdLsDYYHPo/QrQ7AHDGC11
         zihMAOFPb2hEyc41SUQKDKm+EE0WXuc1Cv2Fdvb6Wz08hsuIP+A4+w4glRAjxJyPhbT/
         UctJIWIph/C95t4bhvHZFYZY0qN+ftmOyfgM0Xz28F6J2WVnGA9l+OKqXXUwhZ7oJNKX
         c1H2DExKpEkjcQ494ln1MdOScY2IBRIuPFivNebfuYReAgOF8f9hOa+KSpwV6m9pqmy3
         q87Q==
X-Gm-Message-State: AOJu0YwjMjR/ZgP4pY5gp5df4HDsUH3bByJCZJHFInpEkQq7HBq1D0fH
	JIZlriK/ck6LezYo1ABZEj7JNwL2Mgy5j1k8a3hcKepiGlseSv7OCfBP7C3jvvNxabzSm4ulNXn
	rWT/coP2M1YzGAmXLYN7GK+kwp3UbpdP9RCKlAMsEFBPr64PPruVsNsipNofDuZ8BOsmYuZX5Ba
	te4jf0ofq0qrUl/BpypwEJYI1Uh35T59KSw14Kzy4=
X-Received: by 2002:a05:6a00:190a:b0:6ea:f3fb:26fe with SMTP id y10-20020a056a00190a00b006eaf3fb26femr1789779pfi.12.1713413720955;
        Wed, 17 Apr 2024 21:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyKmiSwK78X1PVfbpvE1isGpq4UHhjuvEyZwB650DXkgos4UIR6LmEsGJ2VtZPGepAvwaTO90KhOyJ9hTS/jo=
X-Received: by 2002:a05:6a00:190a:b0:6ea:f3fb:26fe with SMTP id
 y10-20020a056a00190a00b006eaf3fb26femr1789748pfi.12.1713413720490; Wed, 17
 Apr 2024 21:15:20 -0700 (PDT)
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
 <1713170201.06163-2-xuanzhuo@linux.alibaba.com> <CACGkMEvsXN+7HpeirxzR2qek_znHp8GtjiT+8hmt3tHHM9Zbgg@mail.gmail.com>
 <1713171554.2423792-1-xuanzhuo@linux.alibaba.com> <CACGkMEuK0VkqtNfZ1BUw+SW=gdasEegTMfufS-47NV4bCh3Seg@mail.gmail.com>
 <1713317444.7698638-1-xuanzhuo@linux.alibaba.com> <CACGkMEvjwXpF_mLR3H8ZW9PUE+3spcxKMQV1VvUARb0-Lt7NKQ@mail.gmail.com>
 <1713342055.436048-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1713342055.436048-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 12:15:09 +0800
Message-ID: <CACGkMEubSGs7WNwXBM49uDQTjPNeeFnoFHxidkAv8ixi1MPjww@mail.gmail.com>
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

On Wed, Apr 17, 2024 at 4:45=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 17 Apr 2024 12:08:10 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Apr 17, 2024 at 9:38=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Tue, 16 Apr 2024 11:24:53 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Mon, Apr 15, 2024 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Mon, 15 Apr 2024 16:56:45 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Mon, Apr 15, 2024 at 4:50=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhu=
o@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > > > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuan=
zhuo@linux.alibaba.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasow=
ang@redhat.com> wrote:
> > > > > > > > > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo =
<xuanzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Now, we chain the pages of big mode by the page's=
 private variable.
> > > > > > > > > > > > > But a subsequent patch aims to make the big mode =
to support
> > > > > > > > > > > > > premapped mode. This requires additional space to=
 store the dma addr.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Within the sub-struct that contains the 'private'=
, there is no suitable
> > > > > > > > > > > > > variable for storing the DMA addr.
> > > > > > > > > > > > >
> > > > > > > > > > > > >                 struct {        /* Page cache and=
 anonymous pages */
> > > > > > > > > > > > >                         /**
> > > > > > > > > > > > >                          * @lru: Pageout list, eg=
. active_list protected by
> > > > > > > > > > > > >                          * lruvec->lru_lock.  Som=
etimes used as a generic list
> > > > > > > > > > > > >                          * by the page owner.
> > > > > > > > > > > > >                          */
> > > > > > > > > > > > >                         union {
> > > > > > > > > > > > >                                 struct list_head =
lru;
> > > > > > > > > > > > >
> > > > > > > > > > > > >                                 /* Or, for the Un=
evictable "LRU list" slot */
> > > > > > > > > > > > >                                 struct {
> > > > > > > > > > > > >                                         /* Always=
 even, to negate PageTail */
> > > > > > > > > > > > >                                         void *__f=
iller;
> > > > > > > > > > > > >                                         /* Count =
page's or folio's mlocks */
> > > > > > > > > > > > >                                         unsigned =
int mlock_count;
> > > > > > > > > > > > >                                 };
> > > > > > > > > > > > >
> > > > > > > > > > > > >                                 /* Or, free page =
*/
> > > > > > > > > > > > >                                 struct list_head =
buddy_list;
> > > > > > > > > > > > >                                 struct list_head =
pcp_list;
> > > > > > > > > > > > >                         };
> > > > > > > > > > > > >                         /* See page-flags.h for P=
AGE_MAPPING_FLAGS */
> > > > > > > > > > > > >                         struct address_space *map=
ping;
> > > > > > > > > > > > >                         union {
> > > > > > > > > > > > >                                 pgoff_t index;   =
       /* Our offset within mapping. */
> > > > > > > > > > > > >                                 unsigned long sha=
re;    /* share count for fsdax */
> > > > > > > > > > > > >                         };
> > > > > > > > > > > > >                         /**
> > > > > > > > > > > > >                          * @private: Mapping-priv=
ate opaque data.
> > > > > > > > > > > > >                          * Usually used for buffe=
r_heads if PagePrivate.
> > > > > > > > > > > > >                          * Used for swp_entry_t i=
f PageSwapCache.
> > > > > > > > > > > > >                          * Indicates order in the=
 buddy system if PageBuddy.
> > > > > > > > > > > > >                          */
> > > > > > > > > > > > >                         unsigned long private;
> > > > > > > > > > > > >                 };
> > > > > > > > > > > > >
> > > > > > > > > > > > > But within the page pool struct, we have a variab=
le called
> > > > > > > > > > > > > dma_addr that is appropriate for storing dma addr=
.
> > > > > > > > > > > > > And that struct is used by netstack. That works t=
o our advantage.
> > > > > > > > > > > > >
> > > > > > > > > > > > >                 struct {        /* page_pool used=
 by netstack */
> > > > > > > > > > > > >                         /**
> > > > > > > > > > > > >                          * @pp_magic: magic value=
 to avoid recycling non
> > > > > > > > > > > > >                          * page_pool allocated pa=
ges.
> > > > > > > > > > > > >                          */
> > > > > > > > > > > > >                         unsigned long pp_magic;
> > > > > > > > > > > > >                         struct page_pool *pp;
> > > > > > > > > > > > >                         unsigned long _pp_mapping=
_pad;
> > > > > > > > > > > > >                         unsigned long dma_addr;
> > > > > > > > > > > > >                         atomic_long_t pp_ref_coun=
t;
> > > > > > > > > > > > >                 };
> > > > > > > > > > > > >
> > > > > > > > > > > > > On the other side, we should use variables from t=
he same sub-struct.
> > > > > > > > > > > > > So this patch replaces the "private" with "pp".
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.=
com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > Instead of doing a customized version of page pool,=
 can we simply
> > > > > > > > > > > > switch to use page pool for big mode instead? Then =
we don't need to
> > > > > > > > > > > > bother the dma stuffs.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > The page pool needs to do the dma by the DMA APIs.
> > > > > > > > > > > So we can not use the page pool directly.
> > > > > > > > > >
> > > > > > > > > > I found this:
> > > > > > > > > >
> > > > > > > > > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_po=
ol do the DMA
> > > > > > > > > >                                         * map/unmap
> > > > > > > > > >
> > > > > > > > > > It seems to work here?
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > I have studied the page pool mechanism and believe that w=
e cannot use it
> > > > > > > > > directly. We can make the page pool to bypass the DMA ope=
rations.
> > > > > > > > > This allows us to handle DMA within virtio-net for pages =
allocated from the page
> > > > > > > > > pool. Furthermore, we can utilize page pool helpers to as=
sociate the DMA address
> > > > > > > > > to the page.
> > > > > > > > >
> > > > > > > > > However, the critical issue pertains to unmapping. Ideall=
y, we want to return
> > > > > > > > > the mapped pages to the page pool and reuse them. In doin=
g so, we can omit the
> > > > > > > > > unmapping and remapping steps.
> > > > > > > > >
> > > > > > > > > Currently, there's a caveat: when the page pool cache is =
full, it disconnects
> > > > > > > > > and releases the pages. When the pool hits its capacity, =
pages are relinquished
> > > > > > > > > without a chance for unmapping.
> > > > > > > >
> > > > > > > > Technically, when ptr_ring is full there could be a fallbac=
k, but then
> > > > > > > > it requires expensive synchronization between producer and =
consumer.
> > > > > > > > For virtio-net, it might not be a problem because add/get h=
as been
> > > > > > > > synchronized. (It might be relaxed in the future, actually =
we've
> > > > > > > > already seen a requirement in the past for virito-blk).
> > > > > > >
> > > > > > > The point is that the page will be released by page pool dire=
ctly,
> > > > > > > we will have no change to unmap that, if we work with page po=
ol.
> > > > > >
> > > > > > I mean if we have a fallback, there would be no need to release=
 these
> > > > > > pages but put them into a link list.
> > > > >
> > > > >
> > > > > What fallback?
> > > >
> > > > https://lore.kernel.org/netdev/1519607771-20613-1-git-send-email-ms=
t@redhat.com/
> > > >
> > > > >
> > > > > If we put the pages to the link list, why we use the page pool?
> > > >
> > > > The size of the cache and ptr_ring needs to be fixed.
> > > >
> > > > Again, as explained above, it needs more benchmarks and looks like =
a
> > > > separate topic.
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > If we were to unmap pages each time before
> > > > > > > > > returning them to the pool, we would negate the benefits =
of bypassing the
> > > > > > > > > mapping and unmapping process altogether.
> > > > > > > >
> > > > > > > > Yes, but the problem in this approach is that it creates a =
corner
> > > > > > > > exception where dma_addr is used outside the page pool.
> > > > > > >
> > > > > > > YES. This is a corner exception. We need to introduce this ca=
se to the page
> > > > > > > pool.
> > > > > > >
> > > > > > > So for introducing the page-pool to virtio-net(not only for b=
ig mode),
> > > > > > > we may need to push the page-pool to support dma by drivers.
> > > > > >
> > > > > > Adding Jesper for some comments.
> > > > > >
> > > > > > >
> > > > > > > Back to this patch set, I think we should keep the virtio-net=
 to manage
> > > > > > > the pages.
> > > > > > >
> > > > > > > What do you think?
> > > > > >
> > > > > > I might be wrong, but I think if we need to either
> > > > > >
> > > > > > 1) seek a way to manage the pages by yourself but not touching =
page
> > > > > > pool metadata (or Jesper is fine with this)
> > > > >
> > > > > Do you mean working with page pool or not?
> > > > >
> > > >
> > > > I meant if Jesper is fine with reusing page pool metadata like this=
 patch.
> > > >
> > > > > If we manage the pages by self(no page pool), we do not care the =
metadata is for
> > > > > page pool or not. We just use the space of pages like the "privat=
e".
> > > >
> > > > That's also fine.
> > > >
> > > > >
> > > > >
> > > > > > 2) optimize the unmap for page pool
> > > > > >
> > > > > > or even
> > > > > >
> > > > > > 3) just do dma_unmap before returning the page back to the page=
 pool,
> > > > > > we don't get all the benefits of page pool but we end up with s=
imple
> > > > > > codes (no fallback for premapping).
> > > > >
> > > > > I am ok for this.
> > > >
> > > > Right, we just need to make sure there's no performance regression,
> > > > then it would be fine.
> > > >
> > > > I see for example mana did this as well.
> > >
> > > I think we should not use page pool directly now,
> > > because the mana does not need a space to store the dma address.
> > > We need to store the dma address for unmapping.
> > >
> > > If we use page pool without PP_FLAG_DMA_MAP, then store the dma addre=
ss by
> > > page.dma_addr, I think that is not safe.
> >
> > Jesper, could you comment on this?
> >
> > >
> > > I think the way of this patch set is fine.
> >
> > So it reuses page pool structure in the page structure for another use =
case.
> >
> > > We just use the
> > > space of the page whatever it is page pool or not to store
> > > the link and dma address.
> >
> > Probably because we've already "abused" page->private. I would leave
> > it for other maintainers to decide.
>
> If we do not want to use the elements of the page directly,
> the page pool is a good way.
>

Rethink this, I think that the approach of this series should be fine.
It should be sufficient for virtio-net to guarantee that those pages
are not used by the page pool.

I will continue the review.

Thanks

