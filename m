Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6F3BBCE
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170996; cv=none; b=cAQvL39O1e+HnN7OLtcDwaZ9mvEZs6FIZ7Rqtvsw0VBq/cRClv/OjB6XtsfoTu2aABi4AuN1Ra6Nqbj9kx1mejntLaKjhFWTAl0tARQl17GOd1bjkBGWcKIiXQFUSrHcM4yCKB7J+Hd8WBNLfs1ohBL3je8AbiRKKAzrN0afIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170996; c=relaxed/simple;
	bh=lLt5r88o8LAtphS3/PGZVZ6F3+WFfNtfQ3Y6Y+3qncM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=lfTurUcryIe828+sG2wMMQEWNzl3gKlGI1de6+/0GvmsY/B0QtRN3ucoJ7Ah4J36z25oVcocnZFKhuKTrWRs3GXTaojzvz3KoVyeaRpXV7PgKqycAOYTXt7LkJIXmFRwnwNHxCRNdrFfSLMopRjAtjjzu4wtEQQYkJH4fdZpUMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RJdJ/9Br; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RJdJ/9Br"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713170990; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=uMkhS7BsxeL4oglM0pwFdRZ0sutgkDQPGrAjxBhZbGc=;
	b=RJdJ/9Brf1Eodle+w8l5WihnOFSfnlantX8hAc6KFjswVg6s/nd3LMwIj6xo9oEA9e7z+K8HXe+QA3Bf3Ha1gux14QQ11EOMKbJ4Ihs10azxiky/viv4Wxjvs+9UpdIHJowqyifd/ISSwhPWfXqGd4jWUhZVpFt+qXMXVtlC7Qw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4YrqFd_1713170988;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4YrqFd_1713170988)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 16:49:49 +0800
Message-ID: <1713170201.06163-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Mon, 15 Apr 2024 16:36:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
 <1712900153.3715405-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvKC6JpsznW57GgxFBMhmMSk4eCZPvESpew9j5qfp9=RA@mail.gmail.com>
 <1713146919.8867755-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvmaH9NE-5VDBPpZOpAAg4bX39Lf0-iGiYzxdV5JuZWww@mail.gmail.com>
In-Reply-To: <CACGkMEvmaH9NE-5VDBPpZOpAAg4bX39Lf0-iGiYzxdV5JuZWww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 15 Apr 2024 14:43:24 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Apr 15, 2024 at 10:35=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > On Fri, 12 Apr 2024 13:49:12 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > >
> > > > > > Now, we chain the pages of big mode by the page's private varia=
ble.
> > > > > > But a subsequent patch aims to make the big mode to support
> > > > > > premapped mode. This requires additional space to store the dma=
 addr.
