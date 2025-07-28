Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD51B4223
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 03:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753672900; cv=none; b=bAmPfVbQUvhzq4+MQi9B64dL0yvsEx7FPUTFrgjhZ/vtBdSI8mAU7IK8rwjnfmlfLdnMkZUoXLbYxstmAy/ss4FnMVDxGPZ7Qleh8EltBqT1iec/hXK3+a7uwzagGZAR37FpA5moZXlB96J1Q5DLmCRn9nSmrfAKRrfaGOkuUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753672900; c=relaxed/simple;
	bh=ranwJpDq+s/nHhdX0GBAZg76ioFUtTcyNKNp4YMz8J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWKxvT1G6B7r7TgfE/sfBxcksGO4m5N1NiNx0or+QaYOtWkpVgJBz7+Se7rpgeskPA4cSTCP3TBMayMYewZTdCbc+3+EgyLj/iNbb85gMWEvGw4N1Tp2UQb47G1WywoDfc7dFbMT7uxrhxLBUl9KkWINi2V1Aa3KHOLTKtuAaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vmq8YFFD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vmq8YFFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753672897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XI8OOSaHaHWtnPJmvq6xO7D0eR+xt3wRvYbWtpVVRMo=;
	b=Vmq8YFFDCqaOO2O2wzw2j1yy+XcKUO/UtnUWL2bU6VhLJcwyO6sT7mSEY7arB5xtf9mWW0
	LjRzirpZfBIHybbDoGoXj4yuBJVMtSYAioVk8F5inx3jfT8XAGrjx09/TBoEXMXlDwtceU
	b2Z3X7uHlS+q94Z/FIuCi5bzF8NMKlw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-dgTBcQv7Olunbrw9fvVJYg-1; Sun, 27 Jul 2025 23:21:34 -0400
X-MC-Unique: dgTBcQv7Olunbrw9fvVJYg-1
X-Mimecast-MFC-AGG-ID: dgTBcQv7Olunbrw9fvVJYg_1753672894
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-315af0857f2so3526516a91.0
        for <virtualization@lists.linux.dev>; Sun, 27 Jul 2025 20:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753672893; x=1754277693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI8OOSaHaHWtnPJmvq6xO7D0eR+xt3wRvYbWtpVVRMo=;
        b=o5W2naaAe3iLRsxKWjNLfFzLu+0cFZN+dMrAWxtQv+cXX0fSmHpLa2TTuikuHwNh5w
         pROwCOXRubJ/nbkVtVl9Bn7U5k+GPlTj1W7Y+ZklJsH93Ot20MOTG5GRWRSjH1h5zeyH
         e92HDO307Cs+y7kQvP4DPGwgf3iHt0FYgxKL0t2YlbGnNdISfrOHB5wRtaghErj9NMlx
         ENPggEAN5hbBU74C9ACNGU4nDauD7IqNSMYgBKZcGEYjGl/PmoZpldDD+vvLih0JsFg3
         hYRsvkaPQ1c0vUE9neGKYcdeShFjbwwlAmkZ9MLpGFbFcaPbG6vo/OPqhD848G6UjiLp
         sejg==
X-Forwarded-Encrypted: i=1; AJvYcCV8YGP1UQ+MKtxIcSzZomRcB+F+FSrH4MIHp8JzqLv5BvX+owoI6w3Yzc4mHRHwginN7Wt0/qqtXVfwT0pX7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4k2pyDQ3vC2qV1NXotCYhqOtjr3fQKXSH96SlwQMz2TapBy0H
	ICgiXLzVnMC1+TsDI6u415s3Jpax1o1ePDQPz0dcm8RrxlxbEKp+yLva8Q1wznEGzHQ6xGS/QHI
	JBVx1pcyhWj1/H2LFcnXyurHc4v0CoACYAdAmtBnb8HHeg9RUzVAnuOyH1JrAqRSABnHZaiSLG2
	CJ65MWhaRBhWqmCmovefwzxtDr1OD9zYR5rEoaZSp6Wb0=
X-Gm-Gg: ASbGncsqDgwKUFaoUteuXnh4BWikBeiD92GA5l9Jb6YNeh11kdhHOjmsVgZ/X6JYqAc
	wXb4yx79Yd82ZVadYuoPxEHlsKt0upAETPSS6czuNW8xocwiV6r4ab2on0mDtR/Xq7Jsjs7px6b
	OUb1QBuyBeMRPU5HqU+4E=
X-Received: by 2002:a17:90b:3504:b0:31e:cee1:c5c8 with SMTP id 98e67ed59e1d1-31ecee1c6dcmr4817078a91.28.1753672893457;
        Sun, 27 Jul 2025 20:21:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSlqSe2OsAbJuQ+OGVDSursNusPld6YrSDy79DnCsi576lzSxxvZjmPD0X3HqEd6mNeNZlTR7T/WAcgjCYR64=
X-Received: by 2002:a17:90b:3504:b0:31e:cee1:c5c8 with SMTP id
 98e67ed59e1d1-31ecee1c6dcmr4817031a91.28.1753672892912; Sun, 27 Jul 2025
 20:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250724083005.3918375-1-wangliang74@huawei.com>
 <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
 <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com> <68865594e28d8_9f93f29443@willemb.c.googlers.com.notmuch>
 <68865ecee5cc4_b1f6a29442@willemb.c.googlers.com.notmuch>
