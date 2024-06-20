Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE26198A3D
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872432; cv=none; b=ptVRzrswpdrxqIPS12C9byFmOqfyBOj1MvvZnR2IJZtsjHg623IwMSyUQefik1f1cn0GPZgKjzdOgiRQCbd+YhNWDUn7JwuVdZMVkodRzDKyI7l5InmmB/bIs5U9PjJowDjV+nS354T4bTQAmbxdHn+wGjCdamYPe1VyDgN2NiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872432; c=relaxed/simple;
	bh=OhHl3cubLC2ElEa6jshu88vLm36s5JQwNJLOGYJ3Stk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEM1HpahjWbc8a7QAbMVoKg0Dlbtcqd9Se6pX2CMUZBCoF4c0PFV834LVW2/8jDjiUpDgqi8HQdLWdlt5bhmEQ5QIuCtF9brwPPolkhgiQ0ew7dbJGqi0N9VV2/TSrh08KaejsaS+tZXb9ou+8RlKYyZrEYQ8S7v/yXKXyrHeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/WEBzxy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/WEBzxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RAf8OOLdOi92nbcqZgYR6aQ8iABZQNty4/XaT+HRrqY=;
	b=M/WEBzxyOCJP4XN+6MRscfWd5N5LVs5d3DIvSUMc2SMRu+pUgWtiQ2rSLarxMAtBkNHSxt
	MbPnKj7i+leEVVtESbYqTj7d4csv8gaskqQ7mBOmaO7T/MmJVZpA+hWGVNcAK6r5dN7UN6
	poy2A96PMtIX2lJFdlR9iHncdZVeSU4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-Q1AIPtqtMcOoPa-UcWQPDQ-1; Thu, 20 Jun 2024 04:33:47 -0400
X-MC-Unique: Q1AIPtqtMcOoPa-UcWQPDQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c7c3069edcso727007a91.3
        for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 01:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872426; x=1719477226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAf8OOLdOi92nbcqZgYR6aQ8iABZQNty4/XaT+HRrqY=;
        b=ukcbM0WLiKKRtbDwixmLylV+u/6RQvOHIHhV/zhXZ/Kbq/06iSdkhKC4rGOpOlcSvK
         ZKhs1NEGYzLzDgB2tWzFS1fl99GwwMpU3g+QYcVbzPOeRVIbT6e+gGYCW/a0x3d8BxcN
         Vc9vSQuy/agXJK2PIdiYkfa7QMd4xyxSPvKIxelav2I2QXMEj7xKQhnTWiQEp2UGz5Uy
         fxmhdXoIGz8F3LVva03QNrftWnxMkGGP6yAAZ3itV1gxC9vemMRPvChXWF8Nn9ERMV03
         +SkKFMLyvDUCQMAYePySxt9Vb60s82E1vHqNS1+Jsm+EvPauRjikY0Yq/eCSXL3Sx6Gb
         bS1g==
X-Forwarded-Encrypted: i=1; AJvYcCVaiMHA+SUHkX+Uz/wYtmIrBLCeUcTn97LQPKFBXAQ1cRTZ65NoLy8QkmNgwX+uzCWeagrboHou4OsSgPH3G1rCjZ/2O+vmS2c/xoPllSo=
X-Gm-Message-State: AOJu0YxuEKBSK82mfYqnLV7CPJgcZ6SiC74ylOBSYmLQ6RXUuZENtvK1
	0d7HY6D7aeWwvhKMc+5De+4wNkw6vng05qom4DKiEoyaDMmC91FKBYOINfUhIKVa/Budu4ph3fx
	DCB60ki2QDbDZ6pC+yb9ofm7bkO/YLdQzHxTOVICP68PjOalZa6nVZT01pHL1xiCEZ8tkbfWL/x
	ibvvENcBXp/pKys+5dKsK4A6ZszTHB3WvxdPqeipw=
X-Received: by 2002:a17:90b:315:b0:2c2:d163:d761 with SMTP id 98e67ed59e1d1-2c7b5dcad23mr4216928a91.47.1718872426476;
        Thu, 20 Jun 2024 01:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtclsJ1DzM1k1AttD7dXj8MDAc1nEy0oMQ6NMqr3QbglP89bS/Tp10eDZkM20ZkAhePxoxpE1UyODQFdfHB6A=
