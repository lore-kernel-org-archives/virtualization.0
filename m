Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7F18C03F
	for <virtualization@lists.linux.dev>; Tue, 29 Jul 2025 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756869; cv=none; b=V9JO4DHJy1aqBOe6UD7oDCYeC675BE3GLxfEXVqBi8vbCHEDFl4zUY5YHLOYgo0RwWAB4KViKH4380d1FCDkkQVyyeLPUEebnYIUnMErIs5lfzUfvbmWbRWgH8msLAAWCdzyKpz9de9ENbfgupYt+p2NK+iV3XjyWByogcdgSf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756869; c=relaxed/simple;
	bh=X309qTXiUmXcWUW47hmX5f9RiETUsGDeMR4fFUgVZok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAwV7EnKIclDRoqxgdrqL89Eub9JLAXyvqXw5MfZYSqeuJstKNkBXyNxqlX78jtwL70E3NWmljiVvYFE9q7up5+VJqS0tbZOTc8EtZrWZaIEfm+8y1/gthr4BzibACOg3RZ0wUlNO3T25pCETKmgQ5uLsvyiVmXokU7T/nFKqxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrWvErKz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrWvErKz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753756866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHAAqXw/KuXP6KCHImnMfYHqGrLwhp1YW8sP9wzIXaE=;
	b=MrWvErKz5NmKII7jtZGwEMiCq9YeDq3WpPBd40vnT7nB/huGTKLE3QqqIOOY9X0aOG8yeY
	xYpTohcPnD6B52k2TacHBdqHmHKcNEcWg4ofk5YbE2E/EO8ie7dIHRgodADxT5xRXr457q
	mIKGyojOUcft6sAxk7uKlZBOAAhm6bE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-xcn8Eo7BOuWD3TTlSCdT_w-1; Mon, 28 Jul 2025 22:41:05 -0400
X-MC-Unique: xcn8Eo7BOuWD3TTlSCdT_w-1
X-Mimecast-MFC-AGG-ID: xcn8Eo7BOuWD3TTlSCdT_w_1753756864
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31f32271a1fso296491a91.0
        for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 19:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756864; x=1754361664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHAAqXw/KuXP6KCHImnMfYHqGrLwhp1YW8sP9wzIXaE=;
        b=k0tPiZkZy/9n5wqI8QE4DZiqH59jGguTZa8CcC2tQ4dDwPLlZJv8Qu9Kl929dDwrUc
         QXxa349TPJPns4gfZsfT6uACqNI93EhGUIokMPW7RGdYCv5yYUky0za9Ian86Rksm7fV
         8I1mpQJw/+g0sP9MN7quclWcYcgjL+vRNcvQl9iZ3x44RAs/HbufxO9t+bW4O7yl2BAI
         zTqoe6xg8vLjtBm84FO8ZOPidZ0mDeMMAKpo0T5VyTFm54bRkpWwc7KLfmLemj2QijlK
         50QEqNZJcxbOApugMar4HRFFCO8IfP8/c5zJFa88ICjajGWD9UHfyrGTQMlnh4awPUuI
         iazg==
X-Forwarded-Encrypted: i=1; AJvYcCUce4Xb4kk4wUqEpTLSDL9JNibq/nhbxjZ7XUJMmbj7YoUkHWJbJdc6YLaHUAxzb/MT7V/8YxxEjYzq1+IB7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwoYlAetkKcocQ1ihg1e+9BU04lyyScAfRq0g4HbL3yiodVd6ve
	myMOYw0plyYo6sBVebpSdtXku3MlKbBkA+jWdjyPMLXjoUZx4nfMj0TNQq71tWzQCG8COJz61xZ
	UyLiZH8UD2YejyOjrNaZkx0V2zHb1xZsKdYeKvD71Ww5zTLZM8cewaX1oFheD3JM+A9+b/08RYe
	ld/MnwohMfqUTTF3tha3hIPoYzTMi9+4b5jCdoLudwOFg=
X-Gm-Gg: ASbGncuqzBeGTRQ06AsZijoid5CaaIYkKMFb+lFiWnz5LOe/2Pgfz1KHjBiyWk3Viqe
	utczduBW3fOSJ6Ki4JUA1ngYT72Eadz80VVoScDKP6wE4LhUuQr70U3fIIkQ1aZO2iE1j0lLfqr
	gCML1U9O0VlOLfvnlfK4o=
