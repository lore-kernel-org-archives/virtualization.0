Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71438330E
	for <virtualization@lists.linux.dev>; Fri,  7 Aug 2026 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786080249; cv=pass; b=XAycuUrAKjD3VscsJS/tAoFdoAKdj4JDiEV9skZDxkIDYjkIknlvADFcnbp2OydA2YyDfcO1mccIX4bYW5W/1jEP9t/5d3+CpKPgSZZVFPyYIxPTAl0SQVPCoH0+hc0Gdhc1iCuxQR5mE0UDMyM/mwVVvL4eY9F0VDmKHQkLw6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786080249; c=relaxed/simple;
	bh=/qvEecEMyOi542WJRYMMRzy+QAliMqatuH7VPufRODw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbeI4u5T3GlSU8oz4Q9bKxuXjypYxnyISwXGsrziI2CKBklxKlcFZlN8emUtJeZf0jcLs9+v7+zeK21Tn5gWSxdTA8IxpKMifP8F70C1nrnrYmyRfnJRJybCo5eqYcRcEvVbabPemhvhiPnZL+4WT4CcVwsIwyKNdixJK0GvjsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km0wenIk; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km0wenIk"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b159850b16so2870336e87.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 22:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786080244; cv=none;
        d=google.com; s=arc-20260327;
        b=ZqHnh1kgwSiLxPe9GEO+zm7DAuVsUHakvrI+d5l4/Lha76BWT/c87o+wFpJnSi7b1f
         iEnEddoPVZAlCO6exp4BjhoskVIpvj4wti9jDMM730OxlNH1dk86OgiO3FFP+tXEvJaz
         DYpgC4MilgAVvdeq713QMY1Q3Bg2pkCd4ynK9mUTjTRttoRpu1swdqrjYrfB9SfhBHou
         c/PyJTSg+b9H5WMTCsQqrkk5F26X2F3mm+ZATCD8WxyP0YwnBMOm47NfBCDcFDxucA+1
         gbDJwbQ/L38dQ/NnY6PUfViyG7bIFi7toEepTLcHtpjfg26xgjj6NFD+Cws2VudCNky3
         070Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uijGZVvSATzvrVnVp0OH7XFf3Ki325iqaFC2kD6QkJ8=;
        fh=JKSVmI2GwknHdJlgRJyteW7TecHeQEyTGwt4AW8UXfc=;
        b=qfoYRFAU+4pw0XHPNxWaTDc4plPK5dWcjP1jy+pnpIqa/qA4vYh7dP5m0IrmbhmNts
         EqYlmXsv8hOaI8yOK212Xxhap8g3kJ73Wj1oWjnwMm/gc/w8kKbweHFTRum9+2heUYNV
         YjNna082Ndz+h101XYzYdKmZbyi849Flk67AUTMgPTSd9kUJFhLY3Cgyt7JtikwPMfjG
         q7qbEIqUpes90QRiv04pgVNwgOn6eXH9OgkhMG0bA23g96huZWkvvCxzllUNJo/T/1+r
         etzEmuQ/vrrLNzmLzjMEldKXteQIXGarhdBYsJkgdIPkg7qwUTV8XigpRZyFyPj6lpD4
         kUSQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786080244; x=1786685044; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uijGZVvSATzvrVnVp0OH7XFf3Ki325iqaFC2kD6QkJ8=;
        b=Km0wenIkGRtYWCczDGxMLq4yS5bBCxwAtjQHS64vKx7Ov4FLcFchOWHYvUuftPyqn2
         99KAdMfFFtXyClWYr6H3DeKJEBahJ+BWqwFSFt4EvZI/YmGuoFaIPouISL4T0iEym8xd
         xB3w2R7G+hpUfoBHNOaqKX3qmtG8BW/3FV5Q5dXisM9zv/JjKTtMjWXiQN1oeTXNDyn8
         QwPxUh3V5tw2JSoKtEnjfaH/5n+TqCYqKhI54GqRHdbhYFoTMP9Qmpsi5wFpQa4n1olV
         eEkncGCEc97ADX6LWKLYRdEx1zvOwPnVxPIjFT/kSnS++qOX4XeR1kjBYnzzX0HjeaoP
         lYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786080244; x=1786685044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uijGZVvSATzvrVnVp0OH7XFf3Ki325iqaFC2kD6QkJ8=;
        b=PZquGPdf1Un37fLcW/wlAiaCt6lMrWP1pluwqeeMz9xzwvGQirEej5U12vumBb+10p
         jRHqMud9kndnUsShu7fDws29EPZW7VI359G2+7qZf1Gy3+QYbE/qqN68G9obnVDYRERt
         dp6XHC4tZhBtgkA2fdeTt99whAeIXTVlViUTKBfe5xzuY5zotGoAJJgK/k03HfKjlzX8
         wSBBIdAFWg/mCb8Y0BzBd0cuZBjYXa690fN+Ga1i0o/I2gU9O6vOHMevk/LTocsVqaAk
         H6TbUC9XcHlIKQJbfJBoUtHish1fFocwiZ8Al5OOpMRAn/Gj4zHb8OobSr4Uq0ggOhW0
         FuZg==
