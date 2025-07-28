Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B831FCFFC
	for <virtualization@lists.linux.dev>; Mon, 28 Jul 2025 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753674681; cv=none; b=XL+9F1FSdKdg5YdhDe+RLh33+Tnli9TJVvC89sk+GMttViY+IRGbL/Qfd00TiasI1mnMwB5ge0Y6lzzogkA0yzFM3r4fy/p3Iq1V3X8wWkX3ErbSdMKOxCgIM8WZVPwfYwnXKmsP1NTOu3p/JfxuggndlnfPJJKXPoP2bxlvOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753674681; c=relaxed/simple;
	bh=R+Szdc9IZEupB29lbdW/bHnVnpDKxXmiFUCekZcQk1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9RfIM9Ix5FMQrnHTaQtaVod26jEmPazrQgBvp5szP1NkANnFqCp+fKBNAh+E0ujd8uy4XUZIFKKYQ/BZ6n+SQsaYofGpnSTETpo4AwH5p5s/OboGOlsMSemYrWs9TdCZCUiuc5eK4hmAtDwJA3WxtYwvAWyjgSOC6SLzriC51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAc20Ij5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAc20Ij5"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71a1a0b123eso3766477b3.0
        for <virtualization@lists.linux.dev>; Sun, 27 Jul 2025 20:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753674678; x=1754279478; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrehipaAg9x4RIFKtETchHQEThsc/Gdzu3QWzY579jk=;
        b=gAc20Ij5ptZhr3wHKTQqQyXj4VSoODyiKl0QF5GjjqYrtjvhGYIa6AwsM1CApiCRJx
         4a5fUNw5y6JC0N/WIqWk9gJVn7ldzmK08tbS7e6BVnC92EUMJnmB3ff2uPkNOW+/Wnjs
         I/SpjvNGhchDzV/6UYTR3t+ilAb4jXFYczX31ikQA4BgTYMZsChhef187yTwHXRh/IhW
         7JiczBDKf3kAkLjaXcVJeBe+NfFJtR7uD5s7CXlqfijB8hEQMogIIwy8723Kq1XZb6Tk
         iyb1RdOAMwo1SiodturNrFLTevk0BcjcZLvqo6oa7hGUNMHmGTYc3TvLpSYB/jluuYEa
         t/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753674678; x=1754279478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrehipaAg9x4RIFKtETchHQEThsc/Gdzu3QWzY579jk=;
        b=UNzlkfeDA25lab29RjB7v/DDzENVEdotVDTfSFjyZbf0Wj7FVY60iNLjaOpfc8nRYn
         zm06gO3VT3r6JOjd/HXwTEIn1mNVcqFVAfyRvrylR5LTrx+Js/YXLjYC86UCuDqNNfzv
         YC0QgfJNPsYDmH4VCNWUnOIIHK933TVTyx8611c1SkTuEIEkQc+Hec8mSig/eSDaFJcx
         LrQbFIcqwaJw4uI9qi4dP7hrVX1Ps/Ogjo0VbA4i4DKH83t43rBxFvgvV8vEFPDjJEeI
         uHWPoHZCjzzSEcbUIprj6KIlBuqyTYm02Ft3Fa1UWI7P4mhrX3J4CtZoMLxqpKVzaW6k
         dsdA==
X-Forwarded-Encrypted: i=1; AJvYcCUc95wPDwrnkmLUpFFFb9yU3/50IN9hweFAwU5+bUX5KeWUKAS8WeLJ7IkbujKtnRSoicMxl3fjmF1LZ2E0qg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcnTdbqJ5VjaCzWzEgpSYjxZ+AEZEkRT+QAdBhnVd6/Kehbcls
	VQFgWMe76qS3RGCf3tXGCERZULc25+PCziVVrvFLjonMrBQk26zmi1XLb70LjajKkZf17pFKzzM
	uB3Sx3XQFwXhrCNb/VNhDFPU8oNJubeo=
