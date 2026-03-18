Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10333123B
	for <virtualization@lists.linux.dev>; Wed, 18 Mar 2026 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806858; cv=none; b=Ev7PUIWBcLhSnpXvvJkNGlxXzn6GULZb7Z6tcHuYTWMXBp6njViwv4OB0fPU8mCyhE9yFk+ZeD8hOQ8dIjLnuwbsoYm6+ZVMC6/MXRi9CQlzfUzuAeRCiT6SGvvEoHvZlVgNOJidqR+4MCWLd5iva0/LA0zFsmpFXVyy80lAOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806858; c=relaxed/simple;
	bh=JX+9CyYQ4c/fJkbA8EsOY6w2X95NTS5oBY8zRj99JYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onfIR/JZm9NfiaMQtgUcKhVwf3Tga/DkffmDAq4LlBlLytM6vbSzHGwt0kFvx6srSL69xIgb/N5mKvutXDX24/FFEeOUTn9o9tuWmbtGQQVYub8mR3itMfsq8kqyLCK5hArxEbp/GVT/4MzFW0VTYE6S/WVjHt7zObS4MTLz/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aq70Wrbk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq70Wrbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773806856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APhLTSVpyDz2QsZIVwNmejono8SLyJjyFG68OMebBo4=;
	b=Aq70WrbkkUDgfX78Vvm47svJDNKTtEHaOgwxWjupH9nFdjMn2/OsaM3Uu6e+V0rqdPMUHW
	gZjS4ZXVdOCwouYdmsJlXwxaL5LuNDr1+n8AbRYFDaAERbJsfKinFZw7L5seWo8PrWIu0o
	RF/0ETpaOKIle1I5A1ES9CEKvJ3QzCc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-n6VKk5hqPyGBFYSQaqxn3w-1; Wed, 18 Mar 2026 00:07:33 -0400
X-MC-Unique: n6VKk5hqPyGBFYSQaqxn3w-1
X-Mimecast-MFC-AGG-ID: n6VKk5hqPyGBFYSQaqxn3w_1773806852
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35845fcf0f5so849882a91.0
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 21:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773806852; x=1774411652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=APhLTSVpyDz2QsZIVwNmejono8SLyJjyFG68OMebBo4=;
        b=hKWEc8TmfWU0KSQlslK56IbOaMOKDFpVNxQh2tNZJILbO6/oP9Cwz21i3lLYD0C73c
         Kw7QKd0NGW/5QuK6bByQ7APKpsj+TxcTIxz4/yD6MeSFfAYyd5r4NGN0y84i2wc7/CSK
         WXMVszJCj1oqthn0zcOPdlLpk/cQeVxGVsjeJXO+rCUI8plCHE/oWgg1sjdVYUtjQFgs
         tGt8qg5l1nDHVPihr9+e4S3BXrwq9oGHrRY3UN40KKRlOq+JLIRhalMEF2BsuyCh8HlC
         gn8Jo+Pnc3/fG1/6oDsVICUjylBhr+sJgUcHbe4lSVBhH6RhPCcZADyS9KKcQw8h3uig
         lvKA==
X-Forwarded-Encrypted: i=1; AJvYcCXPXLuzg7a4sTA66IGukus59zfpyIFqSvfjKCQiey/iq9HTS1IyWeRhmksrgjoek+XOPHuLGFNgNNUc63rvTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yymkx/ZiBb2QfNvBI8OBHVNSLBOWMRNUxHN4Xqc1tQDxXnDPD2Z
	xmRa6xGF70ZtjiacH1k3BNBnl1D9g15rzcGlaWhfN1wpXbLg6dodRVAyB25AbHNJK4KjKsZptnB
	WSDARHn2npVNTg7QHY4ojrDt5R4ff06JlBlZro7ycpDfM5zLEazqPdLEHkQXM/8v/Xe2dY+WBgA
	sUzpjDtaePNz7fxfUub6WB9ouCn+iG9zfhpDLyXwcpOxk=
X-Gm-Gg: ATEYQzyLGDbd8tLf2hb0dQ88zh/2Eqt+XFM7wMJ+2ypH8qaxkXRLy0zctBSMOeS0JTK
	sOkPPdfP1HBMHvI3xmMluA1U35fQIvGDjCqY7BxPSHlmWnDVjwzQAIFbLdFBzxyFHa+BnZnK8l/
	O3dDXaRvvSNodgK1cMM/enjwhkK5Alygc8SOzdbmU82khOSYlnYKvaymBRl9/GXibb4RkDJ0L1H
	doCH0E=
