Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3600535FC8
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924705; cv=none; b=exjGsbyxsYwHYURfkfGv/eclIgvt1fnmdPD6nHSBOP/YXq8AzVTeyo2DqasB/N8mU4DeFy4qWwm6Zg8dNjBI0gGPqj3lf0fSfKpFf4qUCuhQAMu8WaDqIByC6UedNaXiGxpSC/K/2WBWnZxlFyKHn4WcJx7Jn+Vl4WkTC4qNaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924705; c=relaxed/simple;
	bh=PMk+BA1iV1gVZQS8hgs9PA8z+zdMSKtxYgSZ7oRIY/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tnWz8SKD4E3xKI2wzpZYzLQ2D4DKR4mNIse8bqGwIVIyHiKYC2Vyee6lMjCoRcILDSFxNN3sWYIVLFQdXX0UmIzapgEg7ZJf/rcuQSalgsy2mFnwqZGjKX0PB9JfsEUILJSA5/V+W/RBUL53WfbLOJYkSCnAfgUsYyHOaBe7eaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXvK3g1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXvK3g1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791924702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QcsbmPf6U5Ksxc1MQJeA/MDBAEnBcFQoG0wVwoAmHU=;
	b=fXvK3g1TZz3dMKtpW+ftIoR2Xm+ac6SD9w3CrGW067WfXWNr4FsknU47ug4prSiJ/vq9oM
	UB6KcVLv0SRRWHJ74nNXZaFpl6SyHXcTL7tnLe59R6fntTBeFwSbP2XtEX5zGHdn+sO4DR
	Md/uOgA2QDLnIIO+bIzmhCOi6ECAknY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-TxvPiPdTO3WesX-nOd2HAg-1; Tue, 13 Oct 2026 20:51:41 +0000
X-MC-Unique: TxvPiPdTO3WesX-nOd2HAg-1
X-Mimecast-MFC-AGG-ID: TxvPiPdTO3WesX-nOd2HAg_1791924700
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48af5a07314so2000000f8f.2
        for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 13:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924700; x=1792529500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7QcsbmPf6U5Ksxc1MQJeA/MDBAEnBcFQoG0wVwoAmHU=;
        b=IYJDb8/NmrBokEsKjEvX7kq39W0I3gbr2ttnoY/NaGe/B9+/QIhR+Vd1IjamI3tqlz
         OFC4FUOB6TxWrpa6Vhb6/RAyxlMixuDorSU9J4yzevSHiVs1wzMQzaBLrnDEeqdNawBu
         8jalp7Aj6fsIbsaGgcBfN0fHOgT+rzm4q+agBWkIsAM4WIMlCD98xdvydW4DTSkWsUyF
         ynlFWXqzw6x0wKTJIih45EhZwBeXRKakn0hvlQWitbvlaUj3LaZQxmVBSpiGCs8jOnP5
         H4l2lwyK/eaHXwp+AalQHA+BEar0f3tQHnyfKZ6N+9hySG60LzcCPAlPKeEJrYc/Lb8u
         0x5Q==
X-Forwarded-Encrypted: i=1; AKwUvByKN0RqtNjkTLkzVPGDxqulAvUA7oULMBGV1/KgJQYm6dGLt6wmx1I5J+R2gGrSs4FP8Rc21NU8LOYp4fHzfQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJuZZcUAK6v6heKZ2TMrPQ/dQt+4Q7LuWI5RZ9wv3J2CXTWPrsl
	6CMNvy07xvjF0bmDNyZcOh2NFBwxHnShZAiCIWPAw6wwzUSj471JlEo5S9EV5CTxrjj+5lSX0fk
	FFRJWOV+NnI8+OVQ/kwdKPwByCHqjluE6SqhNSj2XnQP8zjOOLewQSIMULO/qh5c92kO/