X-Received: by 2002:a17:90b:53c6:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-31f28cc103bmr2607646a91.13.1753756863927;
        Mon, 28 Jul 2025 19:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcQejW7k/8dP6hOLwNt4pKjQZBInzGCnHmY7rDBeaCFzof5J/jzWQYd1AedFT1fTNe/pYL8sgxdB4R01T/1CY=
X-Received: by 2002:a17:90b:53c6:b0:313:d361:73d7 with SMTP id
 98e67ed59e1d1-31f28cc103bmr2607620a91.13.1753756863474; Mon, 28 Jul 2025
 19:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250724083005.3918375-1-wangliang74@huawei.com>
 <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
 <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com> <68865594e28d8_9f93f29443@willemb.c.googlers.com.notmuch>
 <68865ecee5cc4_b1f6a29442@willemb.c.googlers.com.notmuch> <CACGkMEvAWj5CFPwXx=zWjvZnMUYBORuXm-mMQe89P8xdBRid5w@mail.gmail.com>
 <CAF=yD-+Mzk0ibfgByXqiS_y=FoKqLVtATKQF4PPpUL4Pk8hosw@mail.gmail.com>
In-Reply-To: <CAF=yD-+Mzk0ibfgByXqiS_y=FoKqLVtATKQF4PPpUL4Pk8hosw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Jul 2025 10:40:52 +0800
X-Gm-Features: Ac12FXzzqIS2NvTpn0ksYhOGQwfypqEKPmDB9p0TZTS8VxgjhLHI2isMfShyY3I
Message-ID: <CACGkMEvL0_6a1u0riEbQV-oVem_vfnTy48X2H3RcXF_MgL-zZg@mail.gmail.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in virtio_net_hdr_to_skb()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Wang Liang <wangliang74@huawei.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	willemb@google.com, atenart@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	steffen.klassert@secunet.com, tobias@strongswan.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: arOMBffkCXWTMWU4pXfHDuQgzUnew0eaqe1KD8-sihk_1753756864
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:51=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Sun, Jul 27, 2025 at 11:21=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Mon, Jul 28, 2025 at 1:16=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Willem de Bruijn wrote:
> > > > Wang Liang wrote:
> > > > >
> > > > > =E5=9C=A8 2025/7/24 21:29, Willem de Bruijn =E5=86=99=E9=81=93:
> > > > > > Wang Liang wrote:
> > > > > >> When sending a packet with virtio_net_hdr to tun device, if th=
e gso_type
> > > > > >> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than=
 udphdr
> > > > > >> size, below crash may happen.
> > > > > >>
> > > > > > gso_size is the size of the segment payload, excluding the tran=
sport
> > > > > > header.
> > > > > >
> > > > > > This is probably not the right approach.
> > > > > >
> > > > > > Not sure how a GSO skb can be built that is shorter than even t=
he
> > > > > > transport header. Maybe an skb_dump of the GSO skb can be eluci=
dating.
> > > > > >>                          return -EINVAL;
> > > > > >>
> > > > > >>                  /* Too small packets are not really GSO ones.=
 */
