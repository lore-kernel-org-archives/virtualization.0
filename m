Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6517BA5
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729945; cv=none; b=UfcbLhEQTUk4SPX1pn/zKsvFggG4a/DHl1em968EdriHN3bXf7uPQefdiRnM4XmbW7G3rjd1qsb20AQDdk0kk40csX3WhrV7rudI9YJdyHaRN03abhghHWiELfh3tBJKP7tqtMhey3yP1F7LV2SacdVKwvvw5RQRuhYRjyA5ryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729945; c=relaxed/simple;
	bh=qPj8e6KZW3zeA36w4AxrE/xPrzHxWnvF2KWgrG8NvJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZr0MV46SnCmkv8tFa6J6sQIlEN7g1JQiqamJGVGGv8yaQtKkEoLk7UOV4Ourdc0zWdgGfJpdmr5fziCz8zXDMHKeCupzMxUazJeuAX0OnLTuctXjYc6Ta9bKQm0LRsrIDpHfs47d/lFJQVfj1aFrQsxBnf1dI4ayGS/S8PEUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MmhGZ71z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmhGZ71z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724729943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nwuiNsPkSnhT0tsh3FyfKFgKWrXEnm1+cpuDpPB7TA=;
	b=MmhGZ71zYgjEO1IWr47FFAcCXa8YyIBfHM2U0QswPEXeS8JjntuIy3T2xS3DQaFmXR62Nj
	rB6pFctFF5eaIojA4QE59BTuUpj6bTb1D8MrzohcZ2pya6wOyZIW1WJV67lRp/5hLviDp/
	NAmoWaAOgAujDIxJpxTtrGMga6b2MrQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-75muxVLAOtynHdeHOpZ8jw-1; Mon, 26 Aug 2024 23:38:59 -0400
X-MC-Unique: 75muxVLAOtynHdeHOpZ8jw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d45800a8f3so4835919a91.1
        for <virtualization@lists.linux.dev>; Mon, 26 Aug 2024 20:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724729938; x=1725334738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nwuiNsPkSnhT0tsh3FyfKFgKWrXEnm1+cpuDpPB7TA=;
        b=I0BGnXTrlFqmpwuz7/hjnPrqZzOSHEnL9atODMRrssd4ZkKnhVKjNsg4+R2DE103P9
         upwO9MYS9gadUc6+sx3GUTz72dVFL8I6/z2hJ6XsdeSATzoZRNsjMkIeAJwcThtgNyOM
         3WJK+QBFv9vF7Voo6NbZAlzk5eoTN6uyLC/dZTN+tlOpzUn7Qf2HyLwD62wCpuAoMpCK
         YeMu2xbzNBCApwJi17iPgewAnmfVI8mCdumAB7y3CjAjv1Zfw5NZajVJV+OCJrHndZCy
         O0qypnQ+9DOP+ShLHZ03fJsLs/tPlXRrA7FVa302eC/Q+ruxWbKTCD7wxELuH/o97Jks
         Fx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtjiG1lh13cwZ+edEUavRqljTih5etJIvXZDcgjTCk0gs4LA+FpA26G87GEBR6uAOksGRF380IsndxXnK1PQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPz9SqsPVPWXkQdD8pYQmAgt916psIaoPj0dQiv71FglgpZfKP
	mGIuoSEdxUiM5Bh2eoeSsfAvfeUag3fKIKARZJKpCBQfrJL9+Vn+2PXF+bLMr+OXWK90e/MFRrP
	z5p9Tnu74IRlnhcuEnPR4Tkl7vBSoWcWLtNcz38yDO5GH53fm/PrOcwH//13/woKaiNcLU0yYna
	1p2IwGqOi/SxOQtSLw2aFJdRhLwvG6DcDO03skWeo=
X-Received: by 2002:a17:90a:4a11:b0:2c9:75fd:298a with SMTP id 98e67ed59e1d1-2d646d73335mr10836231a91.42.1724729938615;
        Mon, 26 Aug 2024 20:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3gpy8wEWdb9GgnKaHjzJAi3gjXq5w5NRmexeWNXsx4l2cNzihUWLogPuBTVomsVnEHLCJ8XI0yYkI1PqW/jI=
X-Received: by 2002:a17:90a:4a11:b0:2c9:75fd:298a with SMTP id
 98e67ed59e1d1-2d646d73335mr10836217a91.42.1724729938068; Mon, 26 Aug 2024
 20:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820071913.68004-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 11:38:45 +0800
Message-ID: <CACGkMEsJ2sckV5S1nGF+MrTgScVTTuwv6PHuLZARusJsFpf58g@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix overflow inside virtnet_rq_alloc
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:19=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> leads to regression on VM with the sysctl value of:
>
> - net.core.high_order_alloc_disable=3D1
>
> which could see reliable crashes or scp failure (scp a file 100M in size
> to VM):
>
> The issue is that the virtnet_rq_dma takes up 16 bytes at the beginning
> of a new frag. When the frag size is larger than PAGE_SIZE,
> everything is fine. However, if the frag is only one page and the
> total size of the buffer and virtnet_rq_dma is larger than one page, an
> overflow may occur. In this case, if an overflow is possible, I adjust
> the buffer size. If net.core.high_order_alloc_disable=3D1, the maximum
> buffer size is 4096 - 16. If net.core.high_order_alloc_disable=3D0, only
> the first buffer of the frag is affected.

I wonder instead of trying to make use of headroom, would it be
simpler if we allocate dedicated arrays of virtnet_rq_dma=EF=BC=9F

Btw, I see it has a need_sync, I wonder if it can help for performance
or not? If not, any reason to keep that?

>
> Fixes: f9dac92ba908 ("virtio_ring: enable premapped mode whatever use_dma=
_api")
> Reported-by: "Si-Wei Liu" <si-wei.liu@oracle.com>
> Closes: http://lore.kernel.org/all/8b20cc28-45a9-4643-8e87-ba164a540c0a@o=
racle.com
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index c6af18948092..e5286a6da863 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -918,9 +918,6 @@ static void *virtnet_rq_alloc(struct receive_queue *r=
q, u32 size, gfp_t gfp)
>         void *buf, *head;
>         dma_addr_t addr;
>
> -       if (unlikely(!skb_page_frag_refill(size, alloc_frag, gfp)))
> -               return NULL;
> -
>         head =3D page_address(alloc_frag->page);
>
>         dma =3D head;
> @@ -2421,6 +2418,9 @@ static int add_recvbuf_small(struct virtnet_info *v=
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
> @@ -2521,6 +2521,12 @@ static int add_recvbuf_mergeable(struct virtnet_in=
fo *vi,
>          */
>         len =3D get_mergeable_buf_len(rq, &rq->mrg_avg_pkt_len, room);
>
> +       if (unlikely(!skb_page_frag_refill(len + room, alloc_frag, gfp)))
> +               return -ENOMEM;
> +
> +       if (!alloc_frag->offset && len + room + sizeof(struct virtnet_rq_=
dma) > alloc_frag->size)
> +               len -=3D sizeof(struct virtnet_rq_dma);
> +
>         buf =3D virtnet_rq_alloc(rq, len + room, gfp);
>         if (unlikely(!buf))
>                 return -ENOMEM;
> --
> 2.32.0.3.g01195cf9f

Thanks

>

