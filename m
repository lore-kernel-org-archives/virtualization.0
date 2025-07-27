Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED0137E
	for <virtualization@lists.linux.dev>; Sun, 27 Jul 2025 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753636562; cv=none; b=eWCHCgm6EKfUtLsm7lLx+e/do530l2PRaToI7YBwDKHjvRBMh7B3EvKcl6gdF6Cs5WexucI2VpWqLkB0a/JlyZfTUPZAzLVp2fthAkZ9fMNz4VEpXCZCUG6ykdLWRwgCsXruMQvWCb3mm1UjOLGJ/VtLq72YBh5skftykjRwP2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753636562; c=relaxed/simple;
	bh=5zwEztKCBSp4Obb3w98NdqATS2CMdS17Bv4hfZpxqlM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bD9GjKt5uo8G7VtffJQ35zMaV94D5jR9wlrYLmtog1udoCOoq/BH1Ly7rGuZv/ojmre5zi7AeO3LgAa6MPW4ENj0/Rp9i7Shga3XnLXfCU2fK38cqW+xd3Cpm6moWk6QuBVeyU3EZ36IflczXY2tFQJA1yZlPwM814BMyhjie88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGvUEMpy; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGvUEMpy"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8e11af0f54so178793276.2
        for <virtualization@lists.linux.dev>; Sun, 27 Jul 2025 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753636560; x=1754241360; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGOUWrUt6/KLdfWNCgo1PdzYDTwfxMfj9+QwMlA2V4s=;
        b=eGvUEMpy3iAeDl5GkCl4E+/Tmna0o7uX0FZeMerjIanFEc7yeZkQ89dJ/g4d+jM9Fm
         7xrKwfn9wctE8JR/vai1j9L/X0eOpOB6EdU9QwxMja1n2EsXFMBQVru7D4pP065ZeNgW
         cw5j2F75AXrZffgIqphBKFM9iFp03jqqyEW6/QUA1cZSLQg9vRjnQVl/jt6xyds3FXfa
         eSX/juA66+8JnUy6atrPqbJtRODpK0kAFfuYVcCWZBPZvBydnMK7xDh35rNvSTTdPXSX
         V5O515Ta9uAVaKLFhPrUBdBlq5lms10o9n4P1oZ50IGOAGCMu25NuXXF4ikXGdlanYpy
         dFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753636560; x=1754241360;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kGOUWrUt6/KLdfWNCgo1PdzYDTwfxMfj9+QwMlA2V4s=;
        b=WGOfdW9q9BSai0OVY1e4akoGzuVXBXEXP4VZyEf8euHHzpxWLy+zvuZZMxM0WpZObe
         fOX4XlYaEqG/Ux53WRMp8Kfsxy9MdrSuc7OpFmF6oCENm8HzbYZr9rxqwMAi9K6OnGuT
         W3asUNblpGV81hKf4vtmvMnsUz2CX9PpT3uL/GoYEivvuft95w43/7F756LMHi6THl6/
         qSd6tkRgbjxIu09oCoK4D5Mp64uOkxP4eUgGpRRWUC4aymlfoF5pC/yTBO0EWgqCuTYN
         4pPWobOPlIRrO0b/qUOc9hx18L6unFrkEgzS1+nwllkXPPq/fZEY18LYuHX+LJsAG+wr
         yizw==
X-Forwarded-Encrypted: i=1; AJvYcCX77IXwfu4OVMUd8MTv5ssqTtljKCOoc+U1DlO+uHnDkBpXRu1l+Kj3sHpbE6Lz2RpwaYryyV/VRAlQv9WgIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvDtQi1EHM4rNwwpEx0SVy3R1jkFXwGOndyT4nsu/3oRoja87M
	hDhBa3CZxpcnbbkyW1dhDY6UK53F6PxReBPRGhdhcdZ1VR2KCNYPfcop
