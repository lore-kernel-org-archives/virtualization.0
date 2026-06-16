Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43883C5544
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584210; cv=pass; b=jM2Q+EX2ntgwMn4l6e8uFn7TKTqySCrbmvEqWZe3jYXmuNVO9/PCgovEXGTRKsMCuaAAtE3npXvihiWicvRK3q3bK/vwCHFqMPlbhmOekQGHMDBWmzTHJy5/AHX4IP5wehrVIk5WzAgFK/M0ZC7JmrrPFd0IkVSVzJXT2ihe1Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584210; c=relaxed/simple;
	bh=Iy6jgVqcBBs4rASBrLNQoYJQZJL3ZQB2WUBZma5U/+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyUaqncnzZemLscVKjCaZSuEMHpSAOz7opWAiE0OovahFa04tqUbNap+fHCOEJDmAlB1gbu2OcczwiaDe+bcp05SPNps8aOOpsaBWQnPSNhQxdCNF/zdhEZfMX7LROmN7nsBqO+U+JyA8Hl7Ae/8oo8L5Tb3oU4Ua1q3V54+Rp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=kxm63rOw; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="kxm63rOw"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so2713734a91.2
        for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 21:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781584208; cv=none;
        d=google.com; s=arc-20240605;
        b=fNhdKAvDxJQBVwOrsfwjdJdBfrnhQFrgiodmnjwtJIE2BB59lJmHk1L/z1ZKK4slQ/
         cYQyWMgsr/MGroqwgO56+rwAIAOaXw+eXyjfIAkEZfKQjPm1ZSIX/ld1GJyqO+cEJC/B
         iJCSAaM6LpNkMu91HVHo9BZszl154igyJeFMTLAnp9PsnMB2OQLD5J76ffDF2oXRt4K/
         gwrQr7TedDfqxRxAjie8N9BtyBYeXoaf8T15PBBQPYheKdMOk224CDFisxCsjPmNkKq5
         5GK8I3h6uu5l80xhi+26gAII7uXoepAMkQlPslOr1sQWfvKqMXI7VGAPkVs3+WMPhOpp
         8LIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ppX4qdYU5rXRtx2iPmU/w5gI+2dV9fiMI5XfuWrU7yA=;
        fh=SfymTAa8rNuhQEFAP4idnNMIaihvvJhyN2qSIJfWT2Y=;
        b=lACmx76URVwOtoGLnAlTqnLPnmEDXNLtY6+PiY/I5WZH8Hq3I43NkeGyaIFjD69IL2
         EmTn8UPld/ApjaIBKwVs/uagUqrPr4QwqS7UlzC4IAIR9KGXM2Dz+u7mb/fGmXpWcmGW
         4Rt6VJ9ToK2LVW8Gzfalfks9pn2FrDAO+0K10SoAuCFravuCH723UqvXn3gaBHfsnPo9
         B3eRqVjuvuJjNjrlD63DMorNtxeD4AgAj9ybL53ER1a0F0uK5tKh37mdIJMKTC/cJ22l
         5CAW6XAWE9au8mskWLFj6cfCFwMcb5HZf595Kf48do+yytzGCTiNX0jLgH/ugIvPtM5G
         iwbg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781584208; x=1782189008; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppX4qdYU5rXRtx2iPmU/w5gI+2dV9fiMI5XfuWrU7yA=;
        b=kxm63rOw+Xc7wwWEZtI6F0KMK5ipm5O98cQCadioehwWUirbMlIdznLYgigLy8+MMT
         7bJkvl2tRlWACYjoghIcWsSkvP4InBM4+BfdE8LyxFormzx5XVfMIIyBASJkr6t5fEr5
         HyTx/DG72mRYE0K1OnTnSaZGW0W29B+LvpuqJPgfnAcJPfMK+6npNDFtzPFTvf1BNQAY
         RzTsIrQkJ4k6p+zwrCt0SAZ0hdpi7lj9+tWKhWec47BHoHqhtgif95F9ivDCMNn332c4
         7BnwKmuuKR27Z8TWCmdUxAKCsm9cMjZQ/hP54FGKLTPTteOaBeH+6p1VdwllkHcvZtHN
         rcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781584208; x=1782189008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ppX4qdYU5rXRtx2iPmU/w5gI+2dV9fiMI5XfuWrU7yA=;
        b=Qna/WXZsbl24FBLEMM21xRjlCQQCxjypmlbdTc8h/IKxDtwnDCjZKo2mK0JRXRGU/T
         xcMubKc//WQ65SlTE0c5qnCokOsMp7wgWYOReiTeyoAAhxqQ1ck3N21DwsylgqGy1+W4
         N5bAm3ZjfDLUSDXu9pzOQsjAjRmiXeEFk75eF7qwAhiXINb/y2ANrxctbh4yVpqatyZ2
         oEq1fq9iKAQX5GO5QPEIDi9SGXTXE6ODPbvPVwxDyoJkZTxtZ+kdxHqdmg7JUFKorktC
         G77WRJ7vz8jLczZgp2fIUlBnMU9KfTVQE5HJc41xjF6M7DzhJ0byoypO1Rua6wF7aFUf
         6aJw==
X-Forwarded-Encrypted: i=1; AFNElJ9cPA0oOPV5R+HTRmnR/BYJbxGgQMj8rLFRSbjIO/PYh6YV4roMpFd1uZdPcDFpRd5it9r5AZT3DeFBjdvZAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8AADbh5fR1RCkJHvSEXlmEnF3NzZIyk3mBs5sbR+GYQA/6Vrp
	HzhBkxsoPVZHZdpUrBXd3gDSCSvBreKCcqp1qiOxs/hWbjxdqJk69ymjqPuFgP65TqqNfGD1vB/
	mZ+gF2Z25K/k6pvv/nlV7nKEaLVNV4zHYJhF63WZY
