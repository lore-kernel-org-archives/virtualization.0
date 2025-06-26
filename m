Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71813E898
	for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750906278; cv=none; b=ndlF3U9/xhMZ36A7eBnNvwfR7DmTaxaejoWDZJ00dzqef2aE8QYt1vWq/1mbmP9miaEJH95hr7Kr8fbmk9XjXhN6lYSCP77d7QDIHi/UhV6HWB7nrT8NhQgQ2+PDSo/T+GUXxvTPaRu7t5UddyfOrRSdFa1NPWg0FEwwQrgkKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750906278; c=relaxed/simple;
	bh=AbbTcY3G90uhbAvwfnDrpva8mh1yG4yY6IHShSbbWSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLFlwCfZE1cQlKthjdGPwLO2bv5Jy7lD6poZQVRL+JIYFpZDGWrh/BrhKLLJegnSZb7sZWPaJ1/ECyw1fhZNG29viBMP3JTmMs8vpiT4gmRJn3PrYMUnjpC9voXFIVNIuaU/o8coBb2unKLWt4Z7yo+lTbm90RzGpT1rzCHN8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nz2Jt7+m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nz2Jt7+m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750906275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEngYMz6+Uctu+0RSamLzUn3jyWMAMQ76O4pVQprsBY=;
	b=Nz2Jt7+mvTxq/JhC/S16hrHNP7hlx8NIoI09U7qJcqHpL+V3oMq+cF4ImMrRE5F5/6Gxx8
	N+0wjE7CLpVmerosqcD6KJOtIza/d3kLrA6mY/XBN/uP2DdWt5F8OovjYHve7Iq9FG3mU6
	XYb5b0UEA2jNMQcIEJemSpt/rVa00Yo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-45cX1A0GOHiUQw9XKjR2Fg-1; Wed, 25 Jun 2025 22:51:14 -0400
X-MC-Unique: 45cX1A0GOHiUQw9XKjR2Fg-1
X-Mimecast-MFC-AGG-ID: 45cX1A0GOHiUQw9XKjR2Fg_1750906273
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso660279a91.1
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 19:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750906273; x=1751511073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEngYMz6+Uctu+0RSamLzUn3jyWMAMQ76O4pVQprsBY=;
        b=i7LEcPKYbJjTYkZQFupFfZDiBHJxjtrzVUnStQMsd7Rz52Qvnb6tddpb/kKsCZXCxm
         BeypcxuYtjm/trp6toWsqq79edUt1UjfubDQlK6XHxTPgQHpC5CkdZEeGUqLCqfvSwaR
         Wu/RNbzw3tn3S1RkjnzsQjXq7DEO60BCmPTftolRQiHtthn/Ih6Ig2iNKO5lgjaitDZk
         ls+tIGHvwP5ScbN8ysVsF2UWsoP17fHBALBqMGlJy7eezH3VHGCBv3D2gu3/q5yKFnEe
         CIVb4PBSRlnLs3rlKGj0QjvNrS0XwP08JV0jU9wlABbyZn0MB0uA0juhyR+8jGhQ/Ka2
         wwIg==
X-Forwarded-Encrypted: i=1; AJvYcCU+DMtm3SOIXzqs5gSRR5VOkOFIpEplc+ALw/DWiyWDcRQ8XW1Zo4I/FpKMi75BEUeMFfq5YGMS/1rDKXei9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyv6QQW0BYGFyYQhJhX+pM1guIkNwGu8QFFRCtaeoe/MqJOwXvn
	YJEX+1YxTZtysO4o2CGUsUozOAczuLjeKpQG9MOeHUY5DK8ot1XRl8AAvubLXEnw2MSh4fGPt/p
	L3WeKfSjIRI0oCoxtEXlXIAhd7saoF7EKwHo/sJRxt6VV/lYiuZn+Dbkc5KG+kpVInhBdqzzcif
	ElR048lI3Is4LJfIIHANMRFG6BkbWYP0fPX+otf3GDtks=
X-Gm-Gg: ASbGnctrI8go4RtxmpvXNdjQt5Ze67jBRy3INEtDN6kyTFgAUieOx2Ua1K2nChcofTP
	gWdRux8P1wK1IvuROrcycQRTmi67qe3TmuU+fJiRQLCfc2dcQ/wFJnQ8pcGgtr9gMwkCb7/5Zpj
	DC64h2
