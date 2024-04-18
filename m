Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF6757F2
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421609; cv=none; b=AqOxGENPgFZ9xgoYwApJPoFyWVTxO8GnRApAuPz3lPK5P7bAf+sC2HS/muYBZdO1gqKMdCPyH8RVI9ErhJ2/ZOr4bAbB+SDz3eGQWijA3J9wo2by++lK0Shy64CaExjaCTTIWcmGBmJt/hkUBzm4Uri+LuxdgM9s6kSrrvt2xns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421609; c=relaxed/simple;
	bh=hPDepYOxZkPDNS5W9loYpVnE+cA9KTqLbhUSRklTJqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWwdSUfySPCRirekwucbzjiAuH78dpHIUWeKVvNFiAjUm0oImUa0JDoscZmE5ICWNm5yXsMwTM3k+zEcMyUrHZejjiys3Ifq0JRYwzbBtR5ArKy6mZo3AdB3ec0AT4gzY+9uwwCjjWzCEtU78KAZsvvY06+X/DSG49+Qop02OQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z61+CZcG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z61+CZcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713421607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Co+J/IEmR0gHg13sO9R+LS6Bt2YubSKjtOCe81CGia8=;
	b=Z61+CZcG7E6GY85pCZ4g8EY/DqlJgkcV/6H3ARxBNVJSgnhAoviD4RSXSjPXS+CdGQTq2y
	YSUcE6Ry3vOXxP57s1S8T4TVxurF2e8431xKqXwcQGm+3KA2R8bAFGnAD71XGEiJvDKH2M
	jIFkj0fU3SDzXTQcWx3UWxNK1UKes0c=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-Jb7Qe_q_MuCTve6MumfCSg-1; Thu, 18 Apr 2024 02:26:45 -0400
X-MC-Unique: Jb7Qe_q_MuCTve6MumfCSg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6edddd0375fso650790b3a.2
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 23:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421605; x=1714026405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co+J/IEmR0gHg13sO9R+LS6Bt2YubSKjtOCe81CGia8=;
        b=VkwL2ll60ArvTxtx95tYKjZB0HHsitkFuP+bhlH92czCMWisAMI/hj0Ts+P/dOp++a
         TLGCMSBznJUNaC1J1BtL8V5vvMxi9Db9iOh0gVIkj8upnB4LRSAPc7lZUnymEqCFLtZD
         RjBGlVLbNxzp+FDaApHQs1c/SUDv0k2aLvvTTIBp0KxAL1Ux5O4y4aV/j8goN9oc7OYN
         cvdksIHppY4b6qvyvj6j1yJSmflCK0YybtT9KT6A/xhjXW+5WAy0nxuKw18tjqBcDxeA
         HX3uhGLrNKFr7FkcUsDH4nI2+R/ovgObr9EBZy9hLtVk2nUIQwTXXlP8oTAubh6ei/1o
         0oHw==
X-Gm-Message-State: AOJu0Yy7/yGz87IEnitLK5+IidJmUDs1R5OoZb4HTX5wMt6LqxKY0lXL
	RrKqCqWeHJ6JZchIrHGpHatz7IHxRjQjBojZUkS93xHMyq48x+HkPQzGW6iOqf0g49Tm6w2VXaC
	8IRadpg+SPq0gou/gNQ6uBkvJSW6TN+ew+LZ6wnxo10a/BQ/rCM8z/tSHkDyaQmihFzN+aLrAr9
	CkgmuQvxJDGKQlzUZH+E5jmBzq6RburpQjDtCJrf4=
X-Received: by 2002:aa7:8895:0:b0:6ea:7468:1f31 with SMTP id z21-20020aa78895000000b006ea74681f31mr2004003pfe.30.1713421604834;
        Wed, 17 Apr 2024 23:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu1YQNTHlp2GTN5tAG/tZSABZjo8dGXzop5NP4wWmMp69Xrzd9pAfXN5wd84TRB6iUCTyi7ybj6/3bOAiqli0=
X-Received: by 2002:aa7:8895:0:b0:6ea:7468:1f31 with SMTP id
 z21-20020aa78895000000b006ea74681f31mr2003998pfe.30.1713421604498; Wed, 17
 Apr 2024 23:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:26:33 +0800
Message-ID: <CACGkMEv2_wmXsh5uZhfZLQTtJX9633NdRL4KZrHumsTcr70-Sw@mail.gmail.com>
Subject: Re: [PATCH vhost 5/6] virtio_net: enable premapped by default
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
> Currently, big, merge, and small modes all support the premapped mode.
> We can now enable premapped mode by default. Furthermore,
> virtqueue_set_dma_premapped() must succeed when called immediately after
> find_vqs(). Consequently, we can assume that premapped mode is always
> enabled.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7ea7e9bcd5d7..f0faf7c0fe59 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -860,15 +860,13 @@ static void *virtnet_rq_alloc(struct receive_queue =
*rq, u32 size, gfp_t gfp)
>
>  static void virtnet_rq_set_premapped(struct virtnet_info *vi)
>  {
> -       int i;
> -
> -       /* disable for big mode */
> -       if (!vi->mergeable_rx_bufs && vi->big_packets)
> -               return;
> +       int i, err;
>
>         for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> -                       continue;
> +               err =3D virtqueue_set_dma_premapped(vi->rq[i].vq);
> +
> +               /* never happen */
> +               BUG_ON(err);

Nit:

Maybe just a BUG_ON(virtqueue_set_dma_premapped()).

Btw, if there's no way to disable pre mapping, maybe it's better to
rename virtqueue_set_dma_premapped() to
virtqueue_enable_dma_premapped(ing).

Thanks

>
>                 vi->rq[i].do_dma =3D true;
>         }
> --
> 2.32.0.3.g01195cf9f
>

