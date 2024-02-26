Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1FB1B59D
	for <virtualization@lists.linux.dev>; Mon, 26 Feb 2024 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708923584; cv=none; b=nATHDxpu+Ng+m/kD2wfK2Apc+k0iDOT4WB1sBTP2D4LeCdd63tR4SLhjfoG+i0UWf/36zIKCWoB5OeBH+XYSjHFTmQQiBiWwCwOrWIxcK3wuGi4sC7gAnEYNVIPpGTa/k3at2bucVIOBI764O8aQsoEjmFaoCMHt33ycGpUtbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708923584; c=relaxed/simple;
	bh=AaJMamp2Nb+Yq5spo7QL5Q4FyDBAAXS9vg0TE+DBw+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUtheNLmxsXq4Ppgs1QronPUfy0fnUaWZ6bZyjUk3vtODn/TDmrQSni8Z7gQT+M/SDBoFrgykH7FzHHhZ8Lf1Cy2FQiCG0YWC5NyaEIHHJNPrSmfgTOpcOPcS3NiV7ekf/dHyOXxsVVvVbNEFA2W4i4g4pqVkcxLI0n4mjOeRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Peajf0G9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Peajf0G9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708923582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iso6K6DyWAnnF++t9+yhMMEiOuk3VKMqC/cJQai+WRQ=;
	b=Peajf0G9+/v+KbF+DW/vDZQOAz/NlvsEn8mmGv7h+IgwaR7TDgXbPcCTdOc4ObO/EPrWu7
	eaOV4hoG5/XIb16NUNt8JC16X19I3dGPpxwJjN9FE+65M8zQ7/UL7QmMOs7pAN4pWB4BJ9
	V1a8g/Kkc5v/vtu8jBx+FSzViL+MOLs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-DpQcUPCnNZepYc_gvy6xsA-1; Sun, 25 Feb 2024 23:59:38 -0500
X-MC-Unique: DpQcUPCnNZepYc_gvy6xsA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-290a26e6482so2572131a91.0
        for <virtualization@lists.linux.dev>; Sun, 25 Feb 2024 20:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708923578; x=1709528378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iso6K6DyWAnnF++t9+yhMMEiOuk3VKMqC/cJQai+WRQ=;
        b=N218IPafbl0pfnuLRCUD9atugLodeKgDY+QcEaG6dLnW0jN00rXso9RB7iTe1qz/mK
         RgM8C/VO58KVQLIgy152XVkM1V/tA60L36lfM9I/+ZibQjD6EZsUuZFh56cShcEWVbaz
         V2VworbUkqvCwnJ7RcquV4mHwGZZ3uoTmoPJBSWF9qRPRZGDP31MpkAnr6hix1Z9nDrH
         VhrAxNawaCdXspYVTmCfzNiQJt6jfdUamdDyY5MmDWCUCrGWz224pQ55Qtu9GFoC4phR
         CTs9EAXvnfIrNfAl03kXJHuF4BymS4irHp+u2ARtk0KuSHH8hKWIOBCjYBZATb7nB7uf
         rjwA==
X-Forwarded-Encrypted: i=1; AJvYcCXOfxQ3VnSjbL7ot8LdZoqal7KEpT6CNnZiLjb7gyXm/eFBr2pLMBx0Q/p0hj0ODaXuMRFJvpX0IVFS1KPt4g7dV1bMlRe693zik4pfsG8=
X-Gm-Message-State: AOJu0YyyU2P4c8wuCF6E8dXu+1UbetOyqCwW2RCGvmF0Ec/M9SxBtI+0
	S/Ei6JQhwsB7JW3IGiiRneNVEswsNgcW09xc+FuS+geNdj8z6Ruygy3W/jHqdrgUjLh/+epKmI+
	6f7X/GBm98TYAEQbKqlDBA8QjVfMWxp+RwN3G0VTIpyJIvzdAnQ//VTRFqI3fZnffeTxpuFs9ZY
	sMpI6fnFdw6S4UWKac+C7FvnpTyRK4l3AXdR8FAhM=
X-Received: by 2002:a17:90a:ad8a:b0:29a:a38c:8262 with SMTP id s10-20020a17090aad8a00b0029aa38c8262mr2919879pjq.48.1708923577743;
        Sun, 25 Feb 2024 20:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFTAN/Lw+RGzf9GeokVG5jtOCl25KGwF/7DbhV8aGSvRwum+aJwJ9WzPtrwumrWZ0Ki7ztusPHGEY87VqwktA=
X-Received: by 2002:a17:90a:ad8a:b0:29a:a38c:8262 with SMTP id
 s10-20020a17090aad8a00b0029aa38c8262mr2919868pjq.48.1708923577403; Sun, 25
 Feb 2024 20:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org> <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com> <1708652254.1517398-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1708652254.1517398-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Feb 2024 12:59:25 +0800