X-Gm-Gg: ASbGncsOjHRky777dcWRNbCVP73r5VvWGIdHR7FJHjZw5yg3U1R7IHAzU8OQHFYV1Vg
	o8J5rA0783hUuV/VQrMbsevqnEF8jwMTui6+iRyprdUiUakQ4mH1WyyCY/C9rZtFRHJWYLyS47k
	UlnC58hF/SgGjZHUKHhzum5gaIM0CXWTug5f6xo0WpyZ+Tn0KmI6vVjNvwxaAxr7LznKsMcfrND
	hNswuxl/vScL8Psi0rldYyCws6AvKc7vu+qW7oURA==
X-Google-Smtp-Source: AGHT+IEe8t4zH9Jep2O4bZaR1QE3V/MNiGneZNNvs4ZGlVtrTRVKeRdxtgbxH/VTFPO9qqV5hxccBCyovNKBN973ZDI=
X-Received: by 2002:a05:690c:6f02:b0:71a:2c7d:d2a0 with SMTP id
 00721157ae682-71a2c7e2642mr738037b3.12.1753674677854; Sun, 27 Jul 2025
 20:51:17 -0700 (PDT)
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
In-Reply-To: <CACGkMEvAWj5CFPwXx=zWjvZnMUYBORuXm-mMQe89P8xdBRid5w@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sun, 27 Jul 2025 23:50:40 -0400
X-Gm-Features: Ac12FXwPKd7szapBYuV4uvG7PKjftRwBqchAR0LB9d-9bKC_MUvlni1NjW3v80o
Message-ID: <CAF=yD-+Mzk0ibfgByXqiS_y=FoKqLVtATKQF4PPpUL4Pk8hosw@mail.gmail.com>
Subject: Re: [PATCH net] net: check the minimum value of gso size in virtio_net_hdr_to_skb()
To: Jason Wang <jasowang@redhat.com>
Cc: Wang Liang <wangliang74@huawei.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, pabeni@redhat.com, davem@davemloft.net, 
	willemb@google.com, atenart@kernel.org, yuehaibing@huawei.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	steffen.klassert@secunet.com, tobias@strongswan.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 11:21=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jul 28, 2025 at 1:16=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Willem de Bruijn wrote:
