Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F39823BCEE
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592922; cv=none; b=Potblod5R2LUutnM4aHh/q1r9AEeYdIcffoha2PS7ZLCfITKsqhWXNFLlPb9DKvLd8zqULkoWV2w+zJN8zUyWS5edW6KDDB0yLJdLCJJW9wXcbbLQmn2/0MzrKrHGUIeUFvaV82qwvuu24/9Jszr3DFZzbLCpK7arzjqh5+hGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592922; c=relaxed/simple;
	bh=OA8jfvqB94WTqblc7B6TblgCAhJnB1BowDnSQb7RcJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2vYQ6kB4Kwn2OvgGNpk0Ze17rlQ2z3LRtW1os4tYgRiswAtQ9NGaokroCbfpW53nBXSrQ413CwGJA0SI5zHeUoXbh0p8PPQ2i8z4XlpUIMdNsH23+vfZXS00TazBLFgkUbzpsjMtrfGjkR4bBnx8ZhfFS3lsLriDJ17u5LcWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2GBqhP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2GBqhP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752592918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fI0v1yI+mRa3f2C1cjF3TQ6M2kT1SS2IwxcIibzixE=;
	b=V2GBqhP4ZXTGis/HRDSF7tgWRnSetfYG/kNwxq7rCMgRi3g86TzgLc0P+RJIrHg/BcZdbc
	Of0FndCjpkubHIlCkROgtjvybm5juhXojFKTd7ArgX1tVQdo6AJ0RIwIaOVCuDIAsnpsyd
	Oy4P3/J6hS/cenfT2nVrckgX3T3QPrE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-2er3IAk2P0-3YLLX93hqgA-1; Tue, 15 Jul 2025 11:21:57 -0400
X-MC-Unique: 2er3IAk2P0-3YLLX93hqgA-1
X-Mimecast-MFC-AGG-ID: 2er3IAk2P0-3YLLX93hqgA_1752592916
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae6d6b8eacbso417794666b.0
        for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 08:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592916; x=1753197716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fI0v1yI+mRa3f2C1cjF3TQ6M2kT1SS2IwxcIibzixE=;
        b=PyqjPbbgv4AqSc1dGyRO/Z4KEd0xyqGY0tbcUIl2s9jjJTemK49NZTTYltIivGrtrx
         W3FfjyAu2WtO46lAd/Xpo9e5bTa9ZeqGkZkAiqywIWUBLxOAnpHr6+cXajixnbXDsYnO
         H4OQNUC1bIohb5QAv8bXxUvI1FvQ7idldccw0y5ZfHMS609H+Ismwe9HXg5VAlL5lMhw
         8BiSRp6jAFPc/H67mbSWaVjHho1cOIg4WjTuE2fjgd8XwkQ2gdy60v+ZOJ7qAOW8NbIl
         amy3/7/dXtoXqoq6FlOKPyyH1rkG2HB7nHe9Vz+V8r5MvXY3yMr1RoQV6nmCtqpyjSnz
         Znbw==
X-Forwarded-Encrypted: i=1; AJvYcCUqK8IKjvIhP2PZwLp7g+2mF+eDHGNlg5sRN/UdBm5CH7RhIOWXSF1DBS0CcpZn8Mlhucb+d9g4k0ilgGc8pw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7GunGDZxjORSOCXgjW8Ov/pkSkyn595NvGeZwKGHWD2qa6uiF
	Tr3rm5Zth4doetikClwjxgFsljBiSc0TvTgAjjg3IaR5QOaNH8tv6pLWz2QzSsYyUV0QPz3bOI1
	Rcuf9DVd31hl8jC1ygSUJYbSq6dS4nH/uhdeVyWPf9MdLqmIUK2KuaUJBqmOBnRmdkOh4F+whoS
	3+Rr9z0xtxzeMKTaGNCHha1uJcCpurBsRGSM5jHU03QJc=
X-Gm-Gg: ASbGncuLaGiz7gfHjYu4mHMES8FSUVxivkg5dYrl6HBoKCcrh68RJkpIGuiaJIpGzcv
	gwMhN9OX3swpFSkKlMmYwcXUphoUoCKrmUQDt+1duDMr1pOzk+Q831Yr7Si5LSgfKva6vZWmfYT
	jV6s7TdPL3q0KrenkS6ZlZjQ==
X-Received: by 2002:a17:906:f59f:b0:ae3:5be2:d9e8 with SMTP id a640c23a62f3a-ae6fc6f5e4amr2016854666b.18.1752592915706;
        Tue, 15 Jul 2025 08:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG04Q0/L7+tw1PxjEvUIsfEfnfanZh/MEfguoQzygMTmlyTx8BJASaAiyVGdXWILSHA5dGrH0aEap7oQDpZqQo=
X-Received: by 2002:a17:906:f59f:b0:ae3:5be2:d9e8 with SMTP id
 a640c23a62f3a-ae6fc6f5e4amr2016851466b.18.1752592915292; Tue, 15 Jul 2025
 08:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
 <d808395d-2aad-47a3-a43a-cf2138d1d2b1@redhat.com> <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
In-Reply-To: <CACGkMEs01gmjEa+WyWZ+MspuRBjGcj8N+4ZQs5XCp+rYqZqB6Q@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 15 Jul 2025 23:21:16 +0800
X-Gm-Features: Ac12FXz1YLuKyuuRFUqAPOMa3ysRrX3OPGeF3wFUvNM12KNl4C21Kk7IWP1rQN8
Message-ID: <CAPpAL=wSKdNA_q=zSN4c+7dhj6D7bWxKBNo+9o8ZCvFpYp+5FA@mail.gmail.com>
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big packets
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WReEAh7Hq8MTwJYRAU8FY97Vc8gtX1mtNmdF5Mi-CiE_1752592916
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jul 10, 2025 at 6:44=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Jul 10, 2025 at 5:57=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 7/8/25 4:42 PM, Bui Quang Minh wrote:
> > > Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
> > > for big packets"), the allocated size for big packets is not
> > > MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
> > > number of allocated frags for big packets is stored in
> > > vi->big_packets_num_skbfrags. This commit fixes the received length
> > > check corresponding to that change. The current incorrect check can l=
ead
> > > to NULL page pointer dereference in the below while loop when erroneo=
us
> > > length is received.
> > >
> > > Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for b=
ig packets")
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Remove incorrect give_pages call
> > > ---
> > >  drivers/net/virtio_net.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 5d674eb9a0f2..3a7f435c95ae 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet=
_info *vi,
> > >  {
> > >       struct sk_buff *skb;
> > >       struct virtio_net_common_hdr *hdr;
> > > -     unsigned int copy, hdr_len, hdr_padded_len;
> > > +     unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
> > >       struct page *page_to_free =3D NULL;
> > >       int tailroom, shinfo_size;
> > >       char *p, *hdr_p, *buf;
> > > @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct virtn=
et_info *vi,
> > >        * tries to receive more than is possible. This is usually
> > >        * the case of a broken device.
> > >        */
> > > -     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> > > +     BUG_ON(offset >=3D PAGE_SIZE);
> >
> > Minor nit (not intended to block this patch): since you are touching
> > this, you could consider replacing the BUG_ON() with a:
> >
> >  if (WARN_ON_ONCE()) <goto error path>.
>
> I'm not sure I get this, but using BUG_ON() can help to prevent bugs
> from being explored.
>
> Thanks
>
> >
> > /P
> >
>
>

