Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043A1FECBA
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 03:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507732; cv=none; b=LcpX9XZ9jcxUq/sEqvPjIrMYxUcfQQCTDvWQTw5YSSLQLy5T8N/xFHk6tV7+XjvDOFGlu5wlcMKILSvdzWmUcUZxok4O2hfecrLvYz1xMc7LWVLIW8IFalQDfde9LjHJTkZBmHw++Ck4U3N9KXCtrOu5b2jNQtd5l/vuABCqxUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507732; c=relaxed/simple;
	bh=IwizxpPURzX2jD0W5Du6Tyf/56Go3Y/S4srRiey9Raw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1EtwDrxOqWR+yHOaVQYmHmKouBV5Fi3eCg8Uc3XIWShvb4IROBbm+k+Oincs5U3J/8w0N5d4mdI0Jf5UyRDa3bNaL+dQKa6usNRG++kHOgG6xlhlQEWHjEibLJTC1PRCiDgMlz+X2gh7d8uAFCbq2im/0vhan5aLB6CijzzNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhT5bPm8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhT5bPm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772507730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Bf79Q/NnXmzYDVVSgb0Zw9SZSCpomlBP1E9IJmLB3s=;
	b=hhT5bPm8n1Y6mu5qEBRBstQHFkOqhA3pIlZo9ww3YpP3M3q9tbkLqFVKyLginKp5BVIEcf
	5ps322U/EgU7/XG/lt5wwHAisALmaGInzGTHpQZJ5uOp41Vsi9JC285zVQTE/3Jb2wG9QI
	hIw1OkR8jL0ZBv1J6hQzItPRRZy64uk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-SHddzYbGNVuDvvt8iy-hLQ-1; Mon, 02 Mar 2026 22:15:29 -0500
X-MC-Unique: SHddzYbGNVuDvvt8iy-hLQ-1
X-Mimecast-MFC-AGG-ID: SHddzYbGNVuDvvt8iy-hLQ_1772507728
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae4e9577ceso75955805ad.1
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 19:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772507728; x=1773112528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Bf79Q/NnXmzYDVVSgb0Zw9SZSCpomlBP1E9IJmLB3s=;
        b=V6INuPQq8VHZLHjA385Ng23ZvQ3Boxmq/DiAZGSnFsYb1nQ54EFLrp1rf6qEHHkRGi
         nwni0DcjEIVhDWO603ALPQVlUcNo7kfFv8n3clg8MGGpp39fF9XSYk3bxrzg4/llDa4Z
         7Y0SyhId9z6LgVW5ktJmIrlBuimJhl+xY6sf4wNQsb+3qAV/XDXxJt7bqN/dj9hmU/G9
         01jrmgAVl7t2+UDy7zNzaH6NILPPWanGug55eZj8zSN9mqaWw0S+KUTTV2lYS77PTPBT
         o07Oza2gGPWrGH3mLiaRkQBHLZ4RgpQtiBxdHeOCfQ3HKyiWhUG/R+CnR64aTzMc0MtM
         WnVA==
X-Forwarded-Encrypted: i=1; AJvYcCVx4qXBcQ+CSrDrFPXGTOlNKhEJJGjp+u2N25Vq4GNfQupfxNquirjWRIsIpE4Z4lEjjdjgejTQofOMhJKnDg==@lists.linux.dev
X-Gm-Message-State: AOJu0YznEPPqPML6xbGGkLeXFWimig8tULVL7ZIPZBSs6GyC4P6c8baK
	BN6o3dtR/E2/eu8tO5EbPv27h7A/gVxc8G3yO6cRrUCGvpoAAMGbg9sHRCi0aTDvKBNbHOmocZT
	iyy2a6p2d9B2lTzJTkD1ERA2tUZSU6zZpkwGoFXRMNV5BsS/NDZKiS4r+pUzq/oBYK2wkohljui
	X9UsKVy0h9yMx0rllXYXK8xRnCeqfwmkI5uUY6svDMzRs=
X-Gm-Gg: ATEYQzxwSkS6RhTreFoVQh+ZwL4gmrs0LrYxdDupZ1KTcqG2tOXJlpuogQPNzt/SnP5
	bIhMGFG99i6qWIRcTrRRmjWt1c52wHxoVz1bG3fikxBVe5lKNu/tBgOs+CvGbao4ZYxww/5+XAC
	9Trx/iy0njxV5LlB78wAa1Ymy3NhJUxj3kvylwoXXNeUc/edRAYjY2RNmUB9sUOLAM06xtSJ+Zh
	H9MBhJn
X-Received: by 2002:a17:902:f789:b0:2ae:4cd9:7196 with SMTP id d9443c01a7336-2ae4cd97478mr70431935ad.29.1772507728312;
        Mon, 02 Mar 2026 19:15:28 -0800 (PST)
X-Received: by 2002:a17:902:f789:b0:2ae:4cd9:7196 with SMTP id
 d9443c01a7336-2ae4cd97478mr70431505ad.29.1772507727825; Mon, 02 Mar 2026
 19:15:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260302090413.86471-1-xuanzhuo@linux.alibaba.com> <20260302090413.86471-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260302090413.86471-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Mar 2026 11:15:16 +0800