> > > Wang Liang wrote:
> > > >
> > > > =E5=9C=A8 2025/7/24 21:29, Willem de Bruijn =E5=86=99=E9=81=93:
> > > > > Wang Liang wrote:
> > > > >> When sending a packet with virtio_net_hdr to tun device, if the =
gso_type
> > > > >> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than u=
dphdr
> > > > >> size, below crash may happen.
> > > > >>
> > > > > gso_size is the size of the segment payload, excluding the transp=
ort
> > > > > header.
> > > > >
> > > > > This is probably not the right approach.
> > > > >
> > > > > Not sure how a GSO skb can be built that is shorter than even the
> > > > > transport header. Maybe an skb_dump of the GSO skb can be elucida=
ting.
> > > > >>                          return -EINVAL;
> > > > >>
> > > > >>                  /* Too small packets are not really GSO ones. *=
/
> > > > >> --
> > > > >> 2.34.1
> > > > >>
> > > >
> > > > Thanks for your review!
> > >
> > > Thanks for the dump and repro.
> > >
> > > I can indeed reproduce, only with the UDP_ENCAP_ESPINUDP setsockopt.
> > >
> > > > Here is the skb_dump result:
> > > >
> > > >      skb len=3D4 headroom=3D98 headlen=3D4 tailroom=3D282
> > > >      mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > >      shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0=
))
> > > >      csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete_sw=3D0=
 valid=3D1 level=3D0)
> > >
> > > So this is as expected not the original GSO skb, but a segment,
> > > after udp_rcv_segment from udp_queue_rcv_skb.
> > >
> > > It is a packet with skb->data pointing to the transport header, and
> > > only 4B length. So this is an illegal UDP packet with length shorter
> > > than sizeof(struct udphdr).
> > >
> > > The packet does not enter xfrm4_gro_udp_encap_rcv, so we can exclude
> > > that.
> > >
> > > It does enter __xfrm4_udp_encap_rcv, which will return 1 because the
> > > pskb_may_pull will fail. There is a negative integer overflow just
> > > before that:
> > >
> > >         len =3D skb->len - sizeof(struct udphdr);
> > >         if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)))
> > >                 return 1;
> > >
> > > This is true for all the segments btw, not just the last one. On
> > > return of 1 here, the packet does not enter encap_rcv but gets
> > > passed to the socket as a normal UDP packet:
> > >
> > >       /* If it's a keepalive packet, then just eat it.
> > >        * If it's an encapsulated packet, then pass it to the
> > >        * IPsec xfrm input.
> > >        * Returns 0 if skb passed to xfrm or was dropped.
> > >        * Returns >0 if skb should be passed to UDP.
> > >        * Returns <0 if skb should be resubmitted (-ret is protocol)
> > >        */
> > >       int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
> > >
> > > But so the real bug, an skb with 4B in the UDP layer happens before
> > > that.
> > >
> > > An skb_dump in udp_queue_rcv_skb of the GSO skb shows
> > >
> > > [  174.151409] skb len=3D190 headroom=3D64 headlen=3D190 tailroom=3D6=
6
> > > [  174.151409] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > [  174.151409] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D4 type=3D65=
538 segs=3D0))
> > > [  174.151409] csum(0x8c start=3D140 offset=3D0 ip_summed=3D3 complet=
e_sw=3D0 valid=3D1 level=3D0)
> > > [  174.151409] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=
=3D8
> > > [  174.151409] priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_all=3D0x0
> > > [  174.151409] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > > [  174.152101] dev name=3Dtun0 feat=3D0x00002000000048c1
> > >
> > > And of segs[0] after segmentation
> > >
> > > [  103.081442] skb len=3D38 headroom=3D64 headlen=3D38 tailroom=3D218
> > > [  103.081442] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> > > [  103.081442] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 =
segs=3D0))
> > > [  103.081442] csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complet=
e_sw=3D0 valid=3D1 level=3D0)
> > > [  103.081442] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=
=3D8
> > > [  103.081442] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
> > > [  103.081442] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=
=3D0, trans=3D0)
> > >
> > > So here translen is already 38 - (98-64) =3D=3D 38 - 34 =3D=3D 4.
> > >
> > > So the bug happens in segmentation.
> > >
> > > [ongoing ..]
> >
> > Oh of course, this is udp fragmentation offload (UFO):
> > VIRTIO_NET_HDR_GSO_UDP.
> >
> > So only the first packet has an UDP header, and that explains why the
> > other packets are only 4B.
> >
> > They are not UDP packets, but they have already entered the UDP stack
> > due to this being GSO applied in udp_queue_rcv_skb.
> >
> > That was never intended to be used for UFO. Only for GRO, which does
> > not build such packets.
> >
> > Maybe we should just drop UFO (SKB_GSO_UDP) packets in this code path?
> >
>
> Just to make sure I understand this. Did you mean to disable UFO for
> guest -> host path? If yes, it seems can break some appllication.

No, I mean inside the special segmentation path inside UDP receive.

I know that we have to keep UFO segmentation around because existing
guests may generate those packets and these features cannot be
re-negotiated once enabled, even on migration. But no new kernel
generates UFO packets.

Segmentation inside UDP receive was added when UDP_GRO was added, in
case packets accidentally add up at a local socket receive path that
does not support large packets.

Since GRO never builds UFO packets, such packets should not arrive at
such sockets to begin with.

Evidently we forgot about looping virtio_net_hdr packets. They were
never intended to be supported in this new path, nor clearly have they
ever worked. We just need to mitigate them without crashing.