X-Gm-Gg: ASbGncsbTsLyH1zyNzxhfXo/A0fOWsNhZ/i8hku2wG6FbRYoYL+61AoaNmS7kgWRkLJ
	Uf5bVJIXmVUB2inDCpJYRodrvIgXsZyBm4O/DbenC87d++qvl6MstAnfUw7yFmGbSESZfpekRWr
	JSqSUwA8XUPsjs0RhrnUdU4x1uaxHMZ6H0McH/5Vg+kZnVh7Rw2NP/H/MEOcWvcTK7Sm7nICOC5
	2EBGau8JA21fn+XOOZeko5lnMc3V2xAUYgRbH7ltRE4xc938lLw+n5KgPWblDH8QEqBuMND+2VJ
	138LOSWiUjMVxq/tUU8dy13lZRGZJZZQ6juDd9BP7tdIakiI/trWpL+CSMBBIt/0mK34hG1CABP
	yJNWnZa3jig/dvKXZ+3DXx+VPGaZ4FMhLNzdJyQM4w2dgZFQGvDGPZW4HuiZxcV/QjtcOp2A1GX
	xbe8uz
X-Google-Smtp-Source: AGHT+IGRgpb969BkgC8x+v/hneqLAXkS6hiR4nYVLPk3riGZTJwJFQzLzbOyOO7L6LzJGp8caBw9fQ==
X-Received: by 2002:a05:6902:f84:b0:e8d:ed8a:af5e with SMTP id 3f1490d57ef6-e8df10d2b6fmr10951855276.10.1753636560041;
        Sun, 27 Jul 2025 10:16:00 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8dff798feesm1136342276.4.2025.07.27.10.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 10:15:59 -0700 (PDT)
Date: Sun, 27 Jul 2025 13:15:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Wang Liang <wangliang74@huawei.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, 
 pabeni@redhat.com, 
 davem@davemloft.net, 
 willemb@google.com, 
 atenart@kernel.org
Cc: yuehaibing@huawei.com, 
 zhangchangzhong@huawei.com, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 steffen.klassert@secunet.com, 
 tobias@strongswan.org
Message-ID: <68865ecee5cc4_b1f6a29442@willemb.c.googlers.com.notmuch>
In-Reply-To: <68865594e28d8_9f93f29443@willemb.c.googlers.com.notmuch>
References: <20250724083005.3918375-1-wangliang74@huawei.com>
 <688235273230f_39271d29430@willemb.c.googlers.com.notmuch>
 <bef878c0-4d7f-4e9a-a05d-30f6fde31e3c@huawei.com>
 <68865594e28d8_9f93f29443@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net] net: check the minimum value of gso size in
 virtio_net_hdr_to_skb()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Willem de Bruijn wrote:
> Wang Liang wrote:
> > =

> > =E5=9C=A8 2025/7/24 21:29, Willem de Bruijn =E5=86=99=E9=81=93:
> > > Wang Liang wrote:
> > >> When sending a packet with virtio_net_hdr to tun device, if the gs=
o_type
> > >> in virtio_net_hdr is SKB_GSO_UDP and the gso_size is less than udp=
hdr
> > >> size, below crash may happen.
> > >>
> > > gso_size is the size of the segment payload, excluding the transpor=
t
> > > header.
> > >
> > > This is probably not the right approach.
> > >
> > > Not sure how a GSO skb can be built that is shorter than even the
> > > transport header. Maybe an skb_dump of the GSO skb can be elucidati=
ng.
> > >>   			return -EINVAL;
> > >>   =

> > >>   		/* Too small packets are not really GSO ones. */
> > >> -- =

> > >> 2.34.1
> > >>
> > =

> > Thanks for your review!
> =

> Thanks for the dump and repro.
> =

> I can indeed reproduce, only with the UDP_ENCAP_ESPINUDP setsockopt.
> =

> > Here is the skb_dump result:
> > =