X-Gm-Gg: Acq92OFC+QWJD8LOASH5EmL7KnWZ8ojpJ7k3Zi/1hqPxDauIFkJATkIuwRKrbI29rU4
	4efsEI1SR7C0xCkTu2VF7/OCH86+18ZhaAkwjyQaFJ5egsm6G4M7EnzIkyM789ofAQDF8j7neEB
	65y2pA7Mjlk7pnXqxT9kntzEGC/CbMQ/KY8PmxV+lvSArDGRxXGSlv1aqnR10UO7+rNEhwYxKdT
	0ZaAdljKD98LwnDytL+fObJPE3znXdGZ0KTAbvdYUajHkrgeW2qitJLslATZgcj/plHgyP3Puyt
	Jd9e+A4=
X-Received: by 2002:a17:90b:53cb:b0:369:7421:75cf with SMTP id
 98e67ed59e1d1-37c2bce7aedmr12427842a91.16.1781584208118; Mon, 15 Jun 2026
 21:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260611024616.1408317-1-xmei5@asu.edu> <20260611014519-mutt-send-email-mst@kernel.org>
 <CAPpSM+Q=NM0WeBmZvyOEkyx73VU10AOHQjPbWDSet675B7AnCA@mail.gmail.com> <20260614152904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260614152904-mutt-send-email-mst@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 15 Jun 2026 21:29:57 -0700
X-Gm-Features: AVVi8Cc2s0GQzec-BSWAkyi2kv832yJ1_God0icULI6-YQFhGMfJc-Yqjq-xTJs
Message-ID: <CAPpSM+S5zwZLuEu7CBbFBtJgBJ+668x2RMNaVS7jPr--YiURWA@mail.gmail.com>
Subject: Re: [PATCH net v3] virtio-net: fix len check in receive_big()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 12:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Sat, Jun 13, 2026 at 01:15:02PM -0700, Xiang Mei wrote:
> > On Wed, Jun 10, 2026 at 10:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Wed, Jun 10, 2026 at 07:46:16PM -0700, Xiang Mei wrote:
> > > > receive_big() bounds the device-announced length by
> > > > (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loos=
e:
> > > > add_recvbuf_big() sets sg[1] to start at offset
> > > > sizeof(struct padded_vnet_hdr) into the first page, so the chain
> > > > actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> > > > big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than th=
e
> > > > check allows for the common hdr_len =3D=3D 12 case.
> > > >
> > > > A malicious virtio backend can announce a len in that gap.  page_to=
_skb()
> > > > then walks one frag past the page chain, storing a NULL page->priva=
te
> > > > into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bo=
unds
> > > > write past the static frag array and a NULL frag handed up the rx p=
ath.
> > > >
> > > > Bound len by the size add_recvbuf_big() actually advertised.
> > > >
> > > > Fixes: 0c716703965f ("virtio-net: fix received length check in big =
packets")
> > > > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >
> > > Thanks for the patch! Something small to improve:
> > >
> > > > ---
> > > > v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
> > > >
> > > >  drivers/net/virtio_net.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index f4adcfee7a80..afe73eda1491 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct n=
et_device *dev,
> > > >                                  struct virtnet_rq_stats *stats)
> > > >  {
> > > >       struct page *page =3D buf;
> > > > +     unsigned long max_len;
> > >
> > > Assignment can happen here?
> > >
> > > >       struct sk_buff *skb;
> > > >
> > > >       /* Make sure that len does not exceed the size allocated in
> > > >        * add_recvbuf_big.
> > > >        */
> > > > -     if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_=
SIZE)) {
> > > > +     max_len =3D vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_v=
net_hdr)) +
> > > > +               vi->big_packets_num_skbfrags * PAGE_SIZE;
> > >
> > > Took me a while to figure out what is going on, but I finally
> > > understand:
> > >
> > >
> > > Reducing
> > > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE
> > >
> > > (what we allocated)
> > >
> > > by sizeof(struct padded_vnet_hdr) - vi->hdr_len
> > >
> > >
> > > right?
> > >
> > > So clearer as:
> > >
> > >
> > >         unsigned long max_len =3D (vi->big_packets_num_skbfrags + 1) =
* PAGE_SIZE -
> > >         sizeof(struct padded_vnet_hdr) + vi->hdr_len;
> > >
> > Right, that's the same value. Yours reads better!
> >
> > I'll fold this into the next respin. One thing I'd like to settle
> > first: David suggested storing this in a vi field computed once at the
> > probe (it's a per-device constant) and just comparing len against it
> > on the datapath, instead of re-deriving it in receive_big() each time.
> > I'll wait for his take on that and send a single v4 that covers both.
> >
> > Xiang
>
> I don't mind.
Thanks, Michael,

V4 has been sent.

Xiang
>
> > >
> > >
> > >
> > > > +     if (unlikely(len > max_len)) {
> > > >               pr_debug("%s: rx error: len %u exceeds allocated size=
 %lu\n",
> > > > -                      dev->name, len,
> > > > -                      (vi->big_packets_num_skbfrags + 1) * PAGE_SI=
ZE);
> > > > +                      dev->name, len, max_len);
> > > >               goto err;
> > > >       }
> > > >
> > > > --
> > > > 2.43.0
> > >
>