X-Received: by 2002:a17:90b:3b51:b0:35b:973d:147b with SMTP id 98e67ed59e1d1-35badb6eff8mr5562563a91.11.1773806852025;
        Tue, 17 Mar 2026 21:07:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3b51:b0:35b:973d:147b with SMTP id
 98e67ed59e1d1-35badb6eff8mr5562513a91.11.1773806851408; Tue, 17 Mar 2026
 21:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com> <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260313075930.105466-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Mar 2026 12:07:20 +0800
X-Gm-Features: AaiRm50Xknu0MCBnszjwTaJQwPGWMPOiXu5MnonVMdLi0fc3xFlUBMQ8E_CsCTQ
Message-ID: <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zHUQvnbDk3wGi5v5v_negoXLUUhAzux736V7PpS1RZA_1773806852
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
>
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
>
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
>
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gues=
t feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/tun_vnet.h     |  2 +-
>  drivers/net/virtio_net.c   |  6 +++++-
>  include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
>  3 files changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index a5f93b6c4482..fa5cab9d3e55 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
>
>         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
>                                         tun_vnet_is_little_endian(flags),
> -                                       vlan_hlen, true)) {
> +                                       vlan_hlen, true, false)) {
>                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hdr;
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a5a2..7106333ef904 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>         struct virtio_net_hdr_v1_hash_tunnel *hdr;
>         int num_sg;
>         unsigned hdr_len =3D vi->hdr_len;
> +       bool feature_hdrlen;
>         bool can_push;
>
> +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> +                                           VIRTIO_NET_F_GUEST_HDRLEN);
> +
>         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
>         /* Make sure it's safe to cast between formats */
> @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct s=
k_buff *skb, bool orphan)
>
>         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
>                                         virtio_is_little_endian(vi->vdev)=
, 0,
> -                                       false))
> +                                       false, feature_hdrlen))
>                 return -EPROTO;
>
>         if (vi->mergeable_rx_bufs)
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 75dabb763c65..48de4a16a96a 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_bu=
ff *skb,
>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_=
type);
>  }
>
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +                                        struct virtio_net_hdr *hdr,
> +                                        bool little_endian)
> +{
> +       u16 hdr_len;
> +
> +       hdr_len =3D skb_transport_offset(skb);
> +
> +       if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> +               hdr_len +=3D sizeof(struct udphdr);
> +       else
> +               hdr_len +=3D tcp_hdrlen(skb);

Ok, I think this depends on the logic inside virtio_net_hdr_from_skb()

                if (sinfo->gso_type & SKB_GSO_TCPV4)
                        hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
                else if (sinfo->gso_type & SKB_GSO_TCPV6)
                        hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
                else if (sinfo->gso_type & SKB_GSO_UDP_L4)
                        hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
        else
                        return -EINVAL;

To be more robust, I'd suggest moving it there.

But I have another question, the logic above depends on the headlen is
correctly set:

                /* This is a hint as to how much should be linear. */
                hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
                                                 skb_headlen(skb));

Is the headlen guaranteed to be correct in all cases (e.g for nested
setups or dodgy packets?)

Thanks

> +
> +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> +}
> +
>  static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>                                           struct virtio_net_hdr *hdr,
>                                           bool little_endian,
> @@ -385,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>                             bool tnl_hdr_negotiated,
>                             bool little_endian,
>                             int vlan_hlen,
> -                           bool has_data_valid)
> +                           bool has_data_valid,
> +                           bool feature_hdrlen)
>  {
>         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
>         unsigned int inner_nh, outer_th;
> @@ -394,9 +411,17 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *sk=
b,
>
>         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL =
|
>                                                     SKB_GSO_UDP_TUNNEL_CS=
UM);
> -       if (!tnl_gso_type)
> -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> -                                              has_data_valid, vlan_hlen)=
;
> +       if (!tnl_gso_type) {
> +               ret =3D virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                             has_data_valid, vlan_hlen);
> +               if (ret)
> +                       return ret;
> +
> +               if (feature_hdrlen && hdr->hdr_len)
> +                       virtio_net_set_hdrlen(skb, hdr, little_endian);
> +
> +               return ret;
> +       }
>
>         /* Tunnel support not negotiated but skb ask for it. */
>         if (!tnl_hdr_negotiated)
> --
> 2.32.0.3.g01195cf9f
>

