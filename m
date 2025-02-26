Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242215573A
	for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562920; cv=none; b=mS46wx5ZBCkK9hBjivAp6Qbeap9wKbe6itgALXmIDzI0X+ACuhaOsNx7FxzNsEK7cmvtSRumHwNElTYMQv3n3hmwXyHxB9BDpPoRao5ppTORbGgejJluPIVJMGk9jwcEdyiHF9LnDfnPCztunXZPCqNQMPekr5aqIun+70KnqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562920; c=relaxed/simple;
	bh=vlwe3g7egmkzEBkQSzX3LSMTW10UmJaDYSyt6uIJXOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5kkzZeAgBkt3ndANhMhJJkl1penW2JMTkCEaIzV+16lH7MeM30Gq/Pr+fiWkxkEQkUMu+nbDFEKhF0FxpA+ueflq4MSREBZuSmJs2KU32ajYXu4blpTG/HVXdWgRBbI/xliKhRB0ltctdTY+QceTl6gwnmrz2jB3Ve+w8aeqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpKfPp8H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpKfPp8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740562917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35a45e+KUNfgdwWER78OhdI0cbUBUXNz7n/UkAMYBnI=;
	b=EpKfPp8HpxVn8JqCC1ibBn1m2L4+GDqC3siV7m6N0zI5joz/1ibxrLa2eOQAzxuhhJj1qJ
	agFTlelwPPKi5QFAq7yS/MblVSOAzTvyrQQaTdhleSMKLuysf/KZdK/JiiVBIwVrXQG6l+
	F+qEXO0ljfkddEF6hXYykUQheGNi4e0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-oc7fnoWWMDCZKdAuuq7w2Q-1; Wed, 26 Feb 2025 04:41:55 -0500
X-MC-Unique: oc7fnoWWMDCZKdAuuq7w2Q-1
X-Mimecast-MFC-AGG-ID: oc7fnoWWMDCZKdAuuq7w2Q_1740562914
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso21574312a91.1
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 01:41:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562914; x=1741167714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35a45e+KUNfgdwWER78OhdI0cbUBUXNz7n/UkAMYBnI=;
        b=OwKugguV79k+euC8J4dh4iMnlBqzSpIn3PwS3xr0XwlY/gkNvvSt/4ZNS5cXJiEHSa
         pJjuZHtX7rFbv7GJhNvwFplmlmD7XLvttUEdI1WOy6wOdcVUYnzQOm2nnPps1F21hkrU
         8Q8pK49FA9h/KQKgGA4T1OJ4eggZYcLrXa3KIFQhd9ckgPNfFQhD6h3Bra+hPyIAO1dT
         JBVL0ujUbOH/qnAZRP1w79gABCWQLLtjA+8sSADNSKhoEwlyzmVmRkjdT78PyqxX+JGG
         5Y7NAhbiQ112Ae53CmCE+e7DIIaUP02rBKyJVmtn9q93oTwfgHtlNcQ4wYCYfZ0i0N/l
         SsjA==
X-Forwarded-Encrypted: i=1; AJvYcCUrT8P33S7zUSRc3a6nZBJUMx5Ay/jE0COuE4jiF/oqr8gfwsRbU32J8RysjbNdtQpfT7DznXsRerlHgU4pEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPHDkb2wRfrARUacU3F31Dst8/4H5XHZvaBhVNClvsxxKVxB/U
	4nvGkrCkCM72yL/XFxosw1vSN1Cy65Fs1izekItVNA2+WgZXtehXp7lYdCTl20x2K6gv2tCOkLF
	atfROt+vfenUz5qDAIzzzLYmdl5wSnSzOAVUSQ8YsRaIPRSl71yaLbh5rNrOEm6XhFxxYf/fqJr
	5Ags7sdEzsGliAK5V4GbClNS+V4ZOU6Ri4gB/lDOY=
X-Gm-Gg: ASbGncuxhUZQdypmnfSSvlU9yyii/3wFIjd9S2nYXBT0XBQxrU0Bzyhzv6cysvZPRZn
	J0XpNY4zxeGg/5ANDPy0hjT2CwchPoneanOd4kcNnypyit6fW8AnklFZEcCi3Ry2qYbPydEA+pA
	==
X-Received: by 2002:a17:90b:3bcb:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2fe68ae7147mr9875966a91.19.1740562914025;
        Wed, 26 Feb 2025 01:41:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd2VtFq1+EBSUe5YRiKx2c1b8xErNTKsEKpyNpzK8NMUkxluegLLjCSvqusnZyPT8sBH5l6nTPU/LhghJl6kU=
X-Received: by 2002:a17:90b:3bcb:b0:2ea:b564:4b31 with SMTP id
 98e67ed59e1d1-2fe68ae7147mr9875939a91.19.1740562913645; Wed, 26 Feb 2025
 01:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250225020455.212895-1-jdamato@fastly.com> <CAPpAL=w7e8F_0_RRhBuyM-qyaYxgR=miYf_h90j78HzR4dvQxg@mail.gmail.com>
