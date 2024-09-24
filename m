Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B38148FF7
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163320; cv=none; b=uRA/yyiBj0Jb/jDfKhoJcx9vSm2GHNJhJ4oCJexjZKK7LAzs1hw6+SumupORpyzzKvmY4Gk5bwm+kgzpNFjgq+Zc6kaOWsPKnueLdjDCPct/olZZn1Q1VXsn0iB1H2Ef7ZraPWjKWxZlw2qG/ZPNgPMeGV1dxN38MSGqj2MhEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163320; c=relaxed/simple;
	bh=gd9TLfoZx2F+kEdm7NZ/WMO9UVX62rFrq7W3T+xr/gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/4gMVgyF8JZJy5Wrd05ONlDCLZ7GHfkI+nydaPbVAgjFV1whhA/QbC7DZ8lEgaiRK+vMbKHC67oo1crQPrZhNEjuNV8BOKVQglr0GtCeNJRlCpoac+Bk7a6QNC4ergJhqtu+YricJIvZyXX8WrMS0Zw7CJprHsUXEd0zR1wYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ve7cfpUS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ve7cfpUS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPeVxGad0rWL+6l63ORIof7v2WZ21lQlNY9saN2Whdc=;
	b=Ve7cfpUSS1lElrR88iMTIQB7LfNVuoCwvxoeImabIf57sRCP8jPvZiBNHqIBGgiVKTWnws
	OrAQC3FxCA5Nifjr0zYEdcGv2iu7dHyZrlSRVcNIB01uxAZGCr84vg/9AWARKvs1L98jTg
	BY2gKwt4SCRgg3yjnCeZ4H6o6oXdWZ8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-I--XwRD5PCWxdakBLQYFQg-1; Tue, 24 Sep 2024 03:35:17 -0400
X-MC-Unique: I--XwRD5PCWxdakBLQYFQg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-718f329aefdso5297583b3a.1
        for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 00:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163316; x=1727768116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPeVxGad0rWL+6l63ORIof7v2WZ21lQlNY9saN2Whdc=;
        b=e1xPYte+q16sIruRzpmvA8vBXwT6V/H7I+gXBp/XLoXxlqr8nfGMpGXqQAMpmj+dhw
         IQ2Ej2w2aPRjZ46X9oaIPpRk18jO8zX4kfh8hh+WXFg/1hNIsLTB5pqmxHDT6VxDboKk
         UDfX2XU9fhPMOucnibeUFHglvJf82Sb+S8F8BEkPkufHYjcZMoinh/lMwkDQNsFYjzM6
         RF/eYe2pXt8rLt/vpLnd/luJAKOF7KVvrzc08qqv+ZPmxZZeY3RTj4Tgfdy6WklJ3GzT
         N82WaB+DERafQjo0iq1hJdieuIDlebabqdslj9bGZA5e8YeOT5eZFp1HXg+IQWgMaoa8
         XQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4TzSAxLOP9V2V2qg2zniwNZIR2FJiXEUmkycFuSYOqwn6U89ZzLznkDjwUW8MwscwZ18cWkoW7BFKxIUa6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFjG5ji33/Iml6UFAkKjH4JGoTBi2GcPd9lYP/LUGlDqvMy2n2
	2SYpfyuPhdJBElnDGXAUv80KlWcRtOHtLZ2Kjyz1Lm7EX1SwTsBvmAr51gnhxbUGgwsZ0v6ePIS
	dxhY1As954VsLbj9VcZ0wTeM/2OivbOlKOZLgzJVXM2ILR3kvBdvt+Avlpm9RGkYzspPtb5Tagt
	KALUObQwfMYZy69BjaN9PcfJicCyPrCudF4flnv97/zp7NIa2rOw==
X-Received: by 2002:a05:6a20:d525:b0:1d0:56b1:1c59 with SMTP id adf61e73a8af0-1d30a9fb7b3mr19470582637.32.1727163315957;
        Tue, 24 Sep 2024 00:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx/soIIabkJ0QhCDlDO4PjZWR1FTyoTbioUpQfhFh0yWY1kmlQ/qO18q1LS4ki5NKSTFvtS8mDzJ3BNF/H4wk=
X-Received: by 2002:a05:6a20:d525:b0:1d0:56b1:1c59 with SMTP id
 adf61e73a8af0-1d30a9fb7b3mr19470570637.32.1727163315542; Tue, 24 Sep 2024
 00:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com> <20240924013204.13763-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240924013204.13763-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:35:03 +0800
Message-ID: <CACGkMEtbNrwbxhRbjHGiEQeQbWUb2iL0ZtyosXs4_+GoZY-Gsw@mail.gmail.com>
Subject: Re: [RFC net-next v1 07/12] virtio_net: refactor the xmit type
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Because the af-xdp will introduce a new xmit type, so I refactor the
> xmit type mechanism first.
>
> In general, pointers are aligned to 4 or 8 bytes.

I think this needs some clarification, the alignment seems to depend
on the lowest common multiple between the alignments of all struct
members. So we know both xdp_frame and sk_buff are at least 4 bytes
aligned.

If we want to reuse the lowest bit of pointers in AF_XDP, the
alignment of the data structure should be at least 4 bytes.

> If it is aligned to 4
> bytes, then only two bits are free for a pointer. But there are 4 types
> here, so we can't use bits to distinguish them. And 2 bits is enough for
> 4 types:
>
>     00 for skb
>     01 for SKB_ORPHAN
>     10 for XDP
>     11 for af-xdp tx
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 90 +++++++++++++++++++++++-----------------
>  1 file changed, 51 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 630e5b21ad69..41a5ea9b788d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -45,9 +45,6 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_TX          BIT(0)
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
> -#define VIRTIO_XDP_FLAG                BIT(0)
> -#define VIRTIO_ORPHAN_FLAG     BIT(1)
> -
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
>   * at once, the weight is chosen so that the EWMA will be insensitive to=
 short-
> @@ -512,34 +509,35 @@ static struct sk_buff *virtnet_skb_append_frag(stru=
ct sk_buff *head_skb,
>                                                struct page *page, void *b=
uf,
>                                                int len, int truesize);
>
> -static bool is_xdp_frame(void *ptr)
> -{
> -       return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> -}
> +enum virtnet_xmit_type {
> +       VIRTNET_XMIT_TYPE_SKB,
> +       VIRTNET_XMIT_TYPE_SKB_ORPHAN,
> +       VIRTNET_XMIT_TYPE_XDP,
> +};
>
> -static void *xdp_to_ptr(struct xdp_frame *ptr)
> -{
> -       return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> -}
> +/* We use the last two bits of the pointer to distinguish the xmit type.=
 */
> +#define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
>
> -static struct xdp_frame *ptr_to_xdp(void *ptr)
> +static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)

Nit: not a native speaker but I think something like pack/unpack might
be better.

With those changes.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

