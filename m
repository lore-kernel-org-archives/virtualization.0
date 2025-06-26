Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9031465B4
	for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905260; cv=none; b=H474epFW3GJoxRwPHe1KQurSmcgqdKidN0BWPNjAsRm6JRKxfjz/61GazJBAsD5aEFpXTzUo9jGQjrt9T72fRsJwiCf/X6p/xFkhNdYRSj27pW60hUnJDvpjPZwiH3U6AWx19tSTuWWW5ivy51T+abASiGBVsfDJOG0GvH5UCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905260; c=relaxed/simple;
	bh=Ywnfk5CtunwDSKI5ePQke6zvKrlORy5MiO0skNTlXoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilkzLu1FAO9XeMnHZvuBNciLSf+fUoR9NU2XniX+0SgIZdRwMb42sQ8WUzgYogYdcm5+xEi0qKZUUVzBt2QaLQx1urQ/5dKF/m1JuUmM6xqLzrd/ycBswGH3d3FXV4DjJb1TB9S1QPKRzebjWBnO0dRv0ax58uVBwLDnfd5eBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLG1K6g+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLG1K6g+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750905257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT8CI7GYn/0UQ0nLPl5n5hA5UBnWvrLiTRc8GBQHDvw=;
	b=JLG1K6g+r2O3+iQYnyichwjSTXIAks7C8XSwkFUNBGQqNDurzHucsJ8cvTX6BHn4MkFblS
	WAmompLUz2b8jQFODZFRR2yFGJF88J+FRxQ5facSpZfUoyT6LsWyMVed5ozod9Q2UWc4/o
	vOYF5pfYiQdZQYRfYX+Fqhi2AbcTSfM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-ZwfbyEjZOIuuo9_uQsjK0g-1; Wed, 25 Jun 2025 22:34:15 -0400
X-MC-Unique: ZwfbyEjZOIuuo9_uQsjK0g-1
X-Mimecast-MFC-AGG-ID: ZwfbyEjZOIuuo9_uQsjK0g_1750905255
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so704589a91.2
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 19:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905255; x=1751510055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT8CI7GYn/0UQ0nLPl5n5hA5UBnWvrLiTRc8GBQHDvw=;
        b=qynSs2wKc5FIE7jeCbG3L2O91mNbWYz82mRfeGH2618VtlFJQB4V/zTkL1odRFUpCw
         7YRDphIwyt84ZHtv/jzFpLyfuOsq5IyyggYGt/wXQSNiAfdxbCtRcfVOXWFwBMnK3f4X
         fn8hmDtUTOZ7oPUSjzK6OuG81SWPnhvXfVFDQl9xlCu17M3IY9/z9rfia6dktVWaHonK
         Eyo4hewkRdVH++gXrtnTgq6XXMShggTviE7KpJNWj4GAJGJchv9unUR7iSJH0j5fAr9W
         C68ABH42L14Fa5uq4csJ/oiOjyQ87NhkVp6PHtJoyJ7SWWaFnUX5Kv6TpMrFMQ2fO266
         rxWw==
X-Forwarded-Encrypted: i=1; AJvYcCXn7i3jjjZDhtIjmd9fx9fNR7rxKWwbuGCz4mXvnW7XrqYNECugTumWDmKS08MghFj7t07aJtuNTdby3HbUYg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFfOw6MbtRE6AIUo6NwXVD2m3ws3lZLUzTHVL2m/8LRPW+O2I2
	1IMNHEfTn0+8IUQ2BUOO8748Ge8LKwGdWcJNOc8D2NVZnb2y4dYDP9tBmmNQ/fmzXkX6Qg+fWG+
	Q+R3UTvnlKnrBwgfHVcCvx8sT69RqKmo3I0T3fCIH+itFMNBNKPaj1GnbJOg9GnUBswOwsb2+q1
	ZWq62ekfana9mXWjEM+XY9MfEaEIssfyD3KsX3yn9+HFc=
X-Gm-Gg: ASbGncsUZfWUEpp3Zcw9Tm/iKXKBnxjDmCKEnqYdnuY5HURckzFvC55A//dixAH/WLS
	YPDs/VhTfPmUr7BGDt1JgXCIYZSfRAWj4jl5XaEcTv/lKy75X7j8uhjjMizGEuSGVX/h+OjeMBG
	9sEIpy
