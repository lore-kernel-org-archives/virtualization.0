Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9D6A329
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420687; cv=none; b=JMyb+666nbok5TtfXg4clhE0+ZZmJYRQ7UIN53mswxxal2E1MiGeF8wt8EzC+3US8y4mtzwnoReUNIFOJrAHUdQjx9tx8Rk8gqYRCbQMe4rcxHhzynpnaqq6a/lfItlS3nBFk2nW8xcjq97pFhBdagAO5y5cnTj++3e3u26T5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420687; c=relaxed/simple;
	bh=jSDOyoU+Ufb3EoZHi6b/eMQZ//b2/llKBiIbkVZpldQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=irFsfKVLtcIw3y1zQe3fj6mx+WmXSG15rjCFN8geXrkyFBjOHGWHSoLExMbvqrTHqCkt9kj65CFyaqtmtMfCzIfc6fj7FwcZGINVURYrI4i5Dv8TwBOGNT/X7/9w46a5wcwSAq1erXdAa2bdj49O5cY6R8idQr+Vjwec3QyIpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eyGGMBRx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyGGMBRx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713420683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bTyk8H9lbs4UgJmEreKEkQSEUAJlXl9tp1kT54Vykk=;
	b=eyGGMBRxGqFeb9qpjo/rJllO2BbAXOwkgSyOj425W49L/O8HSDrIF/fxwtUIAQW9rrbgpU
	oytJHy8xzOyr49qyr9lh4c7BbwrbKIbqJKGKCqWr0qkWX6pjki33ACtJcUhuWGXrulS9dk
	FD/sk5ptf5SV4S07kgE91Ttqrg9omaI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-yKH6whJ6O2uzpZioCht4Fw-1; Thu, 18 Apr 2024 02:11:22 -0400
X-MC-Unique: yKH6whJ6O2uzpZioCht4Fw-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6eb76c24132so664786a34.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420681; x=1714025481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bTyk8H9lbs4UgJmEreKEkQSEUAJlXl9tp1kT54Vykk=;
        b=JRFPm5XQYIlu4DGe4TNQd+/4yg2qGVMFioEbUVbHaG3G9ll5OXbDPEK8/Rs844t2do
         b/HOgXhGCDpddFOjyJTve6Id0eR6nSvGjkUypgPIzsj0cB1Le1xpGtJtcaPWrgGflfD6
         aklnK27zYTMfL94n3zzzWhReuFh5qNRy/ivp/yPdvTSy/ocAWmGJhPRYAKpnEfQD9g91
         UTjqcsqkWIMwBOmQ6kQX0noehIxUAK9k+5BpYrfUfT8A/VJ1wpTVKNio1Hx9CtA0fI5Q
         wMEVnejrs0VmunsxRKDFPEPuNJm4y7BDUVpXYJnxnmV/G6B0DoKiTYDHsGAcNAcIy1YH
         xuiA==
X-Gm-Message-State: AOJu0YzRf6eePbIJaP7sircvixwZFMnMrXGwBZJ9HEOKzGlhjN1WlO2a
	Q/sj3AxVOsxu741EFlHODjm0G6oz1ZNX4pUtzSBMV4tDQLEVE3TNGTAyyCd6pNCbn4tZmTBEZs9
	c1AbB1mvxiCWdaXoFrODVfHIXb+LrV6WuxpBXaCjeIzaEUOMiciSsMN763YcNxvFOdVhKn0+g9D
	9jzFRbMfcn66yczt6Ht7QjAdlQe8WhIBAcqR8pduM=
X-Received: by 2002:a05:6870:a10d:b0:229:87f6:ee8a with SMTP id m13-20020a056870a10d00b0022987f6ee8amr2082544oae.30.1713420681555;
        Wed, 17 Apr 2024 23:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/aKSHIiMQ4NX9lXWFREqZsIXbcFaERNQbi8Xmb3rVUhJIHh0oBv/suIMx3kplwqHZTIWICb6u4Bl3iFHFt7U=
