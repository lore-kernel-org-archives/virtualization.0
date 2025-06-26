Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768AA20C497
	for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 02:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905440; cv=none; b=NeHRa1/5tQHevZBZHB2pXzYGLEfKolcIGw/+XBwst9A0VbKMA2e+UFeQ/qUDWnDlOZFcn0eGB9oA+YqWVxRXoXvWBa3uyV6Ysjmqfm3r0jZe5fG3aXEGByV0SNRwNR7q6mb3F7A3sK05B+GiOcy2+KfS2oU6xEJVx6FYcnLx3zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905440; c=relaxed/simple;
	bh=e5C9qrU3fsOpfaDgADgkrynMWd5GzhKtqGQzdriNJ3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CARtKwND4al3DEkPi/fm28CVbXcK4OI35aY7Ln3WlJGZBXypJRO0cDx7VlQMyfZ/HkMY0am3WeWVPNtaHUK8EcP8BNGV4pIv9mree0a0IlfXyEJe+ulUd68xSO7WzoDSAwajkBMUmjPsdfw4UA0ZlUWGzIEBqv9KSkRu9QRrWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+0itSvi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+0itSvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750905437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EW+I1QQIKlTT7W9a4yuMAmimMoHXfs6dlaepoS7uBM4=;
	b=L+0itSvi7S7RE2UyumHfj9k9c+e6ns43ANlRJb43K9G8m7BWEbPa0KNkk5Mky63WrEfNO6
	p7hc/i10cJJY3C9hhNAN5qnrA/ftV6J6yBkmw5CUsfwGnjCSP1aitRTFktHpHGWSVXEeTj
	YsdLNYMAA2yoAWIZyBsAA+cyorm1svU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-TkAIVZfNP3mFAgiJjOkimA-1; Wed, 25 Jun 2025 22:37:15 -0400
X-MC-Unique: TkAIVZfNP3mFAgiJjOkimA-1
X-Mimecast-MFC-AGG-ID: TkAIVZfNP3mFAgiJjOkimA_1750905434
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313c3915345so673246a91.3
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 19:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905434; x=1751510234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW+I1QQIKlTT7W9a4yuMAmimMoHXfs6dlaepoS7uBM4=;
        b=l8qoj4oaZMkT2P38qlDHi6JW112YsGAdbCViRGSTgfc4bQLwIdNGr3zpmq8eAL1pgW
         pCbqvigj8uC8QHc0Sc9k5K9C1qlmpvJXQNC2GwSdd2LkzTnJO8YRXoFI2OuAZEjvLSMp
         CtucG1V3ZxQmSK6p72U8+FzuXwYq64QJgxn/t/+tAproSG8eGBROS8/zC23xXCqit/uf
         CqopuvUYejWCKPiZOWwBjc17sOvWAv4x0DKIOrYBzG+qNLd/CsH972aoAlcYj4JVYPkL
         QQIkqhgcM4WdVTnL0bp1x8O1sFon3K4lUysIx3Aq/kCx07qRlzU/OM1sNJplNODRshtm
         Nbqg==
X-Forwarded-Encrypted: i=1; AJvYcCXFzUz0mVkqc6e46PVY1qAFnPYLHP7annLMLKAZdJRavHbS9V+7SKe+c+PeHzFB7RioGFgI8BspscgaV7qzOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEL4nunKp28uK2wUAiBwwm+4XIweiHUxLwHphtuv1Vk4UnI4rI
	GZwmrFtkUlYJmi4dRxNiMSnQ9jWZTEg265CHwRqZ5tdE1JmOAgM4CMwOxLvvrdTwe2zFQcceXU0
	EN3mPI6eoOZMPDCLvEJhFYTjv8XsBZN0QF0WXgiikYlxyYdvTpCKfNmQ0PKdY9b/E8PD9sDZoEa
	JMNWWNE8TU3d67hX3nC782p5uJwcYK8rU3Ff+rGv9Irq0=
X-Gm-Gg: ASbGncsOXTwqZpEiQaRkR0O0QRIXktuU9lGjlk57A+ecbE5MF4knJimqkrxe3VW70Ml
	tmJfTutBY54pThoNG+hxgtFzH5Dc3PcqlJRy8Fs5hC0Th7d1Fuj/daJQu8jatWiNlsTzWsxJx4Q
	zRUVeE
X-Received: by 2002:a17:90b:2b4c:b0:313:fb08:4261 with SMTP id 98e67ed59e1d1-315f269fa56mr6541988a91.32.1750905434005;
        Wed, 25 Jun 2025 19:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnFq27uptoJBVoGMseNGObxmjNsAzQWtsl9oanE1SD186q54jLA9zURCaRw/XaQvClcZpVeAk2VlfUN6l6Dn8=
X-Received: by 2002:a17:90b:2b4c:b0:313:fb08:4261 with SMTP id
 98e67ed59e1d1-315f269fa56mr6541958a91.32.1750905433553; Wed, 25 Jun 2025
 19:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-3-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-3-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:37:01 +0800
X-Gm-Features: Ac12FXzafcvLIIRlWLmpr_5VBnu8UJoZzPPLlWXuQNGXda7Uc4uun2EikZbgBz8
Message-ID: <CACGkMEuZTP+xPCWuSGwiApWEj_PuOxb5yOeR3t-Bga1t+svawQ@mail.gmail.com>
Subject: Re: [PATCH net 2/4] virtio-net: remove redundant truesize check with PAGE_SIZE
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
X-Mimecast-MFC-PROC-ID: 1njkbalR3DgRGmXEI8MOkKl5jY4RF2R9lH98XnMJtMc_1750905434
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> The truesize is guaranteed not to exceed PAGE_SIZE in
> get_mergeable_buf_len(). It is saved in mergeable context, which is not
> changeable by the host side,

This really depends on the security model.

> so the check in receive path is quite
> redundant.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2a130a3e50ac..6f9fedad4a5e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2144,9 +2144,9 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>  {
>         struct virtio_net_hdr_mrg_rxbuf *hdr =3D buf;
>         unsigned int headroom, tailroom, room;
> -       unsigned int truesize, cur_frag_size;
>         struct skb_shared_info *shinfo;
>         unsigned int xdp_frags_truesz =3D 0;
> +       unsigned int truesize;
>         struct page *page;
>         skb_frag_t *frag;
>         int offset;
> @@ -2194,9 +2194,8 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>                 tailroom =3D headroom ? sizeof(struct skb_shared_info) : =
0;
>                 room =3D SKB_DATA_ALIGN(headroom + tailroom);
>
> -               cur_frag_size =3D truesize;
> -               xdp_frags_truesz +=3D cur_frag_size;
> -               if (unlikely(len > truesize - room || cur_frag_size > PAG=
E_SIZE)) {
> +               xdp_frags_truesz +=3D truesize;
> +               if (unlikely(len > truesize - room)) {
>                         put_page(page);
>                         pr_debug("%s: rx error: len %u exceeds truesize %=
lu\n",
>                                  dev->name, len, (unsigned long)(truesize=
 - room));
> --
> 2.43.0
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

