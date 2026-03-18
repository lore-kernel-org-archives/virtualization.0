Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454E26C3BE
	for <virtualization@lists.linux.dev>; Wed, 18 Mar 2026 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773807092; cv=none; b=YMT+xBjaWk8wWhca15tFbCOG8fB4zRSr9Yk0/4PrqXuNJVBQfoye5JaraUFcgLbCvnCiewVpYJCfkUMrfCpQilMBTmIzzXc8w71xQiEtDXgGStA1WyOKR1VwNlVLyeTA2faY14ooR09huHYp78JEGIdo0t05+um4QMmSstAPod8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773807092; c=relaxed/simple;
	bh=I16d/i+5cZTSpwNVQ8yPPiVPaor5KtIBLcB+JXfORxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRwpe2jaD+S3MQFbi14N1K+7EtnRAJ7N4lU+a3HFRy8zqWpAsuI+qAJ97OkzGSrfc3smjDYTIgHqgBzg+2gx1zrkzwmjNjzXqRg/9mVoOal04Hte8iX+ytg+Tml7o/HSPVjD7Eq9s4ni1TZbXMjFABpVw90x2i+Vr39fFVPR9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRa9nkYu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRa9nkYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773807089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbiVdPYlM03NvUDoJqWVfNiFst5daoPrM9XFKWYtY8M=;
	b=QRa9nkYugbh+ZCFPtXM1QWmkgz1GOZ87lYD0rkuBSTVMIwUxonhT6X/lqbV8OnqB1cJHCL
	1zY0eGgdc3l3Jgfdh8hGBmobz0PkEZKCTS0wmFefFdZeeNiET/VxGzHzd8wv/0CxbX4ymg
	Xyu7M2nTLiJi9wrBKD5bYaHk7C+GvzY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-zzsBIotFMHy2smbrAstntg-1; Wed, 18 Mar 2026 00:11:28 -0400
X-MC-Unique: zzsBIotFMHy2smbrAstntg-1
X-Mimecast-MFC-AGG-ID: zzsBIotFMHy2smbrAstntg_1773807087
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b061868724so135739915ad.1
        for <virtualization@lists.linux.dev>; Tue, 17 Mar 2026 21:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773807087; x=1774411887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XbiVdPYlM03NvUDoJqWVfNiFst5daoPrM9XFKWYtY8M=;
        b=ElCHtHlGrsThjA/4SsxO3QmrRuPRxJVnn76QoKWStAuoXbiPc/EBzDFYFbR0iTCT7u
         5RRnPdx4jRAK8gsDhUc27P5tL3T+7FImjbpmgwRgJx4qduHb9KdLiYSgcAm11ngYOesi
         q/jGpVz7aKr44wzCU+0tGGy+wP5cBlhuNp0nLiWL2aWVnOS5ZnmNPLcVO1snAeD0xUZu
         BarqY3YixtPT+CfYYMVX8RVjVmjeEkrUNzZgvmwQrlhwohIcM+U3OiXfpkcQ4QssGG4p
         zjS5i7awvOonIrkBWK1wFmdJD8AIMgvSGGIUR/xrnXeoMm2FvI+CrpQ9BxcMOY65aQ8G
         QZag==
X-Forwarded-Encrypted: i=1; AJvYcCUwP7BR6F6xI3zBC6NeF32I7yGyZvrNuDzAVRrQ2DWlDl4yuPWN7w8x1NmyyR+Xz6XPvIBCLNySBQVTXSDJWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZhONOuIIKIUJznVCMMbOj9F/PmS5ntF58K7BzUJmLB6sfshe7
	6MVhrDK+aBogwxMMexlMu9g6FX9gHQhC0idb4M+lbBsDIWNKCzTVReX5ZioLtYs8vJK/+Z0hezz
	OTc0YFUsrr3KZ3duoBssCek0MBCelFjUSA3KUQ836SCMHIoDxHgCwdyKKf+zKvU+mKtNu3SLwIi
	mmAL8vTIuUZX2dxYyItQShD8gIt6kZrGfPKHZMnZMOOIk=
