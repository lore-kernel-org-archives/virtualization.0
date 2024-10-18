Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D34185B68
	for <virtualization@lists.linux.dev>; Fri, 18 Oct 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237318; cv=none; b=ckdCrhmnAo7lCW8buP7QfSI5QdMxtqUQnVr1KOuEPoIqglLfb/xEKzYZz572xDkP6ffqE2xmtyWR/dpeFGqJlKM2wDHUez5EbLvAr5ssyfM+8LqVS4OfC7sg5n7Z57SKnGTQM0nCsGqO0HMnq00l6RoPuyQT8aiW0H4LhzewYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237318; c=relaxed/simple;
	bh=i1xZRJBWgrpcH0aJgf1ljaX4fd4iy2zjehzzIdw9nqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVWf5pDHRMnRCRoCvlVglHOLbCCwpWU479S49jSgLsa8d3m8xef8fGpr6XES+0Tt2awX4j4LTESYSTrOpNB7BfiWPxfjUWNoQVQMVldWcR0kdT+TCEfNJo/G77P2vbt8vnl5DOZQ9J+jC5+TxSN7yWtoJkKLY4u/kBeOF7IcjkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cif0s2NA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cif0s2NA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729237315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgpoLb3anAR7m1dEnE3KC1LOh39cWkIASarOjrYla5E=;
	b=cif0s2NA5c5Vpp7xdHLWmxAMUWYoMZ3tmDBzw3jYXBC3ig2SAHME7pajw6eBQl2jLsz+2p
	nHKsuDzN2zFMs6nEttN7dISe1wc9mmqzRJNyz4N+wB89MB/FNwRLtZuTYzTg0/CYG4VaS0
	rDtxAYOzfyfznji/7r7/AfflEqwQiZ0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-fU02iSV5P4eGrV6rlUiE-w-1; Fri, 18 Oct 2024 03:41:54 -0400
X-MC-Unique: fU02iSV5P4eGrV6rlUiE-w-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7eaa7b24162so2129472a12.1
        for <virtualization@lists.linux.dev>; Fri, 18 Oct 2024 00:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237313; x=1729842113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgpoLb3anAR7m1dEnE3KC1LOh39cWkIASarOjrYla5E=;
        b=bQXQzEe32bZzPaxzxr/llWnbkpQLrnaP2TNNulk0UJKMa7/gEt31s43jK9mlK5zNbS
         ymJtDuXeul4a4aegj/WNuzh8rhmOuYIa4GOvUl2rxCzROWdluUsTp30dWZLNHkcQ1oXK
         MV52TAPAT0qCgVuIq0JLG0g5rxrBca6J+oHAYnj2UDq8fXxpeGmyERbiwPLGn+kjfl5O
         Ik7jdTACvdzwNrEmqE5mthdZUIHUBchu/DHKDhpwacbO9/BQxIy0zISo9cYUKNiMj+aF
         OXdw2gdTqYZWiTyUgJTRfUzHqydWj5f7ff6DO0mEJ61TYWZ+28OMxn59XpefbRoopzRi
         oJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9dQ7VHZxx1/YLnMrlYOCc3LBzxOUoUFJz9iNmIJkoCDUOV00pmJSNolLHLaLyy1JQr3CYCGKhqUUltVxMPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGssqkwEmIX2Yo4VB+cjVDjUZ65UpLVw9nZsK7rJefC4r+ZKCP
	fF/TyHGUXMimIzSd1VkXsJ+M7wQjUBmWT2EQyUmhMuOg8QQbPeeBaVEi2iB0aAy1LO+L2lOjJc4
	hWSLl6uT4GKDknofGRfocNvtJLYEyYgUrcF5bIghAGZB/CwDSrSOXmAteVyS1fbOAuyPGRr2S6P
	OpC6XGcn9XoPBER/745QG216DRYrZABVHE5cjP0hw=
X-Received: by 2002:a05:6a20:e617:b0:1d9:d0e:34a4 with SMTP id adf61e73a8af0-1d92c49b114mr2097915637.7.1729237313556;
        Fri, 18 Oct 2024 00:41:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2pcYYDzB9NJqpSY9ypJC2vuIgkUiPOmbEfkKe0zQbvgC/1Xv6oG624NMDoIMTA3kawRXeTZohst4+ygDUY34=
X-Received: by 2002:a05:6a20:e617:b0:1d9:d0e:34a4 with SMTP id
 adf61e73a8af0-1d92c49b114mr2097887637.7.1729237313086; Fri, 18 Oct 2024
 00:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241014031234.7659-1-xuanzhuo@linux.alibaba.com> <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241014031234.7659-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 15:41:41 +0800
Message-ID: <CACGkMEv-TYVqjP3GYx_4SmWRGMtYDFZY3s3QpV3nkgXNXhk7kQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> When the frag just got a page, then may lead to regression on VM.
> Specially if the sysctl net.core.high_order_alloc_disable value is 1,
> then the frag always get a page when do refill.
>
> Which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
>
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur.
>
> Here, when the frag size is not enough, we reduce the buffer len to fix
> this problem.
>
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma=
_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Though this may fix the problem and we need it now, I would like to
have some tweaks in the future. Basically because of the security
implication for sharing driver metadata with the device (most IOMMU
can only do protection at the granule at the page). So we may end up
with device-triggerable behaviour. For safety, we should use driver
private memory for DMA metadata.

> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f8131f92a392..59a99bbaf852 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -926,9 +926,6 @@ static void *virtnet_rq_alloc(struct receive_queue *r=
q, u32 size, gfp_t gfp)
>         void *buf, *head;
>         dma_addr_t addr;
>
> -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -               return NULL;
> -
>         head =3D page_address(alloc_frag->page);
>
>         if (rq->do_dma) {
> @@ -2423,6 +2420,9 @@ static int add_recvbuf_small(struct virtnet_info *v=
i, struct receive_queue *rq,
>         len =3D SKB_DATA_ALIGN(len) +
>               SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> +       if (unlikely(!skb_page_frag_refill(len, &rq->alloc_frag, gfp)))
> +               return -ENOMEM;
> +
>         buf =3D virtnet_rq_alloc(rq, len, gfp);
>         if (unlikely(!buf))
>                 return -ENOMEM;
> @@ -2525,6 +2525,12 @@ static int add_recvbuf_mergeable(struct virtnet_in=
fo *vi,
>          */
>         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>
> +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> +               return -ENOMEM;

This makes me think of another question, how could we guarantee len +
room is less or equal to PAGE_SIZE. Especially considering we need
extra head and tailroom for XDP? If we can't it is a bug:

"""
/**
 * skb_page_frag_refill - check that a page_frag contains enough room
 * @sz: minimum size of the fragment we want to get
 * @pfrag: pointer to page_frag
 * @gfp: priority for memory allocation
 *
 * Note: While this allocator tries to use high order pages, there is
 * no guarantee that allocations succeed. Therefore, @sz MUST be
 * less or equal than PAGE_SIZE.
 */
"""

> +
> +       if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_=
dma) > alloc_frag->size)
> +               len -=3D sizeof(struct virtnet_rq_dma);

Any reason we need to check alloc_frag->offset?

> +
>         buf =3D virtnet_rq_alloc(rq, len + room, gfp);

Btw, as pointed out in previous review, we should have a consistent API:

1) hide the alloc_frag like virtnet_rq_alloc()

or

2) pass the alloc_frag to virtnet_rq_alloc()

>         if (unlikely(!buf))
>                 return -ENOMEM;
> --
> 2.32.0.3.g01195cf9f
>

Thanks