X-Received: by 2002:a17:90b:562d:b0:30e:3718:e9d with SMTP id 98e67ed59e1d1-315f26b3e52mr7507598a91.35.1750906273386;
        Wed, 25 Jun 2025 19:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy1oEFNW+pNyBHKxl5UFz4XuW+PyQ5F7+ZNjbo3jFzhfPpd3FRUMNsXAMnW3CCIEXyQmt+3K6tjBWZQ09ordg=
X-Received: by 2002:a17:90b:562d:b0:30e:3718:e9d with SMTP id
 98e67ed59e1d1-315f26b3e52mr7507572a91.35.1750906273025; Wed, 25 Jun 2025
 19:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250625160849.61344-1-minhquangbui99@gmail.com> <20250625160849.61344-5-minhquangbui99@gmail.com>
In-Reply-To: <20250625160849.61344-5-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Jun 2025 10:51:01 +0800
X-Gm-Features: Ac12FXxCVxp6548gkQ8YE-vjFv3IjVZGUSKTIBIUxHnJq7DtVbLHmVNL-WVcg1k
Message-ID: <CACGkMEv-EgkZs6d4MHwxj0t_-pQvxMRLTdgguP7GUijbg-kEoA@mail.gmail.com>
Subject: Re: [PATCH net 4/4] virtio-net: allow more allocated space for
 mergeable XDP
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
X-Mimecast-MFC-PROC-ID: 6vHgdLB2YJym1-UGrKQe88Eas0-gtAFp5Z80sxvpbwk_1750906273
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:10=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> When the mergeable receive buffer is prefilled before XDP is set, it
> does not reserve the space for XDP_PACKET_HEADROOM and skb_shared_info.
> So when XDP is set and this buffer is used to receive frame, we need to
> create a new buffer with reserved headroom, tailroom and copy the frame
> data over. Currently, the new buffer's size is restricted to PAGE_SIZE
> only. If the frame data's length + headroom + tailroom exceeds
> PAGE_SIZE, the frame is dropped.
>
> However, it seems like there is no restriction on the total size in XDP.
> So we can just increase the size of new buffer to 2 * PAGE_SIZE in that
> case and continue to process the frame.
>
> In my opinion, the current drop behavior is fine and expected so this
> commit is just an improvement not a bug fix.

Then this should go for net-next.

>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 844cb2a78be0..663cec686045 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2277,13 +2277,26 @@ static void *mergeable_xdp_get_buf(struct virtnet=
_info *vi,
>                                               len);
>                 if (!xdp_page)
>                         return NULL;
> +
> +               *frame_sz =3D PAGE_SIZE;
>         } else {
> +               unsigned int total_len;
> +
>                 xdp_room =3D SKB_DATA_ALIGN(XDP_PACKET_HEADROOM +
>                                           sizeof(struct skb_shared_info))=
;
> -               if (*len + xdp_room > PAGE_SIZE)
> +               total_len =3D *len + xdp_room;
> +
> +               /* This must never happen because len cannot exceed PAGE_=
SIZE */
> +               if (unlikely(total_len > 2 * PAGE_SIZE))
>                         return NULL;
>
> -               xdp_page =3D alloc_page(GFP_ATOMIC);
> +               if (total_len > PAGE_SIZE) {
> +                       xdp_page =3D alloc_pages(GFP_ATOMIC, 1);

I'm not sure it's worth optimizing the corner case here that may bring
burdens for maintenance.

And a good optimization here is to reduce the logic duplication by
reusing xdp_linearize_page().


> +                       *frame_sz =3D 2 * PAGE_SIZE;
> +               } else {
> +                       xdp_page =3D alloc_page(GFP_ATOMIC);
> +                       *frame_sz =3D PAGE_SIZE;
> +               }
>                 if (!xdp_page)
>                         return NULL;
>
> @@ -2291,8 +2304,6 @@ static void *mergeable_xdp_get_buf(struct virtnet_i=
nfo *vi,
>                        page_address(*page) + offset, *len);
>         }
>
> -       *frame_sz =3D PAGE_SIZE;
> -
>         put_page(*page);
>
>         *page =3D xdp_page;
> --

Thanks

> 2.43.0
>

