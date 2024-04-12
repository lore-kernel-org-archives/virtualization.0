Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BF175B7
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900350; cv=none; b=NHfJesLr1FJZmpp3xsuXQsAJ9liRBOARwrIWPXRCc/karZaBkQccLez59TA70xVL+hr2rzWjLSWq++J/J8fy3Odhg7gB/w5uYFwZH+ho9WHL1Nw7RuGurYZym730kViKYPXuFx55x7+1M0sFI8WhNJ/r+5tad0quoPQaIo+0Yy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900350; c=relaxed/simple;
	bh=sHysvnVMxlqsL4kzrdtdl23rm4dkCKjBVzEkCM7uiqg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=iZLMJyv3JklZFI0nxwhBTAEte4AXjJJF4Zjm6iT4UoPRnCogC3SKL7FQyiIrFXVeGImujOBbc01ieIeZw/rNkTozU/Do8rs9SStYljZElaXdDVaQ1aD0ejvxrtjOFSzKK5Cru5nclseyi0PsmVTCIjPyiE8xOtInAfLEz4L7SpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VYMJtFmM; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VYMJtFmM"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712900345; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=bvFOQnV+LKlRw05I3Ndd3EmaIDJ4aEn27omjImefSRc=;
	b=VYMJtFmMBaCqlaG7NkuAEbOMGL5Sa0XDPQx6rGujlKgjoadQQO1rBwQhdiZk5rZ661mvGBxgO4QZ+LkNhZfCxqsXwWFkerE98a9VnbPR3i/E+hlcUaKSPxnqyDjY8wcAma8bBEeiKH+Ja7zKBWXXWxBajGFWMEqREt0HWYMrVI0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W4NB4CD_1712900343;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W4NB4CD_1712900343)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 13:39:04 +0800
Message-ID: <1712900153.3715405-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
Date: Fri, 12 Apr 2024 13:35:53 +0800
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
In-Reply-To: <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> >
> > Now, we chain the pages of big mode by the page's private variable.
> > But a subsequent patch aims to make the big mode to support
> > premapped mode. This requires additional space to store the dma addr.
> >
> > Within the sub-struct that contains the 'private', there is no suitable
> > variable for storing the DMA addr.
> >
> >                 struct {        /* Page cache and anonymous pages */
> >                         /**
> >                          * @lru: Pageout list, eg. active_list protecte=
d by
> >                          * lruvec->lru_lock.  Sometimes used as a gener=
ic list
> >                          * by the page owner.
> >                          */
> >                         union {
> >                                 struct list_head lru;
> >
> >                                 /* Or, for the Unevictable "LRU list" s=
lot */
> >                                 struct {
> >                                         /* Always even, to negate PageT=
ail */
> >                                         void *__filler;
> >                                         /* Count page's or folio's mloc=
ks */
> >                                         unsigned int mlock_count;
> >                                 };
> >
> >                                 /* Or, free page */
> >                                 struct list_head buddy_list;
> >                                 struct list_head pcp_list;
> >                         };
> >                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
> >                         struct address_space *mapping;
> >                         union {
> >                                 pgoff_t index;          /* Our offset w=
ithin mapping. */
> >                                 unsigned long share;    /* share count =
for fsdax */
> >                         };
> >                         /**
> >                          * @private: Mapping-private opaque data.
> >                          * Usually used for buffer_heads if PagePrivate.
> >                          * Used for swp_entry_t if PageSwapCache.
> >                          * Indicates order in the buddy system if PageB=
uddy.
> >                          */
> >                         unsigned long private;
> >                 };
> >
> > But within the page pool struct, we have a variable called
> > dma_addr that is appropriate for storing dma addr.
> > And that struct is used by netstack. That works to our advantage.
> >
> >                 struct {        /* page_pool used by netstack */
> >                         /**
> >                          * @pp_magic: magic value to avoid recycling non
> >                          * page_pool allocated pages.
> >                          */
> >                         unsigned long pp_magic;
> >                         struct page_pool *pp;
> >                         unsigned long _pp_mapping_pad;
> >                         unsigned long dma_addr;
> >                         atomic_long_t pp_ref_count;
> >                 };
> >
> > On the other side, we should use variables from the same sub-struct.
> > So this patch replaces the "private" with "pp".
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
>
> Instead of doing a customized version of page pool, can we simply
> switch to use page pool for big mode instead? Then we don't need to
> bother the dma stuffs.


The page pool needs to do the dma by the DMA APIs.
So we can not use the page pool directly.

Thanks.


>
> Thanks
>