X-Forwarded-Encrypted: i=1; AHgh+RoaDbDY+smZGoUC/uCaXOMJFZ7aXEyLbuMcLL3ZG4lGyAoJNP9atZU+XtkgNfajVF8GKBSuJoX60U72g8Glpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJVOWKU2QYXlTlrxhUgiJFLVCqZeLcp4rTKDwfqU6E5DZzPcHk
	cBUMroruORO2PJiSBVNjGRVoLwzlBZW2oTaT4XKn4RlUHA1XnX2cAWGTz1sFemtSj2GLaL3em1t
	kFb+VsoDCXcxldGu1mrs4R4eN+8ytglE=
X-Gm-Gg: AR+sD11RiKsqwOuSlkQ+PWHcdPOh1aXAcrb7V8+rYu+uu7PKTMQbSZbSzgEnhjul++j
	GVvuHa6aEpNQN5qwmrHuPqaUROznsDD8r5u6cIKNmrrYwwMFBHsU6l8GD+u5A+BEESRvOvAvzqr
	IiBv7L5+8Xgv5nClsIADFlZneowLkfRozIxS0VbS8G6yQ2aL1C+IUj8IMDfQhwLSfnMsAHffMX4
	Z+uOEHM38zk08UrAzMJnVkk5rZ1kSgoDGrfuD2O6RNBhARh6XD9wcNKoRzNs/dowHDC8HCzQKWN
	Fg9uVYAjk9robIWGfADyzjlJAiaAsdxvEfnKi3ikqLRppgy4Ga9GPwQ+4mER9VI96Rh97lWB+HF
	4zIzu/KwdDUF0qW8n2+b6OY7XoHrOFnBFxqQrxYxvdqJBaCBQg/xJVToxxlM=
X-Received: by 2002:a05:6512:31c7:b0:5ae:bcc4:c071 with SMTP id
 2adb3069b0e04-5b2f4ae81a7mr2718810e87.0.1786080243491; Thu, 06 Aug 2026
 22:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260804085330.1333242-1-xiongweimin@kylinos.cn> <20260806160410.2689091-1-kuba@kernel.org>
In-Reply-To: <20260806160410.2689091-1-kuba@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Aug 2026 13:23:24 +0800
X-Gm-Features: AUfX_mx4bReQpJiFf032E4v-MIpmmPYimASFStvuaH9sZiJsUvBsJhvKU5xM0ZM
Message-ID: <CAL+tcoBR3Nn8KE=pGOUg+ey1X_sqcFkkOjAJHrnU-BDA2=HP7g@mail.gmail.com>
Subject: Re: [PATCH net 1/2] virtio_net: check AF_XDP queue index before use
To: Jakub Kicinski <kuba@kernel.org>
Cc: xiongweimin@kylinos.cn, mst@redhat.com, jasowangio@gmail.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> virtio_net: check AF_XDP queue index before use
>
> This moves the qid >=3D vi->curr_queue_pairs test in
> virtnet_xsk_pool_enable() so that it runs before the vi->rq[qid].page_poo=
l
> check instead of after it.  The rest of the function is unchanged.
>
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 3e2a5876c6c8c..6160aa8ba595e 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -5896,15 +5896,15 @@ static int virtnet_xsk_pool_enable(struct net_d=
evice *dev,
> >       if (vi->hdr_len > xsk_pool_get_headroom(pool))
> >               return -EINVAL;
> >
> > +     if (qid >=3D vi->curr_queue_pairs)
> > +             return -EINVAL;
> > +
> >       /* In big_packets mode, xdp cannot work, so there is no need to
> >        * initialize xsk of rq.
> >        */
> >       if (!vi->rq[qid].page_pool)
> >               return -ENOENT;
> >
> > -     if (qid >=3D vi->curr_queue_pairs)
> > -             return -EINVAL;
> > -
>
> [Severity: Medium]
> The changelog says this "keeps an out of range queue id from reaching
> vi->rq[qid] while checking page_pool".  Was an out of range qid actually
> reachable here?
>
> vi->rq and vi->sq are sized max_queue_pairs in virtnet_alloc_queues():
>
>         vi->sq =3D kzalloc_objs(*vi->sq, vi->max_queue_pairs);
>         ...
>         vi->rq =3D kzalloc_objs(*vi->rq, vi->max_queue_pairs);
>
> and the netdev is created with alloc_etherdev_mq(..., max_queue_pairs), s=
o
> dev->num_rx_queues =3D=3D dev->num_tx_queues =3D=3D max_queue_pairs.
>
> The only path into virtnet_xsk_pool_enable() is
> xp_assign_dev() -> ndo_bpf(XDP_SETUP_XSK_POOL) -> virtnet_xsk_pool_setup(=
),
> and xp_assign_dev() first goes through xsk_reg_pool_at_qid() in
> net/xdp/xsk.c:
>
>         if (queue_id >=3D max(dev->real_num_rx_queues,
>                             dev->real_num_tx_queues))
>                 return -EINVAL;
>
> real_num_rx_queues/real_num_tx_queues can never exceed num_rx_queues/
> num_tx_queues, so any qid that reaches the driver is already inside the
> allocated arrays and vi->rq[qid].page_pool was an in-bounds read.
>
> For a qid in [curr_queue_pairs, max_queue_pairs) the old ordering still
> rejected the request before sq/rq were used, so the only visible differen=
ce
> after the reorder appears to be -EINVAL instead of -ENOENT.  Could the
> changelog describe this as a defensive reordering rather than as preventi=
ng
> an out of range dereference?  As written it reads like a memory safety fi=
x
> and may attract a stable backport.

Point taken. Sashiko is good at finding things like this stuff...

I don't see the necessity to keep this patch then.

Thanks,
Jason
