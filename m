Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F22F290E
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770089071; cv=none; b=I+yuSJobBrbh46/wl19RFVoUGEym9OOlJCYjLyswb2rk02j6bsgd29czBlhSHNj9ZMOLLD0wCB3CD/POMzrgQ6mrYj466emmLFdgT+g/MTlm70GiJz+Asw/0TO5DzN6d4M/GIAUY95XwYcz2JCu+9I3QkM/LDzdxP0+6IxufPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770089071; c=relaxed/simple;
	bh=nTjC77z6SKIcEhOAzNzeuTxSi1KokoyynKOgNszG5yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sP7azcUDEjpET+SLz/9iEo2tmavd5qtj6gEASzyoFf6/GzGinZY38xWWsGP8R35ivWEt9yrIqdKoMe2v4+asGB/6e+1D1fGnYmxUAC+qHnVwD5U8zd+CalZZ2oCBU6ytGslp2KdzNc10/ECq+d1fMoGm8gXZtEpzBcSK9nb+QCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nn/nFrDK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn/nFrDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770089068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJzVEzc6/YoB4RVHbPB+0q1BuvrVMg3+v8T2N9Qqszg=;
	b=Nn/nFrDKfVLCX/fY/KS9JHAR5bPpIaBCN+oReyYhWfbZd1IMRfsRQPPDvOKIeYhXmCX+E1
	jOaCppGYzWNWujPb8C3Bopn+ypnuUpNzyDyRbaC8kyU/QUVbOEK62WvkAnRDA4qRjrvw3+
	3s09+m66IHCyCaT/jAAv+7ZIC1RQbyk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-8JIf4jcNO3W-PGyMQ3lnUQ-1; Mon, 02 Feb 2026 22:24:26 -0500
X-MC-Unique: 8JIf4jcNO3W-PGyMQ3lnUQ-1
X-Mimecast-MFC-AGG-ID: 8JIf4jcNO3W-PGyMQ3lnUQ_1770089065
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3545b891dd1so5737469a91.1
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 19:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770089065; x=1770693865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJzVEzc6/YoB4RVHbPB+0q1BuvrVMg3+v8T2N9Qqszg=;
        b=KZ8oYoIEp6n8iNgkZfZ4Y2YGHcNy6FzyKQr519sK+FA9IXdkHpEhAqxqLHg7LYmKJI
         npEtTdArx+7k+Ul7MbKDa3E/1pNI+0hfITW3ZHWwn9dWsrvu7sKIdSWoQdIYcZwH8f7v
         WV1CYytAe+5U31r7uvVa/9R4GBYV0LQIFKJ8ct6RACIrThPj7BQ78KRDHHKWdEbuhzfn
         EIclquDMjoUEjLBqf+YzkkCXOjsV/Io0mD6ijlE83tP+TUT6al/moKO///9iPVh6it/V
         oGA0dNfkJHai93nxstWvLqH8KoNwSS/esWYUoLGaTC9Jlq/LQDfIs5IkvoNy6NMlgBe9
         HKhw==
X-Forwarded-Encrypted: i=1; AJvYcCU1NkIjRoZahetQDQynHwDeAAqjST70k+XKn4xWVN/Ol625bmoZPhYCaIZbbWfdyy6a3+969/RKFa7EMdECfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbqJY+i5XoKqaCiglzrOvYJ7ZJDWzptzUA124T+T+TGu6CUwJT
	n8GbT9GTtZLIFMxQkCDEXKkdnayVCJ6DjoxmebzMiT1AlRaihFA5IXOmf3mEOSrFYbdMNewFtHh
	9vM53tHrHtEdjm4JHOWiKTG65jHdItLBNkkaA/DsccbvWYoFbYNnaPOXCFyBO7EOHDwPpOAAnMf
	wn//xnXcaRlmDQ4l7Ocy24fBg9fOATvDx8hUsybhZR8b0=
X-Gm-Gg: AZuq6aIB2uSlMPP9vQS1d/6qWC8QCOM4N3TwehOk+n4Ycskjn7BFlKb7xxdresfpUVn
	mEmT72tCRHKAfQJVRoE0JDq1XYUIyP1UN45U1HRRwOtLmLVywVbrHLSWnetfo054nvoOb/oHcG+
	oUMUOkgBaiMqYjvuISWpT7hvqHXkbunsGrzAQikmwSg+RGCGMlitrjtMMQwXQat2c0hKY=
X-Received: by 2002:a17:90b:1e02:b0:340:ad5e:cb with SMTP id 98e67ed59e1d1-3543b2dc6cbmr11785535a91.8.1770089065403;
        Mon, 02 Feb 2026 19:24:25 -0800 (PST)
X-Received: by 2002:a17:90b:1e02:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-3543b2dc6cbmr11785518a91.8.1770089064982; Mon, 02 Feb 2026
 19:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de> <willemdebruijn.kernel.37516e24f10fa@gmail.com>
In-Reply-To: <willemdebruijn.kernel.37516e24f10fa@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Feb 2026 11:24:13 +0800
X-Gm-Features: AZwV_Qi7FlBzxKew1vHDwolkROsAaYvuxcledhe6oJ_RgZX3godh2kx2XLbJePY
Message-ID: <CACGkMEsqobRMhtz3LUuWu3O1njK9jU7oQ65OOyy9vHcZ_QLz4A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uBb03D6ZyXDV8fKaxugacDcywATSRvvy4-XY53xSPso_1770089065
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 5:06=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Steffen Trumtrar wrote:
> > Add optional hardware rx timestamp offload for virtio-net.
> >
> > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > virtio-net header is expanded with room for a timestamp.
> >
> > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need
> > to be implemented. This allows filtering the packets and only time stam=
p
> > the packets where the filter matches. This way, the timestamping can
> > be en/disabled at runtime.
> >
> > Tested:
> >   guest: ./timestamping eth0 \
> >           SOF_TIMESTAMPING_RAW_HARDWARE \
> >           SOF_TIMESTAMPING_RX_HARDWARE
> >   host: nc -4 -u 192.168.1.1 319
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >
> > --
> >   Changes to last version:
> >   - rework series to use flow filters
> >   - add new struct virtio_net_hdr_v1_hash_tunnel_ts
> >   - original work done by: Willem de Bruijn <willemb@google.com>
> > ---
> >  drivers/net/virtio_net.c        | 136 ++++++++++++++++++++++++++++++++=
++++----
> >  include/uapi/linux/virtio_net.h |   9 +++
> >  2 files changed, 133 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1bb3aeca66c6e..4e8d9b20c1b34 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -429,6 +429,9 @@ struct virtnet_info {
> >       struct virtio_net_rss_config_trailer rss_trailer;
> >       u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> >
> > +     /* Device passes time stamps from the driver */
> > +     bool has_tstamp;
> > +
> >       /* Has control virtqueue */
> >       bool has_cvq;
> >
> > @@ -475,6 +478,8 @@ struct virtnet_info {
> >
> >       struct control_buf *ctrl;
> >
> > +     struct kernel_hwtstamp_config tstamp_config;
> > +
> >       /* Ethtool settings */
> >       u8 duplex;
> >       u32 speed;
> > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> >               struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> >               struct virtio_net_hdr_v1_hash hash_v1_hdr;
> >               struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > +             struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
>
> Jason, Michael: creating a new struct for every field is not very
> elegant. Is it time to find a more forward looking approach to
> expanding with new fields? Like a TLV, or how netlink structs like
> tcp_info are extended with support for legacy users that only use
> a truncated struct?

I fully agree, we need somebody to work on this.

Thanks