> >  =C2=A0=C2=A0=C2=A0 skb len=3D4 headroom=3D98 headlen=3D4 tailroom=3D=
282
> >  =C2=A0=C2=A0=C2=A0 mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D=
98
> >  =C2=A0=C2=A0=C2=A0 shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=
=3D0 segs=3D0))
> >  =C2=A0=C2=A0=C2=A0 csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 co=
mplete_sw=3D0 valid=3D1 level=3D0)
> =

> So this is as expected not the original GSO skb, but a segment,
> after udp_rcv_segment from udp_queue_rcv_skb.
> =

> It is a packet with skb->data pointing to the transport header, and
> only 4B length. So this is an illegal UDP packet with length shorter
> than sizeof(struct udphdr).
> =

> The packet does not enter xfrm4_gro_udp_encap_rcv, so we can exclude
> that.
> =

> It does enter __xfrm4_udp_encap_rcv, which will return 1 because the
> pskb_may_pull will fail. There is a negative integer overflow just
> before that:
> =

>         len =3D skb->len - sizeof(struct udphdr);
>         if (!pskb_may_pull(skb, sizeof(struct udphdr) + min(len, 8)))
>                 return 1;
> =

> This is true for all the segments btw, not just the last one. On
> return of 1 here, the packet does not enter encap_rcv but gets
> passed to the socket as a normal UDP packet:
> =

> 	/* If it's a keepalive packet, then just eat it.
> 	 * If it's an encapsulated packet, then pass it to the
> 	 * IPsec xfrm input.
> 	 * Returns 0 if skb passed to xfrm or was dropped.
> 	 * Returns >0 if skb should be passed to UDP.
> 	 * Returns <0 if skb should be resubmitted (-ret is protocol)
> 	 */
> 	int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
> =

> But so the real bug, an skb with 4B in the UDP layer happens before
> that.
> =

> An skb_dump in udp_queue_rcv_skb of the GSO skb shows
> =

> [  174.151409] skb len=3D190 headroom=3D64 headlen=3D190 tailroom=3D66
> [  174.151409] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> [  174.151409] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D4 type=3D6553=
8 segs=3D0))
> [  174.151409] csum(0x8c start=3D140 offset=3D0 ip_summed=3D3 complete_=
sw=3D0 valid=3D1 level=3D0)
> [  174.151409] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=3D=
8
> [  174.151409] priority=3D0x0 mark=3D0x0 alloc_cpu=3D1 vlan_all=3D0x0
> [  174.151409] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0=
, trans=3D0)
> [  174.152101] dev name=3Dtun0 feat=3D0x00002000000048c1
> =

> And of segs[0] after segmentation
> =

> [  103.081442] skb len=3D38 headroom=3D64 headlen=3D38 tailroom=3D218
> [  103.081442] mac=3D(64,14) mac_len=3D14 net=3D(78,20) trans=3D98
> [  103.081442] shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 se=
gs=3D0))
> [  103.081442] csum(0x8c start=3D140 offset=3D0 ip_summed=3D1 complete_=
sw=3D0 valid=3D1 level=3D0)
> [  103.081442] hash(0x0 sw=3D0 l4=3D0) proto=3D0x0800 pkttype=3D2 iif=3D=
8
> [  103.081442] priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=3D0x0
> [  103.081442] encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0=
, trans=3D0)
> =

> So here translen is already 38 - (98-64) =3D=3D 38 - 34 =3D=3D 4.
> =

> So the bug happens in segmentation.
> =

> [ongoing ..]

Oh of course, this is udp fragmentation offload (UFO):
VIRTIO_NET_HDR_GSO_UDP.

So only the first packet has an UDP header, and that explains why the
other packets are only 4B.

They are not UDP packets, but they have already entered the UDP stack
due to this being GSO applied in udp_queue_rcv_skb.

That was never intended to be used for UFO. Only for GRO, which does
not build such packets.

Maybe we should just drop UFO (SKB_GSO_UDP) packets in this code path?