X-Received: by 2002:a17:90b:315:b0:2c2:d163:d761 with SMTP id
 98e67ed59e1d1-2c7b5dcad23mr4216906a91.47.1718872426069; Thu, 20 Jun 2024
 01:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-3-hengqi@linux.alibaba.com> <CACGkMEvj8fvXkCxDFQ1-Cyq5DL=axEf1Ch1zVnuQUNQy6Wjn+g@mail.gmail.com>
 <1718680517.8370645-12-hengqi@linux.alibaba.com>
In-Reply-To: <1718680517.8370645-12-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:33:35 +0800
Message-ID: <CACGkMEsa3AsPkweqS0-BEjSw5sKW_XM669HVSN_eX7-8KVG8tQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio_net: fixing XDP for fully checksummed packets handling
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Thomas Huth <thuth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:17=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
> On Tue, 18 Jun 2024 11:10:26 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Mon, Jun 17, 2024 at 9:15=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> > >
> > > The XDP program can't correctly handle partially checksummed
> > > packets, but works fine with fully checksummed packets.
> >
> > Not sure this is ture, if I was not wrong, XDP can try to calculate che=
cksum.
>
> XDP's interface serves a full checksum,

What do you mean by "serve" here? I mean, XDP can calculate the
checksum and fill it in the packet by itself.

> and this is why we disabled the
> offloading of VIRTIO_NET_F_GUEST_CSUM when loading XDP.

If we trust the device to disable VIRTIO_NET_F_GUEST_CSUM, any reason
to check VIRTIO_NET_HDR_F_NEEDS_CSUM again in the receive path?

>
> Thanks.

Thanks

>
> >
> > Thanks
> >
> > > If the
> > > device has already validated fully checksummed packets, then
> > > the driver doesn't need to re-validate them, saving CPU resources.
> > >
> > > Additionally, the driver does not drop all partially checksummed
> > > packets when VIRTIO_NET_F_GUEST_CSUM is not negotiated. This is
> > > not a bug, as the driver has always done this.
> > >
> > > Fixes: 436c9453a1ac ("virtio-net: keep vnet header zeroed after proce=
ssing XDP")
> > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index aa70a7ed8072..ea10db9a09fa 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1360,6 +1360,10 @@ static struct sk_buff *receive_small_xdp(struc=
t net_device *dev,
> > >         if (unlikely(hdr->hdr.gso_type))
> > >                 goto err_xdp;
> > >
> > > +       /* Partially checksummed packets must be dropped. */
> > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > > +               goto err_xdp;
> > > +
> > >         buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> > >                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > >
> > > @@ -1677,6 +1681,10 @@ static void *mergeable_xdp_get_buf(struct virt=
net_info *vi,
> > >         if (unlikely(hdr->hdr.gso_type))
> > >                 return NULL;
> > >
> > > +       /* Partially checksummed packets must be dropped. */
> > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > > +               return NULL;
> > > +
> > >         /* Now XDP core assumes frag size is PAGE_SIZE, but buffers
> > >          * with headroom may add hole in truesize, which
> > >          * make their length exceed PAGE_SIZE. So we disabled the
> > > @@ -1943,6 +1951,7 @@ static void receive_buf(struct virtnet_info *vi=
, struct receive_queue *rq,
> > >         struct net_device *dev =3D vi->dev;
> > >         struct sk_buff *skb;
> > >         struct virtio_net_common_hdr *hdr;
> > > +       u8 flags;
> > >
> > >         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > >                 pr_debug("%s: short packet %i\n", dev->name, len);
> > > @@ -1951,6 +1960,15 @@ static void receive_buf(struct virtnet_info *v=
i, struct receive_queue *rq,
> > >                 return;
> > >         }
> > >
> > > +       /* 1. Save the flags early, as the XDP program might overwrit=
e them.
> > > +        * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA=
_VALID
> > > +        * stay valid after XDP processing.
> > > +        * 2. XDP doesn't work with partially checksummed packets (re=
fer to
> > > +        * virtnet_xdp_set()), so packets marked as
> > > +        * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP process=
ing.
> > > +        */
> > > +       flags =3D ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> > > +
> > >         if (vi->mergeable_rx_bufs)
> > >                 skb =3D receive_mergeable(dev, vi, rq, buf, ctx, len,=
 xdp_xmit,
> > >                                         stats);
> > > @@ -1966,7 +1984,7 @@ static void receive_buf(struct virtnet_info *vi=
, struct receive_queue *rq,
> > >         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report=
)
> > >                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
> > >
> > > -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > +       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > >                 skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> > >
> > >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > --
> > > 2.32.0.3.g01195cf9f
> > >
> >
>