X-Received: by 2002:a17:90b:1d05:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-315f26192efmr8661946a91.15.1750905254633;
        Wed, 25 Jun 2025 19:34:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmWZ20ylBufEuyD8a4snrfN5wLqjOc1AW3vCQs60y21v0vOw3rVlavg03klPFzZsn8v3UuQzPZyDKXt277yE0=
X-Received: by 2002:a17:90b:1d05:b0:311:9c1f:8516 with SMTP id
 98e67ed59e1d1-315f26192efmr8661917a91.15.1750905254221; Wed, 25 Jun 2025
 19:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-2-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-2-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:34:02 +0800
X-Gm-Features: Ac12FXyruohJ57b6kb7ijE0xoMHh_6UYned9b5xz_RKi13myHBKADRrN7NPxO3A
Message-ID: <CACGkMEvioXkt3_zB-KijwhoUx5NS5xa0Jvd=w2fhBZFf3un1Ww@mail.gmail.com>
Subject: Re: [PATCH net 1/4] virtio-net: ensure the received length does not
 exceed allocated size
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ie1bnSdB1TD6lEBSGrAnwNU9Nh9RM-jRZwW7nKaCZr4_1750905255
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> In xdp_linearize_page, when reading the following buffers from the ring,
> we forget to check the received length with the true allocate size. This
> can lead to an out-of-bound read. This commit adds that missing check.
>
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")

I think we should cc stable.

> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e53ba600605a..2a130a3e50ac 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1797,7 +1797,8 @@ static unsigned int virtnet_get_headroom(struct vir=
tnet_info *vi)
>   * across multiple buffers (num_buf > 1), and we make sure buffers
>   * have enough headroom.
>   */
> -static struct page *xdp_linearize_page(struct receive_queue *rq,
> +static struct page *xdp_linearize_page(struct net_device *dev,
> +                                      struct receive_queue *rq,
>                                        int *num_buf,
>                                        struct page *p,
>                                        int offset,
> @@ -1818,17 +1819,33 @@ static struct page *xdp_linearize_page(struct rec=
eive_queue *rq,
>         page_off +=3D *len;
>
>         while (--*num_buf) {
> -               unsigned int buflen;
> +               unsigned int headroom, tailroom, room;
> +               unsigned int truesize, buflen;
>                 void *buf;
> +               void *ctx;
>                 int off;
>
> -               buf =3D virtnet_rq_get_buf(rq, &buflen, NULL);
> +               buf =3D virtnet_rq_get_buf(rq, &buflen, &ctx);
>                 if (unlikely(!buf))
>                         goto err_buf;
>
>                 p =3D virt_to_head_page(buf);
>                 off =3D buf - page_address(p);
>
> +               truesize =3D mergeable_ctx_to_truesize(ctx);

This won't work for receive_small_xdp().

> +               headroom =3D mergeable_ctx_to_headroom(ctx);
> +               tailroom =3D headroom ? sizeof(struct skb_shared_info) : =
0;
> +               room =3D SKB_DATA_ALIGN(headroom + tailroom);
> +
> +               if (unlikely(buflen > truesize - room)) {
> +                       put_page(p);
> +                       pr_debug("%s: rx error: len %u exceeds truesize %=
lu\n",
> +                                dev->name, buflen,
> +                                (unsigned long)(truesize - room));
> +                       DEV_STATS_INC(dev, rx_length_errors);
> +                       goto err_buf;
> +               }

I wonder if this issue only affect XDP should we check other places?

> +
>                 /* guard against a misconfigured or uncooperative backend=
 that
>                  * is sending packet larger than the MTU.
>                  */
> @@ -1917,7 +1934,7 @@ static struct sk_buff *receive_small_xdp(struct net=
_device *dev,
>                 headroom =3D vi->hdr_len + header_offset;
>                 buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
>                         SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -               xdp_page =3D xdp_linearize_page(rq, &num_buf, page,
> +               xdp_page =3D xdp_linearize_page(dev, rq, &num_buf, page,
>                                               offset, header_offset,
>                                               &tlen);
>                 if (!xdp_page)
> @@ -2252,7 +2269,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>          */
>         if (!xdp_prog->aux->xdp_has_frags) {
>                 /* linearize data for XDP */
> -               xdp_page =3D xdp_linearize_page(rq, num_buf,
> +               xdp_page =3D xdp_linearize_page(vi->dev, rq, num_buf,
>                                               *page, offset,
>                                               XDP_PACKET_HEADROOM,
>                                               len);
> --
> 2.43.0
>