> > > > > >
> > > > > > Within the sub-struct that contains the 'private', there is no =
suitable
> > > > > > variable for storing the DMA addr.
> > > > > >
> > > > > >                 struct {        /* Page cache and anonymous pag=
es */
> > > > > >                         /**
> > > > > >                          * @lru: Pageout list, eg. active_list =
protected by
> > > > > >                          * lruvec->lru_lock.  Sometimes used as=
 a generic list
> > > > > >                          * by the page owner.
> > > > > >                          */
> > > > > >                         union {
> > > > > >                                 struct list_head lru;
> > > > > >
> > > > > >                                 /* Or, for the Unevictable "LRU=
 list" slot */
> > > > > >                                 struct {
> > > > > >                                         /* Always even, to nega=
te PageTail */
> > > > > >                                         void *__filler;
> > > > > >                                         /* Count page's or foli=
o's mlocks */
> > > > > >                                         unsigned int mlock_coun=
t;
> > > > > >                                 };
> > > > > >
> > > > > >                                 /* Or, free page */
> > > > > >                                 struct list_head buddy_list;
> > > > > >                                 struct list_head pcp_list;
> > > > > >                         };
> > > > > >                         /* See page-flags.h for PAGE_MAPPING_FL=
AGS */
> > > > > >                         struct address_space *mapping;
> > > > > >                         union {
> > > > > >                                 pgoff_t index;          /* Our =
offset within mapping. */
> > > > > >                                 unsigned long share;    /* shar=
e count for fsdax */
> > > > > >                         };
> > > > > >                         /**
> > > > > >                          * @private: Mapping-private opaque dat=
a.
> > > > > >                          * Usually used for buffer_heads if Pag=
ePrivate.
> > > > > >                          * Used for swp_entry_t if PageSwapCach=
e.
> > > > > >                          * Indicates order in the buddy system =
if PageBuddy.
> > > > > >                          */
> > > > > >                         unsigned long private;
> > > > > >                 };
> > > > > >
> > > > > > But within the page pool struct, we have a variable called
> > > > > > dma_addr that is appropriate for storing dma addr.
> > > > > > And that struct is used by netstack. That works to our advantag=
e.
> > > > > >
> > > > > >                 struct {        /* page_pool used by netstack */
> > > > > >                         /**
> > > > > >                          * @pp_magic: magic value to avoid recy=
cling non
> > > > > >                          * page_pool allocated pages.
> > > > > >                          */
> > > > > >                         unsigned long pp_magic;
> > > > > >                         struct page_pool *pp;
> > > > > >                         unsigned long _pp_mapping_pad;
> > > > > >                         unsigned long dma_addr;
> > > > > >                         atomic_long_t pp_ref_count;
> > > > > >                 };
> > > > > >
> > > > > > On the other side, we should use variables from the same sub-st=
ruct.
> > > > > > So this patch replaces the "private" with "pp".
> > > > > >
> > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > ---
> > > > >
> > > > > Instead of doing a customized version of page pool, can we simply
> > > > > switch to use page pool for big mode instead? Then we don't need =
to
> > > > > bother the dma stuffs.
> > > >
> > > >
> > > > The page pool needs to do the dma by the DMA APIs.
> > > > So we can not use the page pool directly.
> > >
> > > I found this:
> > >
> > > define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do the DMA
> > >                                         * map/unmap
> > >
> > > It seems to work here?
> >
> >
> > I have studied the page pool mechanism and believe that we cannot use it
> > directly. We can make the page pool to bypass the DMA operations.
> > This allows us to handle DMA within virtio-net for pages allocated from=
 the page
> > pool. Furthermore, we can utilize page pool helpers to associate the DM=
A address
> > to the page.
> >
> > However, the critical issue pertains to unmapping. Ideally, we want to =
return
> > the mapped pages to the page pool and reuse them. In doing so, we can o=
mit the
> > unmapping and remapping steps.
> >
> > Currently, there's a caveat: when the page pool cache is full, it disco=
nnects
> > and releases the pages. When the pool hits its capacity, pages are reli=
nquished
> > without a chance for unmapping.
>
> Technically, when ptr_ring is full there could be a fallback, but then
> it requires expensive synchronization between producer and consumer.
> For virtio-net, it might not be a problem because add/get has been
> synchronized. (It might be relaxed in the future, actually we've
> already seen a requirement in the past for virito-blk).

The point is that the page will be released by page pool directly,
we will have no change to unmap that, if we work with page pool.

>
> > If we were to unmap pages each time before
> > returning them to the pool, we would negate the benefits of bypassing t=
he
> > mapping and unmapping process altogether.
>
> Yes, but the problem in this approach is that it creates a corner
> exception where dma_addr is used outside the page pool.

YES. This is a corner exception. We need to introduce this case to the page
pool.

So for introducing the page-pool to virtio-net(not only for big mode),
we may need to push the page-pool to support dma by drivers.

Back to this patch set, I think we should keep the virtio-net to manage
the pages.

What do you think?

Thanks

>
> Maybe for big mode it doesn't matter too much if there's no
> performance improvement.
>
> Thanks
>
> >
> > Thanks.
> >
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > Thanks.
> > > >
> > > >
> > > > >
> > > > > Thanks
> > > > >
> > > >
> > >
> >
>
