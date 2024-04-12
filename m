Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B371BC4C
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900971; cv=none; b=n75ViTZ5LgLyoBafknjCDzmBNNez0+KsgSnxtllmgMeuU7Jjr0x7BUpPemmiodeok8GEuBKvTLRNJK3dmVyfiZQMt9LCX6sfnLmogf5TC+JFAhoFuRgWS8XDGhI9AtzwOfTLcMZHzbEUoH8ZWI7CWhyDobFqZt8BXcGh+ZowbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900971; c=relaxed/simple;
	bh=MxGmMWmSVSkaCPjlFYjuNejuLduyr3Of8opSkW9n3Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ax82iMYK2fTeGXFZT7BxUXunNEmh4IoG6tIvBEwtHP/mB+Uv5ehv+nPtV62QtZ2MTzGYcsChFbhZPKCZn3evynTVw4s7UyD7PBIhcsUXPxq3/5zCrzhI7abouZwJdnELdxIARQ7kJ24ihFy+Q+uPYWzs+FXUsFhXSq3ixYSe4+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MZZZdBDM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZZZdBDM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712900966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42h6EUBNEa5RNiLHCZYTOwlWF2yMg6+N/yR4RjFq5UE=;
	b=MZZZdBDM/HenLtYLHsk5g2AOMqZ2QFFjdzKw5ZkyXIyMvwGPpaoN2CTai8eCdx3uf3Z14e
	J8UMscvVY20jbJ+mwck+nFjBuPlOYZNg1BBkIITsCmk3YBhxSHkGTTO4pXV5TQJYFSqieo
	A6xjRQBCv8Xor1kT7ZFWGqyiByH6U7c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-YHQRBG3QPt2XOibi91PIew-1; Fri, 12 Apr 2024 01:49:25 -0400
X-MC-Unique: YHQRBG3QPt2XOibi91PIew-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5e4a072ce28so562509a12.0
        for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 22:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712900964; x=1713505764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42h6EUBNEa5RNiLHCZYTOwlWF2yMg6+N/yR4RjFq5UE=;
        b=lUmP/MoulOIkUBEqteXPhxawc+EERePCS2Vj8vC3bOZv00yCz1SZ/owzWOGEFj1qzV
         wfl4/pe9jJkyItwrPzeNq5r+F0Blj0tojIhQ4z6jhbDKD51uJBLCVtpG2pKWH602c69W
         tgJF0+madSQHu6TlSxpgrgDMH50hUM2hW9u8iy2zzSX2nh0Z2TzKLFyVQSvkQreYF1V8
         mrCJLeaGo/AHoezguySuq8VX5OT4c9ink8CqJFQs1z+VQx7VvN863KgIUR+5/eIrNzLf
         SJZrPF1eR3A3i3K6D2j0cj82dbbvImJi+rUFraSdAUiKKlLMUlgwLHrsxCJnGoKQ6lJR
         QuNw==
X-Gm-Message-State: AOJu0YxWstKYlfVMdxJP1AtiQzqDH0UkGZtDQ3i9pPuso05NLtv8YK3Y
	8vrNvprUapYalwx8TlgT0lI95tGrA8NvuDTM1XXNHCBGdTMjgcJTlFO0DyqxZp9MNaxbg4vGiXS
	n8Rkrw+DZojT3z3CQpAPI1JpM7rqRz1RYNMjbSFJhQvVpmWZRwfzl86Wy4vfANlUfv9h4VZBDJV
	YioUpsE7POpMPOxk++he6ZQo/GPtkgZek45vWsFhA=
X-Received: by 2002:a05:6a20:550a:b0:1a9:4343:765f with SMTP id ko10-20020a056a20550a00b001a94343765fmr1995396pzb.23.1712900964283;
        Thu, 11 Apr 2024 22:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUpDzMeQrzX/DTOLr+fvUdhwDir5bUUkQ7frRcm8uC2c0oNJ/e89gkZZIOS80zxLcxMhnO3Ff/B2Fjh8VNiKI=
X-Received: by 2002:a05:6a20:550a:b0:1a9:4343:765f with SMTP id
 ko10-20020a056a20550a00b001a94343765fmr1995389pzb.23.1712900963995; Thu, 11
 Apr 2024 22:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com>
 <20240411025127.51945-4-xuanzhuo@linux.alibaba.com> <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
 <1712900153.3715405-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1712900153.3715405-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 13:49:12 +0800
Message-ID: <CACGkMEvKC6JpsznW57GgxFBMhmMSk4eCZPvESpew9j5qfp9=RA@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:39=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 12 Apr 2024 12:47:55 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alib=
aba.com> wrote:
> > >
> > > Now, we chain the pages of big mode by the page's private variable.
> > > But a subsequent patch aims to make the big mode to support
> > > premapped mode. This requires additional space to store the dma addr.
> > >
> > > Within the sub-struct that contains the 'private', there is no suitab=
le
> > > variable for storing the DMA addr.
> > >
> > >                 struct {        /* Page cache and anonymous pages */
> > >                         /**
> > >                          * @lru: Pageout list, eg. active_list protec=
ted by
> > >                          * lruvec->lru_lock.  Sometimes used as a gen=
eric list
> > >                          * by the page owner.
> > >                          */
> > >                         union {
> > >                                 struct list_head lru;
> > >
> > >                                 /* Or, for the Unevictable "LRU list"=
 slot */
> > >                                 struct {
> > >                                         /* Always even, to negate Pag=
eTail */
> > >                                         void *__filler;
> > >                                         /* Count page's or folio's ml=
ocks */
> > >                                         unsigned int mlock_count;
> > >                                 };
> > >
> > >                                 /* Or, free page */
> > >                                 struct list_head buddy_list;
> > >                                 struct list_head pcp_list;
> > >                         };
> > >                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
> > >                         struct address_space *mapping;
> > >                         union {
> > >                                 pgoff_t index;          /* Our offset=
 within mapping. */
> > >                                 unsigned long share;    /* share coun=
t for fsdax */
> > >                         };
> > >                         /**
> > >                          * @private: Mapping-private opaque data.
> > >                          * Usually used for buffer_heads if PagePriva=
te.
> > >                          * Used for swp_entry_t if PageSwapCache.
> > >                          * Indicates order in the buddy system if Pag=
eBuddy.
> > >                          */
> > >                         unsigned long private;
> > >                 };
> > >
> > > But within the page pool struct, we have a variable called
> > > dma_addr that is appropriate for storing dma addr.
> > > And that struct is used by netstack. That works to our advantage.
> > >
> > >                 struct {        /* page_pool used by netstack */
> > >                         /**
> > >                          * @pp_magic: magic value to avoid recycling =
non
> > >                          * page_pool allocated pages.
> > >                          */
> > >                         unsigned long pp_magic;
> > >                         struct page_pool *pp;
> > >                         unsigned long _pp_mapping_pad;
> > >                         unsigned long dma_addr;
> > >                         atomic_long_t pp_ref_count;
> > >                 };
> > >
> > > On the other side, we should use variables from the same sub-struct.
> > > So this patch replaces the "private" with "pp".
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> >
> > Instead of doing a customized version of page pool, can we simply
> > switch to use page pool for big mode instead? Then we don't need to
> > bother the dma stuffs.
>
>
> The page pool needs to do the dma by the DMA APIs.
> So we can not use the page pool directly.

I found this:

define PP_FLAG_DMA_MAP         BIT(0) /* Should page_pool do the DMA
                                        * map/unmap

It seems to work here?

Thanks

>
> Thanks.
>
>
> >
> > Thanks
> >
>

