Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50B2E36F7
	for <virtualization@lists.linux.dev>; Mon,  7 Jul 2025 03:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751860163; cv=none; b=B7WJaH/XAtLR5O9xY4PhsCElB3ZKkRfhTUpSmOiy6eZV/fGOqc6SoAnB1RLuMkpwMMUqfBijTqG2HDZGP8rrbiT8BvqHOc22nidWBV6aj2ITKexkle18sSRwCVZt/P2BFfVkZLixgulx1uybykVG9x2NXk4fnG9depb2WF+GnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751860163; c=relaxed/simple;
	bh=rbEkyEc54JX0hon4H2QR8j8z7VQjU5iAOMrPuzptzX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJTlezX1j7TbymIQZJfTEiMRMutufedApGwU7X+JtEkaFmMfo0i8hExMfe9fYvWCXrfQV75WZZ3Jdq1T5eYtYEoGcDEbMJiuFgyP/+kDOW/T+e/ZZ2zV566QzBwKSuFCdaSyZd54hbo1mznJumKFY4SmdopcbK/u48qgCLNRs8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVCFPXsp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVCFPXsp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751860161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEqeCIto7afaKCbzfho3gYL4/zINVSmga5IJMeGkA5Y=;
	b=iVCFPXspPDtveVzou1w6lWVz3ne1OJqS97yerI/maxqYA+suZx9weWRyx2k8lfalwiGu7D
	q4jG34JRf0FFbM3B47Es8aa35s/29nmVwToU3wZldYsmi3VClWPONa+WSuqNDa8zSFpifW
	+iEBKSzhQgRD4Ct13XAsmynEZpLtugc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-BfKFuQqQOT6uhKEa6FN_IQ-1; Sun, 06 Jul 2025 23:49:19 -0400
X-MC-Unique: BfKFuQqQOT6uhKEa6FN_IQ-1
X-Mimecast-MFC-AGG-ID: BfKFuQqQOT6uhKEa6FN_IQ_1751860159
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so1994629a12.1
        for <virtualization@lists.linux.dev>; Sun, 06 Jul 2025 20:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751860159; x=1752464959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEqeCIto7afaKCbzfho3gYL4/zINVSmga5IJMeGkA5Y=;
        b=bFv2nAfVQ5dyjJVBf2BpmwH6LxMPO46FVxpf0O2Eoqc9VAt8Ua/VK6hDWQiXTlOAWd
         VSnViC990gvYWOMUk8xLwA85KRQLShtfFpbB2g+8X+EDxWc2C5oB9XPWKCs6xXDM+boq
         zuSkQkjWDkA9qYaQaJhETo70P1kd2NP0qO1TwOHubLzowBGrIk8QJge1lWeHrNH2DDfL
         6kGbe8FnqNi1RK3U/YVrKJ2XLea3QxVtgGVkEQnhqCEULurC0eMd5ywbnuVA/m6Xl/D1
         p/k8sOCE3HwfsyV2UzFG6ojAM/PoMfK5geyFMwQcNdA8CcqPxzCSCEH+PohI8XgZAMeN
         P0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWpVaK9MSV/CA7467HwFOJ7Tyj07flWHUtXl/9na0X3COtTNp44rx5f1eejYFtRL/kNoi/hMGf5vKw87fjv1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsUhXxxnD3YhJM6HBQSFB6WFXS/O91nmUb74+TbruGKRtae23/
	23SfpaqySZd+BxeASyUdWs6Hvx2Olh3mI/Qr5KZ4Ms6Bt9ETJqj0Q2J3RbdpnL1+mXp4mcV9P0X
	i5gtyAOCMjxurns91oSih4SHuC9VY4uEOTdvwFBLD9y1q46pgfCwu8HUlt63fVYsIsFXgJYIpNm
	U54t6eqO2NsKoX2bjegh5wnmp48waTe+VMyBNe8fpcpmc=