X-Received: by 2002:a05:6870:a10d:b0:229:87f6:ee8a with SMTP id
 m13-20020a056870a10d00b0022987f6ee8amr2082533oae.30.1713420681310; Wed, 17
 Apr 2024 23:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:11:10 +0800
Message-ID: <CACGkMEuWTpMSQVMvWgp2+wDPtRDuKiqFQdsSEnd9ors+E3iDWw@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, we chain the pages of big mode by the page's private variable.
> But a subsequent patch aims to make the big mode to support
> premapped mode. This requires additional space to store the dma addr.
>
> Within the sub-struct that contains the 'private', there is no suitable
> variable for storing the DMA addr.
>
>                 struct {        /* Page cache and anonymous pages */
>                         /**
>                          * @lru: Pageout list, eg. active_list protected =
by
>                          * lruvec->lru_lock.  Sometimes used as a generic=
 list
>                          * by the page owner.
>                          */
>                         union {
>                                 struct list_head lru;
>
>                                 /* Or, for the Unevictable "LRU list" slo=
t */
>                                 struct {
>                                         /* Always even, to negate PageTai=
l */
>                                         void *__filler;
>                                         /* Count page's or folio's mlocks=
 */
>                                         unsigned int mlock_count;
>                                 };
>
>                                 /* Or, free page */
>                                 struct list_head buddy_list;
>                                 struct list_head pcp_list;
>                         };
>                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
>                         struct address_space *mapping;
>                         union {
>                                 pgoff_t index;          /* Our offset wit=
hin mapping. */
>                                 unsigned long share;    /* share count fo=
r fsdax */
>                         };
>                         /**
>                          * @private: Mapping-private opaque data.
>                          * Usually used for buffer_heads if PagePrivate.
>                          * Used for swp_entry_t if PageSwapCache.
>                          * Indicates order in the buddy system if PageBud=
dy.
>                          */
>                         unsigned long private;
>                 };
>
> But within the page pool struct, we have a variable called
> dma_addr that is appropriate for storing dma addr.
> And that struct is used by netstack. That works to our advantage.
>
>                 struct {        /* page_pool used by netstack */
>                         /**
>                          * @pp_magic: magic value to avoid recycling non
>                          * page_pool allocated pages.
>                          */
>                         unsigned long pp_magic;
>                         struct page_pool *pp;
>                         unsigned long _pp_mapping_pad;
>                         unsigned long dma_addr;
>                         atomic_long_t pp_ref_count;
>                 };
>
> On the other side, we should use variables from the same sub-struct.
> So this patch replaces the "private" with "pp".
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c22d1118a133..4446fb54de6d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -48,6 +48,9 @@ module_param(napi_tx, bool, 0644);
>
>  #define VIRTIO_XDP_FLAG        BIT(0)
>
> +#define page_chain_next(p)     ((struct page *)((p)->pp))
> +#define page_chain_add(p, n)   ((p)->pp =3D (void *)n)
> +
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
>   * at once, the weight is chosen so that the EWMA will be insensitive to=
 short-
> @@ -191,7 +194,7 @@ struct receive_queue {
>
>         struct virtnet_interrupt_coalesce intr_coal;
>
> -       /* Chain pages by the private ptr. */
> +       /* Chain pages by the page's pp struct. */
>         struct page *pages;
>
>         /* Average packet length for mergeable receive buffers. */
> @@ -432,16 +435,16 @@ skb_vnet_common_hdr(struct sk_buff *skb)
>  }
>
>  /*
> - * private is used to chain pages for big packets, put the whole
> - * most recent used list in the beginning for reuse
> + * put the whole most recent used list in the beginning for reuse
>   */

While at this, let's explain the pp is used to chain pages or we can
do it on the definition of page_chain_add().

Others look good.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