> > > > > >> --
> > > > > >> 2.34.1
> > > > > >>
> > > > >
> > > > > Thanks for your review!
> > > >
> > > > Thanks for the dump and repro.
> > > >
> > > > I can indeed reproduce, only with the UDP_ENCAP_ESPINUDP setsockopt=
.
> > > >
> > > > > Here is the skb_dump result:
> > > > >
> > > > >      skb len=3D4 headroom=3D98 headlen=3D4 tailroom=3D282
> > > > >      mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > > >      shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=
=3D0))
> > > > >      csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete_sw=
=3D0 valid=3D1 level=3D0)
> > > >
> > > > So this is as expected not the original GSO skb, but a segment,
> > > > after udp_rcv_segment from udp_queue_rcv_skb.
> > > >
> > > > It is a packet with skb->data pointing to the transport header, and
> > > > only 4B length. So this is an illegal UDP packet with length shorte=
r
> > > > than sizeof(struct udphdr).
> > > >
> > > > The packet does not enter xfrm4_gro_udp_encap_rcv, so we can exclud=
e
> > > > that.
> > > >
> > > > It does enter __xfrm4_udp_encap_rcv, which will return 1 because th=
e
> > > > pskb_may_pull will fail. There is a negative integer overflow just
> > > > before that:
> > > >
> > > >         len =3D skb->len - sizeof(struct udphdr);
> > > >         if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)=
))
> > > >                 return 1;
> > > >
> > > > This is true for all the segments btw, not just the last one. On
> > > > return of 1 here, the packet does not enter encap_rcv but gets
> > > > passed to the socket as a normal UDP packet:
> > > >
> > > >       /* If it's a keepalive packet, then just eat it.
> > > >        * If it's an encapsulated packet, then pass it to the
> > > >        * IPsec xfrm input.
> > > >        * Returns 0 if skb passed to xfrm or was dropped.
> > > >        * Returns >0 if skb should be passed to UDP.
> > > >        * Returns <0 if skb should be resubmitted (-ret is protocol)
> > > >        */
> > > >       int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
> > > >
> > > > But so the real bug, an skb with 4B in the UDP layer happens before
> > > > that.
> > > >
> > > > An skb_dump in udp_queue_rcv_skb of the GSO skb shows
> > > >
> > > > [  174.151409] skb len=3D190 headroom=3D64 headlen=3D190 tailroom=
=3D66
> > > > [  174.151409] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > > [  174.151409] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D4 type=3D=
65538 segs=3D0))
> > > > [  174.151409] csum(0x8c start=3D140 offset=3D0 ip_summed=3D3 compl=
ete_sw=3D0 valid=3D1 level=3D0)
> > > > [  174.151409] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 i=
if=3D8
> > > > [  174.151409] priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_all=3D0=
x0
> > > > [  174.151409] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > > > [  174.152101] dev name=3Dtun0 feat=3D0x00002000000048c1
> > > >
> > > > And of segs[0] after segmentation
> > > >
> > > > [  103.081442] skb len=3D38 headroom=3D64 headlen=3D38 tailroom=3D2=
18
> > > > [  103.081442] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > > [  103.081442] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D=
0 segs=3D0))
> > > > [  103.081442] csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 compl=
ete_sw=3D0 valid=3D1 level=3D0)
> > > > [  103.081442] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 i=
if=3D8
> > > > [  103.081442] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0=
x0
> > > > [  103.081442] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > > >
> > > > So here translen is already 38 - (98-64) =3D=3D 38 - 34 =3D=3D 4.
> > > >
> > > > So the bug happens in segmentation.
> > > >
> > > > [ongoing ..]
> > >
> > > Oh of course, this is udp fragmentation offload (UFO):
> > > VIRTIO_NET_HDR_GSO_UDP.
> > >
> > > So only the first packet has an UDP header, and that explains why the
> > > other packets are only 4B.
> > >
> > > They are not UDP packets, but they have already entered the UDP stack
> > > due to this being GSO applied in udp_queue_rcv_skb.
> > >
> > > That was never intended to be used for UFO. Only for GRO, which does
> > > not build such packets.
> > >
> > > Maybe we should just drop UFO (SKB_GSO_UDP) packets in this code path=
?
> > >
> >
> > Just to make sure I understand this. Did you mean to disable UFO for
> > guest -> host path? If yes, it seems can break some appllication.
>
> No, I mean inside the special segmentation path inside UDP receive.
>
> I know that we have to keep UFO segmentation around because existing
> guests may generate those packets and these features cannot be
> re-negotiated once enabled, even on migration. But no new kernel
> generates UFO packets.
>
> Segmentation inside UDP receive was added when UDP_GRO was added, in
> case packets accidentally add up at a local socket receive path that
> does not support large packets.
>
> Since GRO never builds UFO packets, such packets should not arrive at
> such sockets to begin with.
>
> Evidently we forgot about looping virtio_net_hdr packets. They were
> never intended to be supported in this new path, nor clearly have they
> ever worked. We just need to mitigate them without crashing.

Thanks a lot for the clarification. It's clear to me now.

>