X-Gm-Gg: ASbGncu/jQdxD/O1GecZePwPaIX3jXob/9axFG8CZKxi9sQnrj1PE3qO699myxRbjIk
	YxDV0ML98OO/eRVMfIRuKQiINT37Bqb8+/dhsoeL+wdQMv0COyZjDTx9f4dZcnwc6k7lpMCJyT0
	S2tzV2
X-Received: by 2002:a17:90b:2f03:b0:315:f6d6:d29c with SMTP id 98e67ed59e1d1-31aab057582mr15693153a91.15.1751860158586;
        Sun, 06 Jul 2025 20:49:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoqktEzX7UFCYL8rORdV2btU2Z2RPP0g5Ib6nxAwRfGWFKbHnpjyJ/v7HeB/oOqzeco9o2bSl+UclX/oDvuho=
X-Received: by 2002:a17:90b:2f03:b0:315:f6d6:d29c with SMTP id
 98e67ed59e1d1-31aab057582mr15693113a91.15.1751860158013; Sun, 06 Jul 2025
 20:49:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250706141150.25344-1-minhquangbui99@gmail.com> <CACGkMEvCZ1D7k+=V-Ta9hXpdW4ofnbXfQ4JcADXabC13CA884A@mail.gmail.com>
In-Reply-To: <CACGkMEvCZ1D7k+=V-Ta9hXpdW4ofnbXfQ4JcADXabC13CA884A@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Jul 2025 11:49:06 +0800
X-Gm-Features: Ac12FXxJfbQxhcxDTY2Mp6Wx8JjbygNOJDdfIFZy8GLMK_DojQ4RAdYyPAaOF9U
Message-ID: <CACGkMEvBf3_cReVDxX2dRALrS=fQvg9pMY1LKwmbf=Gp9zSTPQ@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yR3qQKFcFllBUzKqWT007lLDg5_KTUhbeDZ0cMj5a3c_1751860159
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 11:48=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sun, Jul 6, 2025 at 10:12=E2=80=AFPM Bui Quang Minh <minhquangbui99@gm=
ail.com> wrote:
> >
> > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > for big packets"), the allocated size for big packets is not
> > MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> > number of allocated frags for big packets is stored in
> > vi->big_packets_num_skbfrags. This commit fixes the received length
> > check corresponding to that change. The current incorrect check can lea=
d
> > to NULL page pointer dereference in the below while loop when erroneous
> > length is received.
> >
> > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big=
 packets")
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 5d674eb9a0f2..ead1cd2fb8af 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_i=
nfo *vi,
> >  {
> >         struct sk_buff *skb;
> >         struct virtio_net_common_hdr *hdr;
> > -       unsigned int copy, hdr_len, hdr_padded_len;
> > +       unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
> >         struct page *page_to_free =3D NULL;
> >         int tailroom, shinfo_size;
> >         char *p, *hdr_p, *buf;
> > @@ -887,12 +887,16 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> >          * tries to receive more than is possible. This is usually
> >          * the case of a broken device.
> >          */
> > -       if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > +       BUG_ON(offset >=3D PAGE_SIZE);
> > +       max_remaining_len =3D (unsigned int)PAGE_SIZE - offset;
> > +       max_remaining_len +=3D vi->big_packets_num_skbfrags * PAGE_SIZE=
;
> > +       if (unlikely(len > max_remaining_len)) {
> >                 net_dbg_ratelimited("%s: too much data\n", skb->dev->na=
me);
> >                 dev_kfree_skb(skb);
> > +               give_pages(rq, page);
>
> Should this be an independent fix?

Btw, the page_to_skb() is really kind of messed up right now that it
is used by both big and mergeable. We may need to consider splitting
the logic in the future.

Thanks

>
> >                 return NULL;
> >         }
> > -       BUG_ON(offset >=3D PAGE_SIZE);
> > +
> >         while (len) {
> >                 unsigned int frag_size =3D min((unsigned)PAGE_SIZE - of=
fset, len);
> >                 skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, o=
ffset,
> > --
> > 2.43.0
> >
>
> Thanks