X-Gm-Gg: ATEYQzx4/xC+kZjau7bPVGN1A75ZJYQAwosH0iJiJddzAus+mrhkft6bZ2XzwVDOJDQ
	zRgTd9gC8S39GDF4EwOZP8DsTSqKLYX/+4XGAS6dge8L8Wd3Dc+pXLdOXHE0hPaXWmemm+FcPmH
	mgRzYGJoZg7vBD1cvyPKwyMWGKcOzG2F7Wk+iYRlBA3aTx7G1gCtwJeEq0wR+9637mP7OyG9rwR
	B2yn0c=
X-Received: by 2002:a17:903:41d2:b0:2b0:5cee:c405 with SMTP id d9443c01a7336-2b06e4420bemr18490265ad.52.1773807087386;
        Tue, 17 Mar 2026 21:11:27 -0700 (PDT)
X-Received: by 2002:a17:903:41d2:b0:2b0:5cee:c405 with SMTP id
 d9443c01a7336-2b06e4420bemr18490045ad.52.1773807086988; Tue, 17 Mar 2026
 21:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260313075930.105466-1-xuanzhuo@linux.alibaba.com>
 <20260313075930.105466-2-xuanzhuo@linux.alibaba.com> <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
In-Reply-To: <CACGkMEv_Fu5wsS3DKuOn3pLjqAssPEV7GXn0702t2pOLYHfwHA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Mar 2026 12:11:15 +0800
X-Gm-Features: AaiRm52-x9kX4d0uBozSKicaMMtLvo5jnpGEBBzaMIMSdMXnla2mqzEY4pPxfpM
Message-ID: <CACGkMEutuueTx_QhEa9gV72NYTqaGD=69YvMKG=RcmEfdrJKhQ@mail.gmail.com>
Subject: Re: [PATCH net v10 1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Alvaro Karsz <alvaro.karsz@solid-run.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mb2FYTA-lm-XKmFMbvHkgiofXRTTttCtRYwPQ18gfEI_1773807087
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 12:07=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Fri, Mar 13, 2026 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The commit be50da3e9d4a ("net: virtio_net: implement exact header lengt=
h
> > guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> > feature in virtio-net.
> >
> > This feature requires virtio-net to set hdr_len to the actual header
> > length of the packet when transmitting, the number of
> > bytes from the start of the packet to the beginning of the
> > transport-layer payload.
> >
> > However, in practice, hdr_len was being set using skb_headlen(skb),
> > which is clearly incorrect. This commit fixes that issue.
> >
> > Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length gu=
est feature")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/tun_vnet.h     |  2 +-
> >  drivers/net/virtio_net.c   |  6 +++++-
> >  include/linux/virtio_net.h | 33 +++++++++++++++++++++++++++++----
> >  3 files changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> > index a5f93b6c4482..fa5cab9d3e55 100644
> > --- a/drivers/net/tun_vnet.h
> > +++ b/drivers/net/tun_vnet.h
> > @@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
> >
> >         if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
> >                                         tun_vnet_is_little_endian(flags=
),
> > -                                       vlan_hlen, true)) {
> > +                                       vlan_hlen, true, false)) {
> >                 struct virtio_net_hdr_v1 *hdr =3D &tnl_hdr->hash_hdr.hd=
r;
> >                 struct skb_shared_info *sinfo =3D skb_shinfo(skb);
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 72d6a9c6a5a2..7106333ef904 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3267,8 +3267,12 @@ static int xmit_skb(struct send_queue *sq, struc=
t sk_buff *skb, bool orphan)
> >         struct virtio_net_hdr_v1_hash_tunnel *hdr;
> >         int num_sg;
> >         unsigned hdr_len =3D vi->hdr_len;
> > +       bool feature_hdrlen;
> >         bool can_push;
> >
> > +       feature_hdrlen =3D virtio_has_feature(vi->vdev,
> > +                                           VIRTIO_NET_F_GUEST_HDRLEN);
> > +
> >         pr_debug("%s: xmit %p %pM\n", vi->dev->name, skb, dest);
> >
> >         /* Make sure it's safe to cast between formats */
> > @@ -3288,7 +3292,7 @@ static int xmit_skb(struct send_queue *sq, struct=
 sk_buff *skb, bool orphan)
> >
> >         if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
> >                                         virtio_is_little_endian(vi->vde=
v), 0,
> > -                                       false))
> > +                                       false, feature_hdrlen))
> >                 return -EPROTO;
> >
> >         if (vi->mergeable_rx_bufs)
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 75dabb763c65..48de4a16a96a 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -207,6 +207,22 @@ static inline int virtio_net_hdr_to_skb(struct sk_=
buff *skb,
> >         return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gs=
o_type);
> >  }
> >
> > +static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
> > +                                        struct virtio_net_hdr *hdr,
> > +                                        bool little_endian)
> > +{
> > +       u16 hdr_len;
> > +
> > +       hdr_len =3D skb_transport_offset(skb);
> > +
> > +       if (hdr->gso_type =3D=3D VIRTIO_NET_HDR_GSO_UDP_L4)
> > +               hdr_len +=3D sizeof(struct udphdr);
> > +       else
> > +               hdr_len +=3D tcp_hdrlen(skb);
>
> Ok, I think this depends on the logic inside virtio_net_hdr_from_skb()
>
>                 if (sinfo->gso_type & SKB_GSO_TCPV4)
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV4;
>                 else if (sinfo->gso_type & SKB_GSO_TCPV6)
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_TCPV6;
>                 else if (sinfo->gso_type & SKB_GSO_UDP_L4)
>                         hdr->gso_type =3D VIRTIO_NET_HDR_GSO_UDP_L4;
>         else
>                         return -EINVAL;
>
> To be more robust, I'd suggest moving it there.
>
> But I have another question, the logic above depends on the headlen is
> correctly set:
>
>                 /* This is a hint as to how much should be linear. */
>                 hdr->hdr_len =3D __cpu_to_virtio16(little_endian,
>                                                  skb_headlen(skb));
>
> Is the headlen guaranteed to be correct in all cases (e.g for nested
> setups or dodgy packets?)

Speak too fast, I miss

hdr_len =3D skb_transport_offset(skb);

This is probably another call to

1) Move virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb() or
2) call virtio_net_set_hdrlen() inside virtio_net_hdr_from_skb().