Message-ID: <CACGkMEuUeQTJYpZDx8ggqwBWULQS1Fjd_DgPvVMLq-_cjYfm7g@mail.gmail.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, mst@redhat.com, 
	hengqi@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, john.fastabend@gmail.com, 
	daniel@iogearbox.net, ast@kernel.org, Liang Chen <liangchen.linux@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:42=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Fri, 09 Feb 2024 13:57:25 +0100, Paolo Abeni <pabeni@redhat.com> wrote=
:
> > On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > > On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> > > >
> > > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@redhat=
.com> wrote:
> > > > > >
> > > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Broue=
r <hawk@kernel.org> wrote:
> > > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > > [...]
> > > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct x=
dp_buff *xdp)
> > > > > > > > >       }
> > > > > > > > >   }
> > > > > > > > >
> > > > > > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_=
buff *virtnet_xdp,
> > > > > > > > > +                                  struct net_device *dev=
,
> > > > > > > > > +                                  struct virtio_net_hdr_=
v1_hash *hdr_hash)
> > > > > > > > > +{
> > > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > > +             virtnet_xdp->hash_value =3D hdr_hash->hash_=
value;
> > > > > > > > > +             virtnet_xdp->hash_report =3D hdr_hash->hash=
_report;
> > > > > > > > > +     }
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > >
> > > > > > > > Would it be possible to store a pointer to hdr_hash in virt=
net_xdp_buff,
> > > > > > > > with the purpose of delaying extracting this, until and onl=
y if XDP
> > > > > > > > bpf_prog calls the kfunc?
> > > > > > > >
> > > > > > >
> > > > > > > That seems to be the way v1 works,
> > > > > > > https://lore.kernel.org/all/20240122102256.261374-1-liangchen=
.linux@gmail.com/
> > > > > > > . But it was pointed out that the inline header may be overwr=
itten by
> > > > > > > the xdp prog, so the hash is copied out to maintain its integ=
rity.
> > > > > >
> > > > > > Why? isn't XDP supposed to get write access only to the pkt
> > > > > > contents/buffer?
> > > > > >
> > > > >
> > > > > Normally, an XDP program accesses only the packet data. However,
> > > > > there's also an XDP RX Metadata area, referenced by the data_meta
> > > > > pointer. This pointer can be adjusted with bpf_xdp_adjust_meta to
> > > > > point somewhere ahead of the data buffer, thereby granting the XD=
P
> > > > > program access to the virtio header located immediately before th=
e
> > > >
> > > > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_data be=
fore
> > > > xdp->data_hard_start:
> > > >
> > > > https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4=
210
> > > >
> > > > and virtio net set such field after the virtio_net_hdr:
> > > >
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_n=
et.c#L1218
> > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_n=
et.c#L1420
> > > >
> > > > I don't see how the virtio hdr could be touched? Possibly even more
> > > > important: if such thing is possible, I think is should be somewhat
> > > > denied (for the same reason an H/W nic should prevent XDP from
> > > > modifying its own buffer descriptor).
> > >
> > > Thank you for highlighting this concern. The header layout differs
> > > slightly between small and mergeable mode. Taking 'mergeable mode' as
> > > an example, after calling xdp_prepare_buff the layout of xdp_buff
> > > would be as depicted in the diagram below,
> > >
> > >                       buf
> > >                        |
> > >                        v
> > >         +--------------+--------------+-------------+
> > >         | xdp headroom | virtio header| packet      |
> > >         | (256 bytes)  | (20 bytes)   | content     |
> > >         +--------------+--------------+-------------+
> > >         ^                             ^
> > >         |                             |
> > >  data_hard_start                    data
> > >                                   data_meta
> > >
> > > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a little
> > > towards 'data_hard_start', it would point to the inline header, thus
> > > potentially allowing the XDP program to access the inline header.
> >
> > I see. That layout was completely unexpected to me.
> >
> > AFAICS the virtio_net driver tries to avoid accessing/using the
> > virtio_net_hdr after the XDP program execution, so nothing tragic
> > should happen.
> >
> > @Michael, @Jason, I guess the above is like that by design? Isn't it a
> > bit fragile?

Yes.

>
> YES. We process it carefully. That brings some troubles, we hope to put t=
he
> virtio-net header to the vring desc like other NICs. But that is a big pr=
oject.

Yes, and we still need to support the "legacy" layout.

>
> I think this patch is ok, this can be merged to net-next firstly.

+1

Thanks

>
> Thanks.
>
>
> >
> > Thanks!
> >
> > Paolo
> >
>