In-Reply-To: <CAPpAL=w7e8F_0_RRhBuyM-qyaYxgR=miYf_h90j78HzR4dvQxg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 17:41:41 +0800
X-Gm-Features: AWEUYZkhxJqSexlmCxlZ4MpaYPDcVZbl2V5cw5njrD7GTgOGPeEvAyX7SCzxTvM
Message-ID: <CACGkMEvaYvrxsbOdiN8tfba4t5vH_L8=5MnZqb_P6qNwv2x0Tw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] virtio-net: Link queues to NAPIs
To: Lei Yang <leiyang@redhat.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, mkarsten@uwaterloo.ca, 
	gerhard@engleder-embedded.com, xuanzhuo@linux.alibaba.com, kuba@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WLNhqTMIZCT1LV_Frg4InjGJIp1Hr0xuw__DbwgS9Sk_1740562914
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:47=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrot=
e:
>
> I tested this series of patches with virtio-net regression tests,
> everything works fine.
>
> Tested-by: Lei Yang <leiyang@redhat.com>

If it's possible, I would like to add the resize (via ethtool) support
in the regression test.

Thanks

>
>
> On Tue, Feb 25, 2025 at 10:05=E2=80=AFAM Joe Damato <jdamato@fastly.com> =
wrote:
> >
> > Greetings:
> >
> > Welcome to v4.
> >
> > Jakub recently commented [1] that I should not hold this series on
> > virtio-net linking queues to NAPIs behind other important work that is
> > on-going and suggested I re-spin, so here we are :)
> >
> > This is a significant refactor from the rfcv3 and as such I've dropped
> > almost all of the tags from reviewers except for patch 4 (sorry Gerhard
> > and Jason; the changes are significant so I think patches 1-3 need to b=
e
> > re-reviewed).
> >
> > As per the discussion on the v3 [2], now both RX and TX NAPIs use the
> > API to link queues to NAPIs. Since TX-only NAPIs don't have a NAPI ID,
> > commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present") now
> > correctly elides the TX-only NAPIs (instead of printing zero) when the
> > queues and NAPIs are linked.
> >
> > See the commit message of patch 3 for an example of how to get the NAPI
> > to queue mapping information.
> >
> > See the commit message of patch 4 for an example of how NAPI IDs are
> > persistent despite queue count changes.
> >
> > Thanks,
> > Joe
> >
> > v4:
> >   - Dropped Jakub's patch (previously patch 1).
> >   - Significant refactor from v3 affecting patches 1-3.
> >   - Patch 4 added tags from Jason and Gerhard.
> >
> > rfcv3: https://lore.kernel.org/netdev/20250121191047.269844-1-jdamato@f=
astly.com/
> >   - patch 3:
> >     - Removed the xdp checks completely, as Gerhard Engleder pointed
> >       out, they are likely not necessary.
> >
> >   - patch 4:
> >     - Added Xuan Zhuo's Reviewed-by.
> >
> > v2: https://lore.kernel.org/netdev/20250116055302.14308-1-jdamato@fastl=
y.com/
> >   - patch 1:
> >     - New in the v2 from Jakub.
> >
> >   - patch 2:
> >     - Previously patch 1, unchanged from v1.
> >     - Added Gerhard Engleder's Reviewed-by.
> >     - Added Lei Yang's Tested-by.
> >
> >   - patch 3:
> >     - Introduced virtnet_napi_disable to eliminate duplicated code
> >       in virtnet_xdp_set, virtnet_rx_pause, virtnet_disable_queue_pair,
> >       refill_work as suggested by Jason Wang.
> >     - As a result of the above refactor, dropped Reviewed-by and
> >       Tested-by from patch 3.
> >
> >   - patch 4:
> >     - New in v2. Adds persistent NAPI configuration. See commit message
> >       for more details.
> >
> > v1: https://lore.kernel.org/netdev/20250110202605.429475-1-jdamato@fast=
ly.com/
> >
> > [1]: https://lore.kernel.org/netdev/20250221142650.3c74dcac@kernel.org/
> > [2]: https://lore.kernel.org/netdev/20250127142400.24eca319@kernel.org/
> >
> > Joe Damato (4):
> >   virtio-net: Refactor napi_enable paths
> >   virtio-net: Refactor napi_disable paths
> >   virtio-net: Map NAPIs to queues
> >   virtio_net: Use persistent NAPI config
> >
> >  drivers/net/virtio_net.c | 100 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 73 insertions(+), 27 deletions(-)
> >
> >
> > base-commit: 7183877d6853801258b7a8d3b51b415982e5097e
> > --
> > 2.45.2
> >
> >
>