X-Gm-Gg: AYBFou335R8ifgMwcN0OCGG/5BHpOfrIg1HBJ5bT5uJGBaIESZROE7o7DxAM9lxh6wz
	F9VdWmK4HezHPbbh9DppywAcW9//Tvc8qqXJNKyFx6iEkZ9umL3coIqZeb+0BHVW6xs65mYN8mL
	weqccvnq7d8kE48xK/kJtWx+rMz9ok6dcdsoUNPRP8g8FJf8yFOS2hSOQ0nUwB2U25zY+/0++69
	YhuvQ0hLYVVsG/wN2/Jh9DDl/Y+LJjYga35uXKZr7p2Yqk+C6/lOHV/c0K6TN+6KHNF48pQo0QL
	5XsaVPa/GC0y7p/C62RKdrBhIC+ksF/BL+VJAwnO7ob6ZOS5xapDFLa6Zx9ZOdafQFpcnQ==
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a18e4adc5cmr281152575e9.16.1791924699964;
        Tue, 13 Oct 2026 13:51:39 -0700 (PDT)
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id 5b1f17b1804b1-4a18e4adc5cmr281152325e9.16.1791924699503;
        Tue, 13 Oct 2026 13:51:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a190344032sm399689525e9.15.2026.10.13.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:51:38 -0700 (PDT)
Date: Tue, 13 Oct 2026 16:51:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at
 ingress
Message-ID: <20261013165004-mutt-send-email-mst@kernel.org>
References: <cover.1791887415.git.mst@redhat.com>
 <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
 <20261013070549-mutt-send-email-mst@kernel.org>
 <CAF=yD-KdTn2rHyp_j8ORr9F5hpm=TzaPRan5+gvLiYBd9HP-sg@mail.gmail.com>
 <20261013143335-mutt-send-email-mst@kernel.org>
 <CAF=yD-Lz92nGVFab1Dq8M9VusDsKf-ioda8KrZoyh28x3Xtg4Q@mail.gmail.com>
 <20261013163706-mutt-send-email-mst@kernel.org>
 <CAF=yD-JKeej85t+sCc_5K0b122uw_LiKWwX1fRL2V-QLrGA8QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAF=yD-JKeej85t+sCc_5K0b122uw_LiKWwX1fRL2V-QLrGA8QA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D_voDzYxs8-Cbuh8CHwHsdzZXXhmqdndMQRVhjUdCI8_1791924700
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Oct 13, 2026 at 02:45:07PM -0600, Willem de Bruijn wrote:
> On Tue, Oct 13, 2026 at 2:38 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 13, 2026 at 02:32:26PM -0600, Willem de Bruijn wrote:
> > > > > > > +
> > > > > > > +     if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> > > > > > > +                                            inner_proto))
> > > > > > > +             return 0;
> > > > > > > +
> > > > > > > +     if (skb_is_gso(skb))
> > > > > > > +             return -EINVAL;
> > > > >
> > > > > This is a risk the commit message will have to call out.
> > > >
> > > > I tried with this:
> > > >
> > > >         > > > We can't easily "complete the checksum" for GSO we don't recognize - GSO
> > > >         > > > assumes knowledge of the protocol. We could segment ignoring the
> > > >         > > > checksum then do whatever csum_start and csum_offset say, but that
> > > >         > > > seems like an overkill for something that should happen.
> > > >
> > > > I guess I can add a more detailed explanation about what the risk is?
> > >
> > > Let's just explicitly mention the consequence: non-standard GSO
> > > packets that previous would be sent may now fail.
> > >
> > > >
> > > > > I don't see a simple way around it. We discussed segmenting here too,
> > > > > but that requires intrusive changes to all callers too.
> > > > > Alternatively,
> > > > >
> > > > > 1. call segmentation, but only to see it remove the SKB_GSO_DODGY and
> > > > > thus verify that the TSO/USO packet is valid. Still drop otherwise.
> > > > > This also does not add overhead, because it would be called later
> > > > > anyway.
> > > > >
> > > > > 2. a failsafe off-by-default sysctl + static_branch that skips the
> > > > > drop when set. Messy, but so is the situation we're dealing with.
> > > >
> > > > Tack this on top or do you feel it's needed straight away.
> > >
> > > Not urgent. Can even wait until a report appears. But worth taking a
> > > look sooner if either of us gets around to it.
> >
> > Maybe if people intend all this for stable, I'll feel safer with this in
> > there.
> >
> > Just to make sure, the branch would just short-circuit all checks, yes?
> 
> Ah option 2, the failsafe? At least any new failures (GSO) that could
> cause regression reports. Operating entirely as before this series
> sounds fine too.

Right. I feel 1 is just as likely to cause regressions. At least 2 gives
us exactly legacy behaviour back.

-- 
MST