Thanks

>
> Thanks
>
> > +
> > +       hdr->hdr_len =3D __cpu_to_virtio16(little_endian, hdr_len);
> > +}
> > +
> >  static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
> >                                           struct virtio_net_hdr *hdr,
> >                                           bool little_endian,
> > @@ -385,7 +401,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *s=
kb,
> >                             bool tnl_hdr_negotiated,
> >                             bool little_endian,
> >                             int vlan_hlen,
> > -                           bool has_data_valid)
> > +                           bool has_data_valid,
> > +                           bool feature_hdrlen)
> >  {
> >         struct virtio_net_hdr *hdr =3D (struct virtio_net_hdr *)vhdr;
> >         unsigned int inner_nh, outer_th;
> > @@ -394,9 +411,17 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *=
skb,
> >
> >         tnl_gso_type =3D skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNE=
L |
> >                                                     SKB_GSO_UDP_TUNNEL_=
CSUM);
> > -       if (!tnl_gso_type)
> > -               return virtio_net_hdr_from_skb(skb, hdr, little_endian,
> > -                                              has_data_valid, vlan_hle=
n);
> > +       if (!tnl_gso_type) {
> > +               ret =3D virtio_net_hdr_from_skb(skb, hdr, little_endian=
,
> > +                                             has_data_valid, vlan_hlen=
);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               if (feature_hdrlen && hdr->hdr_len)
> > +                       virtio_net_set_hdrlen(skb, hdr, little_endian);
> > +
> > +               return ret;
> > +       }
> >
> >         /* Tunnel support not negotiated but skb ask for it. */
> >         if (!tnl_hdr_negotiated)
> > --
> > 2.32.0.3.g01195cf9f
> >