In-Reply-To: <68865ecee5cc4_b1f6a29442@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 28 Jul 2025 11:21:21 +0800
X-Gm-Features: Ac12FXz6a7o5M5SxnSMvRQw1N-9sqUY7N9iqXichU4KpeMgKJSB_UCRDqTxnSaM
Message-ID: <CACGkMEvAWj5CFPwXx=zWjvZnMUYBORuXm-mMQe89P8xdBRid5w@mail.gmail.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in virtio_net_hdr_to_skb()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Wang Liang <wangliang74@huawei.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	willemb@google.com, atenart@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	steffen.klassert@secunet.com, tobias@strongswan.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tpLRdZ-d-OTQ0Y05xqyRdP7-hD6iadTnsFq3fRF0L9Y_1753672894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 1:16=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Willem de Bruijn wrote:
> > Wang Liang wrote:
> > >
> > > =E5=9C=A8 2025/7/24 21:29, Willem de Bruijn =E5=86=99=E9=81=93:
> > > > Wang Liang wrote:
> > > >> When sending a packet with virtio_net_hdr to tun device, if the gs=
o_type
> > > >> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udp=
hdr
> > > >> size, below crash may happen.
> > > >>
> > > > gso_size is the size of the segment payload, excluding the transpor=
t
> > > > header.
> > > >
> > > > This is probably not the right approach.
> > > >
> > > > Not sure how a GSO skb can be built that is shorter than even the
> > > > transport header. Maybe an skb_dump of the GSO skb can be elucidati=
ng.
> > > >>                          return -EINVAL;
> > > >>
> > > >>                  /* Too small packets are not really GSO ones. */
> > > >> --
> > > >> 2.34.1
> > > >>
> > >
> > > Thanks for your review!
> >
> > Thanks for the dump and repro.
> >
> > I can indeed reproduce, only with the UDP_ENCAP_ESPINUDP setsockopt.
> >
> > > Here is the skb_dump result:
> > >
> > >      skb len=3D4 headroom=3D98 headlen=3D4 tailroom=3D282
> > >      mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > >      shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
> > >      csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete_sw=3D0 v=
alid=3D1 level=3D0)
> >
> > So this is as expected not the original GSO skb, but a segment,
> > after udp_rcv_segment from udp_queue_rcv_skb.
> >
> > It is a packet with skb->data pointing to the transport header, and
> > only 4B length. So this is an illegal UDP packet with length shorter
> > than sizeof(struct udphdr).
> >
> > The packet does not enter xfrm4_gro_udp_encap_rcv, so we can exclude
> > that.
> >
> > It does enter __xfrm4_udp_encap_rcv, which will return 1 because the
> > pskb_may_pull will fail. There is a negative integer overflow just
> > before that:
> >
> >         len =3D skb->len - sizeof(struct udphdr);
> >         if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)))
> >                 return 1;
> >
> > This is true for all the segments btw, not just the last one. On
> > return of 1 here, the packet does not enter encap_rcv but gets
> > passed to the socket as a normal UDP packet:
> >
> >       /* If it's a keepalive packet, then just eat it.
> >        * If it's an encapsulated packet, then pass it to the
> >        * IPsec xfrm input.
> >        * Returns 0 if skb passed to xfrm or was dropped.
> >        * Returns >0 if skb should be passed to UDP.
> >        * Returns <0 if skb should be resubmitted (-ret is protocol)
> >        */
> >       int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
> >
> > But so the real bug, an skb with 4B in the UDP layer happens before
> > that.
> >
> > An skb_dump in udp_queue_rcv_skb of the GSO skb shows
> >
> > [  174.151409] skb len=3D190 headroom=3D64 headlen=3D190 tailroom=3D66
> > [  174.151409] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > [  174.151409] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D4 type=3D6553=
8 segs=3D0))
> > [  174.151409] csum(0x8c start=3D140 offset=3D0 ip_summed=3D3 complete_=
sw=3D0 valid=3D1 level=3D0)
> > [  174.151409] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=
=3D8
> > [  174.151409] priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_all=3D0x0
> > [  174.151409] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0=
, trans=3D0)
> > [  174.152101] dev name=3Dtun0 feat=3D0x00002000000048c1
> >
> > And of segs[0] after segmentation
> >
> > [  103.081442] skb len=3D38 headroom=3D64 headlen=3D38 tailroom=3D218
> > [  103.081442] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > [  103.081442] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 se=
gs=3D0))
> > [  103.081442] csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete_=
sw=3D0 valid=3D1 level=3D0)
> > [  103.081442] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=
=3D8
> > [  103.081442] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
> > [  103.081442] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0=
, trans=3D0)
> >
> > So here translen is already 38 - (98-64) =3D=3D 38 - 34 =3D=3D 4.
> >
> > So the bug happens in segmentation.
> >
> > [ongoing ..]
>
> Oh of course, this is udp fragmentation offload (UFO):
> VIRTIO_NET_HDR_GSO_UDP.
>
> So only the first packet has an UDP header, and that explains why the
> other packets are only 4B.
>
> They are not UDP packets, but they have already entered the UDP stack
> due to this being GSO applied in udp_queue_rcv_skb.
>
> That was never intended to be used for UFO. Only for GRO, which does
> not build such packets.
>
> Maybe we should just drop UFO (SKB_GSO_UDP) packets in this code path?
>

Just to make sure I understand this. Did you mean to disable UFO for
guest -> host path? If yes, it seems can break some appllication.

Thanks