X-Gm-Features: AaiRm50IOXUFT0FltUxfUjfp32u-c2Q-Y6q5lunuZueLNIghUQnp7TWKeqIlzWo
Message-ID: <CACGkMEtnOKxJVY2qrbFsTwR9c=e34HU7z6Mdhyj3kPGf867F-g@mail.gmail.com>
Subject: Re: [PATCH net v7 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dSdicvOkUUpLvv-voyUruYKHhaZGG84ratL3FsslnN8_1772507728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 5:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
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
>  drivers/net/virtio_net.c   |  8 +++--
>  include/linux/virtio_net.h | 61 ++++++++++++++++++++++++++++++--------
>  3 files changed, 56 insertions(+), 15 deletions(-)
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
> index 72d6a9c6a5a2..1800058c8072 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3265,9 +3265,13 @@ static int xmit_skb(struct send_queue *sq, struct =
sk_buff *skb, bool orphan)
>         const unsigned char *dest =3D ((struct ethhdr *)skb->data)->h_des=
t;
>         struct virtnet_info *vi =3D sq->vq->vdev->priv;
>         struct virtio_net_hdr_v1_hash_tunnel *hdr;
> -       int num_sg;
>         unsigned hdr_len =3D vi->hdr_len;
> +       bool feature_hdrlen;
>         bool can_push;
> +       int num_sg;

nit: the change to num_sg seems to be unnecessary.

> +
> +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> +                                           VIRTIO_NET_F_GUEST_HDRLEN);
>
>         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
>
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
> index 75dabb763c65..d31c9af1f3d6 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -207,20 +207,40 @@ static inline int virtio_net_hdr_to_skb(struct sk_b=
uff *skb,
>         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_=
type);
>  }
>
> -static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> -                                         struct virtio_net_hdr *hdr,
> -                                         bool little_endian,
> -                                         bool has_data_valid,
> -                                         int vlan_hlen)
> +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> +                                        struct virtio_net_hdr *hdr,
> +                                        bool little_endian,
> +                                        bool feature_hdrlen)
> +{
> +       u16 hdr_len;
> +
> +       if (feature_hdrlen) {
> +               hdr_len =3D skb_transport_offset(skb);
> +
> +               if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> +                       hdr_len +=3D sizeof(struct udphdr);
> +               else
> +                       hdr_len +=3D tcp_hdrlen(skb);
> +       } else {
> +               /* This is a hint as to how much should be linear. */
> +               hdr_len =3D skb_headlen(skb);
> +       }
> +
> +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> +}
> +
> +static inline int __virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +                                           struct virtio_net_hdr *hdr,
> +                                           bool little_endian,
> +                                           bool has_data_valid,
> +                                           bool feature_hdrlen,
> +                                           int vlan_hlen)
>  {
>         memset(hdr, 0, sizeof(*hdr));   /* no info leak */
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
>
> -               /* This is a hint as to how much should be linear. */
> -               hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
> -                                                skb_headlen(skb));
>                 hdr->gso_size =3D __cpu_to_virtio16(little_endian,
>                                                   sinfo->gso_size);
>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
> @@ -231,6 +251,10 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
>                 else
>                         return -EINVAL;
> +
> +               virtio_net_set_hdrlen(skb, hdr, little_endian,
> +                                     feature_hdrlen);
> +
>                 if (sinfo->gso_type & SKB_GSO_TCP_ECN)
>                         hdr->gso_type |=3D VIRTIO_NET_HDR_GSO_ECN;
>         } else
> @@ -250,6 +274,16 @@ static inline int virtio_net_hdr_from_skb(const stru=
ct sk_buff *skb,
>         return 0;
>  }
>
> +static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> +                                         struct virtio_net_hdr *hdr,
> +                                         bool little_endian,
> +                                         bool has_data_valid,
> +                                         int vlan_hlen)
> +{
> +       return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                        has_data_valid, false, vlan_hlen=
);
> +}
> +
>  static inline unsigned int virtio_l3min(bool is_ipv6)
>  {
>         return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
> @@ -385,7 +419,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
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
> @@ -395,8 +430,9 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL =
|
>                                                     SKB_GSO_UDP_TUNNEL_CS=
UM);
>         if (!tnl_gso_type)
> -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> -                                              has_data_valid, vlan_hlen)=
;
> +               return __virtio_net_hdr_from_skb(skb, hdr, little_endian,
> +                                                has_data_valid,
> +                                                feature_hdrlen, vlan_hle=
n);
>
>         /* Tunnel support not negotiated but skb ask for it. */
>         if (!tnl_hdr_negotiated)
> @@ -409,7 +445,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb=
,
>
>         /* Let the basic parsing deal with plain GSO features. */
>         skb_shinfo(skb)->gso_type &=3D ~tnl_gso_type;
> -       ret =3D virtio_net_hdr_from_skb(skb, hdr, true, false, vlan_hlen)=
;
> +       ret =3D __virtio_net_hdr_from_skb(skb, hdr, true, false,
> +                                       feature_hdrlen, vlan_hlen);

This seems to be incorrect as tnl_gso_type is masked so
__virtio_net_hdr_from_skb() can only see UDP packet for tunnel gso
packet?

(And it seems to be fixed in next patch, could we simply squash them)

Thanks


>         skb_shinfo(skb)->gso_type |=3D tnl_gso_type;
>         if (ret)
>                 return ret;
> --
> 2.32.0.3.g01195cf9f
>

